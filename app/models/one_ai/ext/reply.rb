# frozen_string_literal: true

module OneAi
  module Ext::Reply
    extend ActiveSupport::Concern

    included do
      attribute :auto_reply, :boolean, default: true
      attribute :last_replied_at, :datetime
      attribute :last_message, :string

      after_save :refresh_users_box, if: -> { saved_change_to_last_replied_at? }
    end

    def refresh_users_box
    end

  end
end