class DataLinksController < ApplicationController
  def index
    render json: { data_links: DataLink.all.map { |data_link| data_link.attributes.slice(*%w(vol link)) } }
  end
end