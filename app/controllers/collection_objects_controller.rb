class CollectionObjectsController < ApplicationController
  before_action :set_collection_object, only: [:show, :update, :fullsize]
  before_action :set_searchable_attributes, only: [:index, :show, :fullsize]
  before_action :set_page, only: [:index, :show, :fullsize]
  before_action :set_viewable_fields, only: [:show]

  def index
    @collectionobjects = CollectionObject.order(origin_updated_at: :desc).page @page
  end

  def show
  end

  def update
    if @collectionobject.has_been_updated?
      @collectionobject.update(@collectionobject.remote_metadata_attributes)
      flash[:success] = "Record has been updated."
      redirect_to record_url @collectionobject
    else
      flash[:info] = "#{@collectionobject.object_number} does not require an update at this time."
      redirect_to record_url @collectionobject
    end
  end

  def fullsize
  end

  private

  def set_collection_object
    @collectionobject = CollectionObject.find(params[:id])
  end

  def set_page
    @page = (params[:page] or params[:from_page]) || 1
  end
end
