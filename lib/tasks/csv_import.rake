require 'csv'
require 'open-uri'

namespace :csv do
  desc 'import vols data from dropbox'
  task import_vols: :environment do
    begin
      DataLink.delete_all

      open('links.zip', 'wb') do |file|
        file << open(ENV['link_url']).read
      end

      Archive::Zip.extract('links.zip', '.', :password => DBENV['link_password'])

      csv = CSV.read('links.csv', headers: true)
      csv.each do |row|
        data_link = DataLink.find_or_initialize_by(vol: row['vol'].to_i, stype: row['type'])
        data_link.link = row['link']
        data_link.password = row['password']
        data_link.save!
      end

      File.delete('links.zip', 'links.csv')
    rescue Exception => e
      p e
    end

  end
end
