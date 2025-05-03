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

    def chat_stream(sse)
      r = app.chat_stream(content, sse: sse)
      chat.messages.create(content: r)
    end

  end
end
