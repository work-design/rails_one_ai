# frozen_string_literal: true

module OneAi
  module Model::Chat
    extend ActiveSupport::Concern

    included do
      attribute :title, :string

      has_many :messages
      has_many :message_receives
      has_many :message_sends
    end

  end
end
