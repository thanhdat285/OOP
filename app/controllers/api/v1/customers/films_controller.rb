class Api::V1::Customers::FilmsController < Api::V1::Customers::BaseController
	skip_before_action :authenticate_request!

  def index
    @films = Film.select(:id, :name, :image, :kind, :duration, :release_date).all
      .paginate(page: params[:page] || 1, per_page: 10)
  end

  def show
  	@film = Film.find_by id: params[:id]
  end
end
