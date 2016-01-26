require 'rails_helper'
require 'rake'

describe 'csv' do
  describe ':import_vols' do
    let(:csv) { "vol,link,type,password\n1,http://dummy.com/vol_1.csv,type1,password1" }
    let(:data_link) { DataLink.last }
    subject { Rake::Task["csv:import_vols"] }

    before do
      load File.expand_path("../../../lib/tasks/csv_import.rake", __FILE__)
      Rake::Task.define_task(:environment)
      expect_any_instance_of(Object).to receive(:open)
      expect(Archive::Zip).to receive(:extract).with('links.zip', '.', :password => ENV['link_password'])
      expect(CSV).to receive(:read).and_return(CSV.parse(csv, headers: true))
      expect(File).to receive(:delete).with('links.zip', 'links.csv')
    end

    it 'creates new data links from csv' do
      expect {
        subject.invoke
      }.to change(DataLink, :count).by 1
      expect(data_link.vol).to eq 1
      expect(data_link.link).to eq "http://dummy.com/vol_1.csv"
      expect(data_link.stype).to eq "type1"
      expect(data_link.password).to eq "password1"
    end
  end
end
