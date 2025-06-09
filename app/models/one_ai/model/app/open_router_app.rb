# frozen_string_literal: true

module OneAi
  module Model::App::OpenRouterApp

    def api
      return @api if defined? @api
      @api = OpenRouterApi.new(self)
    end

  end
end