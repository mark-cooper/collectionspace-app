class CollectionObjectsController < ApplicationController
  def index
    @collectionobjects = CollectionObject.order(origin_updated_at: :desc)
    @attribute_map     = AttributeMap.where(record_type: 'collectionobject', searchable: true).order(:field)
  end

  def show
    @collectionobject = CollectionObject.find(params[:id])
    @attribute_map    = AttributeMap.where(record_type: 'collectionobject').pluck(:field) # viewable true
  end

  def update
    @collectionobject = CollectionObject.find(params[:id])
    if @collectionobject.has_been_updated?
      @collectionobject.update(@collectionobject.remote_metadata_attributes)
      flash[:success] = "Record has been updated."
      redirect_to record_url @collectionobject
    else
      flash[:info] = "#{@collectionobject.object_number} does not require an update at this time."
      redirect_to record_url @collectionobject
    end
  end
end
