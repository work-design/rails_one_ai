module OneAi
  class Panel::AppsController < Panel::BaseController
    before_action :set_app, only: [:show, :edit, :key, :update, :destroy]

    def index
      q_params = {}
      q_params.merge! params.permit(:id, :type, :appid)

      @apps = App.default_where(q_params).order(position: :asc).page(params[:page])
    end

    private
    def set_app
      @app = App.find(params[:id])
    end

    def app_params
      params.fetch(:app, {}).permit(
        :type,
        :name,
        :appid,
        :secret,
        :base_url
      )
    end

  end
end
