class CollectionObjectsController < ApplicationController
  def index
  end

  def show
    @collectionobject = CollectionObject.find(params[:id])
  end
end
