# frozen_string_literal: true

module Kimi
  module Model::Message
    extend ActiveSupport::Concern

    included do
      attribute :content, :string

      belongs_to :chat
    end

    def app
      App.first
    end

    def chat(sse)
      app.chat_stream(content) do |chunk|
        message = chunk.dig('choices', 0, 'delta', 'content') || ''
        sse.write({ text: message }, event: 'text')
      end
    end

  end
end
