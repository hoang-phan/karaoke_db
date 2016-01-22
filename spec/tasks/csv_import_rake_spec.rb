require 'rails_helper'
require 'rake'

describe 'csv' do
  describe ':import_vols' do
    let(:csv) { "vol,link,type\n1,http://dummy.com/vol_1.csv,type1" }
    let(:data_link) { DataLink.last }
    subject { Rake::Task["csv:import_vols"] }

    before do
      load File.expand_path("../../../lib/tasks/csv_import.rake", __FILE__)
      Rake::Task.define_task(:environment)
      expect_any_instance_of(Object).to receive(:open).and_return(double(read: csv))
    end

    it 'creates new data links from csv' do
      expect {
        subject.invoke
      }.to change(DataLink, :count).by 1
      expect(data_link.vol).to eq 1
      expect(data_link.link).to eq "http://dummy.com/vol_1.csv"
      expect(data_link.stype).to eq "type1"
    end
  end
end