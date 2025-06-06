module OneAi
  class Admin::ChatsController < Admin::BaseController
    include ActionController::Live
    before_action :set_app
    before_action :set_chat, only: [:show]
    before_action :set_chats, only: [:index, :show]
    before_action :set_new_chat, only: [:create]

    def index
      q_params = {}
      q_params.merge! params.permit(:id, :type, :appid)

      @chats = Chat.default_where(q_params).order(id: :desc).page(params[:page])
    end

    def create
      @chat.messages.build(content: params[:content])
      @chat.save

      @messages = @chat.messages
    end

    def show
      response.headers['Content-Type'] = 'text/event-stream'
      @sse = SSE.new(response.stream)

      @message = @chat.messages.first
      @message_send = @message.chat_stream(@sse)
      @messages = @chat.messages.order(id: :desc).page(params[:page])
    ensure
      @sse.write({}, event: 'done')
      @sse.close
    end

    private
    def set_app
      @app = App.first
    end

    def set_chat
      @chat = Chat.find params[:id]
    end

    def set_new_chat
      @chat = Chat.new(title: params[:title])
    end

    def set_chats
      @chats = Chat.order(id: :desc).page(params[:page])
    end

  end
end
