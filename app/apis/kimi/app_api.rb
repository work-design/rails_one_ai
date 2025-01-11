# frozen_string_literal: true

module Kimi
  class AppApi < BaseApi
    BASE = 'https://api.moonshot.cn/'

    def file_create(file)
      post_file 'v1/files', file, file_key: 'file', purpose: 'file-extract'
    end

  end
end
