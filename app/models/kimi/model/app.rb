# frozen_string_literal: true

module Kimi
  module Model::App
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :appid, :string, index: true
      attribute :secret, :string
      attribute :base_url, :string

      belongs_to :organ, class_name: 'Org::Organ', optional: true
    end


    def api
      return @api if defined? @api
      @api = AppApi.new(self)
    end

  end
end
