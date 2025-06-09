# frozen_string_literal: true

module OneAi
  module Model::AppModel
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :default, :boolean

      belongs_to :app
    end

  end
end
