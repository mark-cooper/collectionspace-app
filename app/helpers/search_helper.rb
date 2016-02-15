module SearchHelper
  def get_searchable_attributes_for_select
    @searchable_attributes.collect{ |a| [t("collectionobject.#{a.field}"), a.field] }
      .unshift([ "All", "all" ])
  end

  def get_searchable_attribute_default
    params[:field]
  end

  def query_placeholder_text
    (params[:query].nil? or params[:query].blank?) ? t("search.placeholder") : params[:query]
  end
end