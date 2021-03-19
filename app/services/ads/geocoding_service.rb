module Ads
  class GeocodingService
    prepend BasicService

    option :ad
    attr_reader :job_id

    # NOTE: тут будет взаимодействие с сервисом геокодирования
    # преедполагается, что взаимодействие будет через очередь
    # сервис будет отправлять задавие в очередь и возвращать id этого задания(но это не точно)
    def call
      @job_id = Random.srand
    end
  end
end
