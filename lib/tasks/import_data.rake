
namespace :db do
  desc 'Ingest Users'
  task :ingest_users => :environment do
    process_batches(file: 'tmp/storage/users.csv', batch_size: 1000, thread_limit: 10) do |index, user_chunk|
      puts "Starting batch ##{index}"
      result = create_users(user_chunk)
      puts "Batch ##{index} finished. (#{result[:success_count]}) successes and (#{result[:failure_count]}) failures"
    end
  end

  desc 'Ingest Sessions'
  task :ingest_sessions => :environment do
    process_batches(file: 'tmp/storage/hrm_sessions.csv', batch_size: 1000, thread_limit: 10) do |index, session_chunk|
      puts "Starting batch ##{index}"
      result = create_sessions(session_chunk)
      puts "Batch ##{index} finished. (#{result[:success_count]}) successes and (#{result[:failure_count]}) failures"
    end
  end

  desc 'Ingest Data Points'
  task :ingest_data_points => :environment do
    queue = []

    Thread.new do
      index = 0
      CSV.open('tmp/storage/hrm_data_points.csv', headers: true).lazy.each_slice(1000) do |rows|
        queue << [index, rows]
        index = index + 1
      end
    end

    Parallel.map(Proc.new { queue.shift }, in_processes: 10) do |batch|
      if batch.blank?
        sleep(1)
        next
      end

      puts "Starting batch ##{batch.first}"
      result = create_data_points(batch.last)
      puts "Batch ##{batch.first} finished with (#{result[:success_count]}) successes" \
            " and (#{result[:failure_count]}) failures"
    end
  end

  desc 'Wipe Users, Sessions and Data Points'
  task :wipe_data => :environment do
    puts 'Wiping Data Points'
    # DataPoint.where.not(session_id: nil).destroy_all
    puts 'Wiping Sessions'
    # Session.destroy_all
    puts 'Wiping users'
    # User.destroy_all
  end

  def process_batches(file:, batch_size: 1000, thread_limit: 10)
    queue = []

    Thread.new do
      index = 0
      CSV.open(file, headers: true).lazy.each_slice(batch_size) do |rows|
        queue << [index, rows]
        index = index + 1
      end
    end

    Parallel.map(Proc.new { queue.shift }, in_processes: thread_limit) do |batch|
      raise Parallel::Break if batch.blank?

      yield(batch.first, batch.last) if block_given?
    end
  end

  def create_users(users_chunk)
    ActiveRecord::Base.connection.reconnect! unless Rails.env.test?

    success_count = failure_count = 0
    users_chunk.each do |user_row|
      user = User.new \
        id: user_row['User ID'],
        username: user_row['Username'],
        gender: user_row['Gender'],
        age: user_row['Age'],
        created_at: user_row['Created At'],
        updated_at: user_row['Created At'],
        hr_zone1_bpm_min: user_row['HR Zone1 BPM Min'],
        hr_zone1_bpm_max: user_row['HR Zone1 BPM Max'],
        hr_zone2_bpm_min: user_row['HR Zone2 BPM Min'],
        hr_zone2_bpm_max: user_row['HR Zone2 BPM Max'],
        hr_zone3_bpm_min: user_row['HR Zone3 BPM Min'],
        hr_zone3_bpm_max: user_row['HR Zone2 BPM Max']

      user.save ? success_count += 1 : failure_count += 1
    end

    { success_count:, failure_count: }
  end

  def create_sessions(sessions_chunk)
    ActiveRecord::Base.connection.reconnect! unless Rails.env.test?

    success_count = failure_count = 0
    sessions_chunk.each do |session_row|
      session = Session.new \
        id: session_row['Session ID'],
        user_id: session_row['User Id'],
        duration_in_seconds: session_row['Duration in Secs'],
        created_at: session_row['Created At'],
        updated_at: session_row['Created At']

      session.save ? success_count += 1 : failure_count += 1
    end

    { success_count:, failure_count: }
  end

  def create_data_points(data_points_chunk)
    ActiveRecord::Base.connection.reconnect! unless Rails.env.test?

    success_count = failure_count = 0
    data_points_chunk.each do |data_point_row|
      data_point = DataPoint.new \
        session_id: data_point_row['Session ID'],
        beats_per_minute: data_point_row['Beats Per Minute'],
        duration_in_seconds: data_point_row['Duration in Secs'],
        reading_started_at: data_point_row['Reading Start Time'],
        reading_ended_at: data_point_row['Reading End Time']

      data_point.save ? success_count += 1 : failure_count += 1
    end

    { success_count:, failure_count: }
  end
end