class SearchController < ApplicationController
  before_action :set_searchable_attributes, only: [:index]

  def index
    query = params[:query]
    if params[:field] == "all" or query.blank?
      @collectionobjects = CollectionObject.search(query).page params[:page]
    else
      field = params[:field]
      @collectionobjects = CollectionObject.advanced_search(field, query).page params[:page]
    end
  end
end