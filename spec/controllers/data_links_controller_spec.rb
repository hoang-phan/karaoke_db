require 'rails_helper'

describe DataLinksController, type: :controller do
  describe 'GET index' do
    let(:json) { JSON(response.body) }
    let!(:data_link) { create(:data_link, vol: vol, link: link) }
    let(:vol) { 1 }
    let(:link) { 'http://test.com' }
   
    it 'returns correct json' do
      get :index
      expect(json['data_links']).to eq [{'vol' => vol, 'link' => link}]
    end
  end
end