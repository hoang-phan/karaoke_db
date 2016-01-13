require 'rails_helper'

describe DataLinksController, type: :controller do
  describe 'GET index' do
    let(:expected_result) do
      [
        {
          'vol' => vol,
          'link' => link,
          'updated_at' => data_link.updated_at.to_i
        }
      ]
    end

    let(:json) { JSON(response.body) }
    let!(:data_link) { create(:data_link, vol: vol, link: link) }
    let(:vol) { 1 }
    let(:link) { 'http://test.com' }

    it 'returns correct json' do
      get :index
      expect(json['data_links']).to eq expected_result
    end
  end
end