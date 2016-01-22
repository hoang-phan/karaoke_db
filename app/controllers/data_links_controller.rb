class DataLinksController < ApplicationController
  def index
    render json: { data_links: data_links }
  end

  private

  def data_links
    DataLink.all.map do |data_link|
      data_link.attributes.slice(*%w(vol link stype)).merge(updated_at: data_link.updated_at.to_i)
    end
  end
end