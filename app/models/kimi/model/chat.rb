# frozen_string_literal: true

module Kimi
  module Model::Chat
    extend ActiveSupport::Concern

    included do
      attribute :title, :string
    end

  end
end
