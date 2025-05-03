# frozen_string_literal: true

module Kimi
  module Model::App
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :appid, :string, index: true
      attribute :secret, :string
      attribute :base_url, :string

      belongs_to :organ, class_name: 'Org::Organ', optional: true
    end

    def api
      return @api if defined? @api
      @api = AppApi.new(self)
    end

    def chat(content = '测试')
      messages = [
        { role: 'user', content: content }
      ]
      api.chat(messages: messages)
    end


    def chat_stream(content = '测试', sse:, **options)
      messages = [
        { role: 'user', content: content }
      ]
      api.chat_stream(messages: messages, **options) do |chunk|
        message = chunk.dig('choices', 0, 'delta', 'content') || ''
        sse.write({ text: message }, event: 'text')
      end
    end

  end
end
