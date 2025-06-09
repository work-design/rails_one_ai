# frozen_string_literal: true

module OneAi
  module Model::App::OpenRouterApp

    def api
      return @api if defined? @api
      @api = OpenRouterApi.new(self)
    end

    def chat(content = '测试')
      messages = [
        { role: 'user', content: content }
      ]
      r = api.chat(model: 'openai/gpt-3.5-turbo', messages: messages)
      r.dig('choices', 0, 'message', 'content')
    end

  end
end