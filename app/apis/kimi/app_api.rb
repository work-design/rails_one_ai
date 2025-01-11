# frozen_string_literal: true

module Kimi
  class AppApi < BaseApi
    BASE = 'https://api.moonshot.cn/'

    def file_create(file, **options)
      post_file 'v1/files', file, file_key: 'file', purpose: 'file-extract', origin: BASE, **options
    end

    def file_content(file_id)
      get "v1/files/#{file_id}/content", origin: BASE
    end

  end
end
