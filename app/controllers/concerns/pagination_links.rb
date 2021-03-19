module PaginationLinks
  def pagination_links(scope)
    return {} if scope.page_count.zero?

    links = {
      first: pagination_link(page: 1),
      last: pagination_link(page: scope.page_range.max)
    }

    links[:next] = pagination_link(page: scope.next_page) if scope.next_page.present?
    links[:prev] = pagination_link(page: scope.prev_page) if scope.prev_page.present?

    links
  end

  private

  def pagination_link(page:)
    "/?page=#{page}"
  end
end
