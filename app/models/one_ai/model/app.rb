module OneAi
  module Model::App
    extend ActiveSupport::Concern

    included do
      attribute :type, :string
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

    def chat(content = '测试')
      messages = [
        { role: 'user', content: content }
      ]
      r = api.chat(messages: messages)
      r.dig('choices', 0, 'message', 'content')
    end

    def chat_stream(content = '测试', sse:, **options)
      messages = [
        { role: 'user', content: content }
      ]
      res = ''
      api.chat_stream(messages: messages, **options) do |chunk|
        message = chunk.dig('choices', 0, 'delta', 'content') || ''
        res << message
        sse.write({ text: message })
      end
      res
    end

  end
end
