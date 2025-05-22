module OneAi
  class My::ChatsController < My::BaseController
    layout 'sidebar'
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
      @chat.save

      redirect_to action: 'show', id: @chat.id
    end

    def show
      @messages = @chat.messages.order(id: :desc).page(params[:page])
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
