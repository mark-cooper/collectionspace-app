module SearchHelper
  def query_placeholder_text
    (params[:query].nil? or params[:query].blank?) ? "Enter search terms ..." : params[:query]
  end
end