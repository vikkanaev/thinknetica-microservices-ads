class MyApp < Sinatra::Base
  include PaginationLinks
  include ApiErrors

  ADS_PER_PAGE = 4.freeze

  before { content_type 'application/json' }
  error { handle_exception(env['sinatra.error']) }

  # index
  get '/' do
    page = params.fetch("page", 1).to_i
    ads = Ad.page(page,ADS_PER_PAGE)
    serializer = AdSerializer.new(ads.all, links: pagination_links(ads))
    serializer.serialized_json
  end

  # create
  post '/' do
    result = Ads::CreateService.call(ad: ad_params)

    if result.success?
      serializer = AdSerializer.new(result.ad)
      status 201
      body serializer.serialized_json
    else
      error_response(result.ad, 422)
    end
  end

  private

  # TODO: Упростить. Например, парсинг тела запроса можно вынести в хэлпер.
  def ad_params
    input = JSON.parse(request.body.read).symbolize_keys
    hash = input[:ad].symbolize_keys.slice(:title,:description,:city, :user_id)
    hash.merge(user_id: hash[:user_id].present? ? hash[:user_id].to_i : nil)
  end
end
