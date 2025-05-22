# frozen_string_literal: true

module OneAi
  module Model::Message
    extend ActiveSupport::Concern

    included do
      attribute :type, :string
      attribute :content, :string

      belongs_to :chat
    end

    def app
      App.first
    end

    def chat_stream(sse)
      r = app.chat_stream(content, sse: sse)
      chat.message_receives.create(content: r)
    end

  end
end
