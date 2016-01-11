require 'csv'
require 'open-uri'

namespace :csv do
  desc 'import vols data from dropbox'
  task import_vols: :environment do
    csv = CSV.parse(open('https://www.dropbox.com/s/5cnreyvp1g9u7ow/links.csv?dl=1').read, headers: true)
    csv.each do |row|
      data_link = DataLink.find_or_initialize_by(vol: row['vol'].to_i)
      data_link.link = row['link']
      data_link.save!
    end
  end
end