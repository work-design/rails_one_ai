module OneAi
  class Panel::AppModelsController < Panel::BaseController
    before_action :set_app
    before_action :set_app_model, only: [:show, :edit, :key, :update, :destroy]
    before_action :set_new_app_model, only: [:new, :create]

    def index
      q_params = {}

      @app_models = @app.app_models.default_where(q_params).order(id: :desc).page(params[:page])
    end

    private
    def set_app
      @app = App.find params[:app_id]
    end

    def set_new_app_model
      @app_model = @app.app_models.build(app_model_params)
    end

    def set_app_model
      @app_model = @app.app_models.find(params[:id])
    end

    def app_model_params
      params.fetch(:app_model, {}).permit(
        :name,
        :default
      )
    end

  end
end
