
namespace :db do
  desc 'Ingest Users'
  task :ingest_users => :environment do
    process_batches(file: 'tmp/storage/users.csv', batch_size: 1000, thread_limit: 10) do |index, chunk|
      puts "Starting batch ##{index}"
      result = create_users(chunk)
      puts "Batch ##{index} finished. (#{result[:success_count]}) successes and (#{result[:failure_count]}) failures"
    end
  end

  desc 'Ingest Sessions'
  task :ingest_sessions => :environment do
    process_batches(file: 'tmp/storage/hrm_sessions.csv', batch_size: 1000, thread_limit: 10) do |index, chunk|
      puts "Starting batch ##{index}"
      result = create_sessions(chunk)
      puts "Batch ##{index} finished. (#{result[:success_count]}) successes and (#{result[:failure_count]}) failures"
    end
  end

  desc 'Ingest Data Points'
  task :ingest_data_points => :environment do
    process_batches(file: 'tmp/storage/hrm_data_points.csv', batch_size: 1000, thread_limit: 10) do |index, chunk|
      puts "Starting batch ##{index}"
      result = create_data_points(chunk)
      puts "Batch ##{index} finished. (#{result[:success_count]}) successes and (#{result[:failure_count]}) failures"
    end
  end

  desc 'Wipe Users, Sessions and Data Points'
  task :wipe_users => :environment do
    puts 'Wiping users'
    User.delete_all
  end

  desc 'Wipe Sessions'
  task :wipe_sessions => :environment do
    puts 'Wiping Sessions'
    HrmSession.delete_all
  end

  desc 'Wipe Data Points'
  task :wipe_data_points => :environment do
    puts 'Wiping Data Points'
    HrmDataPoint.delete_all
  end

  def process_batches(file:, batch_size: 1000, thread_limit: 10)
    queue = []

    Thread.new do
      index = 0
      CSV.open(file, headers: true).lazy.each_slice(batch_size) do |rows|
        queue << [index, rows]
        index = index + 1
      end
      queue << -1
    end

    Parallel.map(Proc.new { queue.shift }, in_processes: thread_limit) do |batch|
      raise Parallel::Break if batch == -1

      if batch.blank?
        sleep 1
        next
      end

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
        hr_zone1_bpm_min: user_row['HR Zone1 BPM Min'],
        hr_zone1_bpm_max: user_row['HR Zone1 BPM Max'],
        hr_zone2_bpm_min: user_row['HR Zone2 BPM Min'],
        hr_zone2_bpm_max: user_row['HR Zone2 BPM Max'],
        hr_zone3_bpm_min: user_row['HR Zone3 BPM Min'],
        hr_zone3_bpm_max: user_row['HR Zone3 BPM Max'],
        hr_zone4_bpm_min: user_row['HR Zone4 BPM Min'],
        hr_zone4_bpm_max: user_row['HR Zone4 BPM Max']

      user.save ? success_count += 1 : failure_count += 1
    end

    { success_count:, failure_count: }
  end

  def create_sessions(sessions_chunk)
    ActiveRecord::Base.connection.reconnect! unless Rails.env.test?

    success_count = failure_count = 0
    sessions_chunk.each do |session_row|
      session = HrmSession.new \
        id: session_row['Session ID'],
        user_id: session_row['User Id'],
        duration_in_seconds: session_row['Duration in Secs'],
        created_at: session_row['Created At']

      session.save ? success_count += 1 : failure_count += 1
    end

    { success_count:, failure_count: }
  end

  def create_data_points(data_points_chunk)
    ActiveRecord::Base.connection.reconnect! unless Rails.env.test?

    success_count = failure_count = 0
    data_points_chunk.each do |data_point_row|
      data_point = HrmDataPoint.new \
        hrm_session_id: data_point_row['Session ID'],
        beats_per_minute: data_point_row['Beats Per Minute'],
        duration_in_seconds: data_point_row['Duration in Secs'],
        reading_started_at: data_point_row['Reading Start Time'],
        reading_ended_at: data_point_row['Reading End Time']

      data_point.save ? success_count += 1 : failure_count += 1
    end

    { success_count:, failure_count: }
  end
end