module OneAi
  class Panel::SystemsController < Panel::BaseController
    before_action :set_system, only: [:show, :edit, :key, :update, :destroy]

    def index
      q_params = {}
      q_params.merge! params.permit(:id, :type, :appid)

      @systems = System.default_where(q_params).order(id: :desc).page(params[:page])
    end

    private
    def set_system
      @system = System.find(params[:id])
    end

    def system_params
      params.fetch(:system, {}).permit(
        :name,
        :content
      )
    end

  end
end
