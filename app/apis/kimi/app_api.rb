# frozen_string_literal: true

module Kimi
  class AppApi < BaseApi
    BASE = 'https://api.moonshot.cn/v1/'
    START_CHAR = 'data: '
    FINISH_CHAR = "\n\n"

    def file_create(file, content_type:, **options)
      post_file 'files', file, file_key: 'file', purpose: 'file-extract', origin: BASE, content_type: content_type, **options
    end

    def file_content(file_id)
      get "files/#{file_id}/content", origin: BASE
    end

    def file_parse(file, content_type:, **options)
      re = file_create(file, content_type: content_type, **options)
      content = file_content(re['id'])
      messages = [
        { role: 'system', content: content['content'] },
        { role: 'user', content: '提取整理图片文本，直接返回 JSON 结果，不需要其他内容' }
      ]
      chat(messages: messages)
    end

    def chat(messages: [], model: 'moonshot-v1-8k', **options)
      post(
        'chat/completions',
        origin: BASE,
        model: model,
        messages: messages,
        **options
      )
    end

    def chat_stream(messages: [], model: 'moonshot-v1-8k', **options)
      result = post_stream('chat/completions', origin: BASE, model: model, messages: messages, stream: true, **options)

      line = ''.b
      result.each do |chunk|
        line << chunk
        start_at = line.index(START_CHAR)
        finish_at = line.index(FINISH_CHAR)

        while start_at
          each_chunk = line.byteslice((start_at + START_CHAR.length)..(finish_at - 1))
          break if each_chunk == '[DONE]'
          yield JSON.parse(each_chunk) unless each_chunk.blank?

          line = line.byteslice((finish_at + 1) .. -1)
          start_at = line.index(START_CHAR)
          finish_at = line.index(FINISH_CHAR)
        end
      end
    end

  end
end
