
namespace :db do
  desc 'Import User, Sessions and HRM points'
  task :import_data => :environment do
    require "csv"
    puts 'Downloading seeds'
    # implement download
    puts 'Download completes'

    # Wipe users
    User.destroy_all

    # Seed users
    CSV.foreach('tmp/storage/users.csv', headers: true) do |user_row|
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
        hr_zone3_bpm_max: user_row['HR Zone3 BPM Max']

      puts user.save
    end

  end
end