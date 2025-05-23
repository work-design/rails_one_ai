# frozen_string_literal: true

module OneAi
  module Model::System
    extend ActiveSupport::Concern

    included do
      attribute :content, :string
    end

  end
end
