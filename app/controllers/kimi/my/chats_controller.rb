module Kimi
  class My::ChatsController < My::BaseController
    before_action :set_app
    before_action :set_chat, only: [:show]

    def index
      q_params = {}
      q_params.merge! params.permit(:id, :type, :appid)

      @chats = Chat.default_where(q_params).order(id: :desc).page(params[:page])
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

  end
end
