class SearchController < ApplicationController
  def index
    @attribute_map     = AttributeMap.where(record_type: 'collectionobject', searchable: true).order(:field)
    query = params[:query]
    if params[:field] == "all"
      @collectionobjects = CollectionObject.search(query)
    else
      field = params[:field]
      @collectionobjects = CollectionObject.advanced_search(field, query)
    end
  end
end