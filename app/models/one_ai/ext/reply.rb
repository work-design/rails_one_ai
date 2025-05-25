# frozen_string_literal: true

module OneAi
  module Ext::Reply
    extend ActiveSupport::Concern

    included do
      attribute :auto_reply, :boolean, default: true
      attribute :last_replied_at, :datetime
      attribute :last_message, :string
    end

  end
end