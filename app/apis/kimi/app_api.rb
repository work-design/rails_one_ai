# frozen_string_literal: true

module Kimi
  class AppApi < BaseApi
    BASE = 'https://api.moonshot.cn/'

    def file_create(file, content_type:, **options)
      post_file 'v1/files', file, file_key: 'file', purpose: 'file-extract', origin: BASE, content_type: content_type, **options
    end

    def file_content(file_id)
      get "v1/files/#{file_id}/content", origin: BASE
    end

    def file_parse(file, content_type:, **options)
      re = file_create(file, content_type: content_type, **options)
      content = file_content(re['id'])
      messages = [
        { role: 'system', content: content['content'] },
        { role: 'user', content: '提取整理图片文本，以 JSON 格式返回' }
      ]
      chat(messages: messages)
    end

    def chat(messages: [], model: 'moonshot-v1-8k', **options)
      post(
        'v1/chat/completions',
        origin: BASE,
        model: model,
        messages: messages,
        **options
      )
    end

  end
end
