module Kimi
  class My::MessagesController < My::BaseController
    include ActionController::Live
    before_action :set_chat

    def index
      q_params = {}
      q_params.merge! params.permit(:id, :type, :appid)

      @chats = Chat.default_where(q_params).order(id: :desc).page(params[:page])
    end

    def create
      @message = @chat.message_sends.build(content: params[:content])
      @message.save

      response.headers['Content-Type'] = 'text/event-stream'
      @sse = SSE.new(response.stream)

      @message.chat_stream(@sse)
    ensure
      @sse.write({}, event: 'done')
      @sse.close
    end

    private
    def set_app
      @app = App.first
    end

    def set_chat
      @chat = Chat.find params[:chat_id]
    end

  end
end
