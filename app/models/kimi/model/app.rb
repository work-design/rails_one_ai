# frozen_string_literal: true

module Kimi
  module Model::App
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :appid, :string, index: true
      attribute :secret, :string
      attribute :access_token, :string
      attribute :access_token_expires_at, :datetime
      attribute :refresh_token, :string
      attribute :refresh_token_expires_at, :datetime
      attribute :base_url, :string

      belongs_to :organ, class_name: 'Org::Organ', optional: true
    end


    def api
      return @api if defined? @api
      @api = Api::App.new(self)
    end

  end
end
