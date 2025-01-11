# frozen_string_literal: true

module Kimi
  class AppApi < BaseApi
    BASE = 'https://api.moonshot.cn/'

    def file_create
      post 'v1/files'
    end

  end
end
