class SearchController < ApplicationController
  def index
    @searchable_attributes = AttributeMap.where(record_type: 'collectionobject', searchable: true).order(:field)
    query = params[:query]
    if params[:field] == "all"
      @collectionobjects = CollectionObject.search(query).page params[:page]
    else
      field = params[:field]
      @collectionobjects = CollectionObject.advanced_search(field, query).page params[:page]
    end
  end
end