class MyApp < Sinatra::Base
  get '/' do
    "Hello index!"
  end

  post '/' do
    'Yo, u can post!'
  end

end

# skip_before_action :auth_user, only: %i[index]
#
#   def index
#     ads = Ad.order(updated_at: :desc).page(params[:page])
#     serializer = AdSerializer.new(ads, links: pagination_links(ads))
#
#     render json: serializer.serialized_json
#   end
#
#   def create
#     result = Ads::CreateService.call(
#       ad: ad_params,
#       user: current_user
#     )
#
#     if result.success?
#       serializer = AdSerializer.new(result.ad)
#       render json: serializer.serialized_json, status: :created
#     else
#       error_response(result.ad, :unprocessable_entity)
#     end
#   end
#
#   private
#
#   def ad_params
#     params.require(:ad).permit(:title, :description, :city)
#   end
