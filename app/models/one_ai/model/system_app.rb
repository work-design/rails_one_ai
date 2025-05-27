# frozen_string_literal: true

module OneAi
  module Model::SystemApp
    extend ActiveSupport::Concern

    included do
      belongs_to :system
      belongs_to :app
    end

  end
end
