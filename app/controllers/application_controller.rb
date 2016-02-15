class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def set_searchable_attributes
    @searchable_attributes = AttributeMap.where(record_type: 'collectionobject', searchable: true).order(:field)
  end

  def set_viewable_fields
    @viewable_fields = AttributeMap.where(viewable: true).pluck(:field)
  end
end
