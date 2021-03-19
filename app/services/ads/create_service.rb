module Ads
  class CreateService
    prepend BasicService

    option :ad do
      option :title
      option :description
      option :city
      option :user_id
    end

    attr_reader :ad

    def call
      @ad = ::Ad.new(@ad.to_h)
      return fail!(@ad.errors) unless @ad.valid?

      @ad.save
      Ads::GeocodingService.call(ad: @ad)
    end
  end
end
