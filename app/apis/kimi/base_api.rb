# frozen_string_literal: true

module Kimi
  class BaseApi
    include CommonApi

    def with_access_token(params: {}, headers: {}, payload: {}, with_options: {})
      @client = @client.plugin(:auth).bearer_auth @app.secret
      yield
    end
  end
end
