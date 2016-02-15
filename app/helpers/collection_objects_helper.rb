module CollectionObjectsHelper
  def field_to_s(collectionobject, attribute)
    field = collectionobject.send(attribute.to_sym)
    field = field.map(&:strip)
      .reject(&:empty?)
      .map{ |f| link_to f, search_path(field: attribute, query: f) }
      .join(", ") if field.respond_to? :each
    field.to_s.html_safe
  end
end
