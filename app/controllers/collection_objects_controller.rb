class CollectionObjectsController < ApplicationController
  def index
    @collectionobjects = CollectionObject.order(updated_at: :desc)
    @attribute_map     = AttributeMap.where(record_type: 'collectionobject', searchable: true).order(:field)
  end

  def show
    @collectionobject = CollectionObject.find(params[:id])
  end
end
