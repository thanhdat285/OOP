class Api::V1::FilmsController < Api::V1::Customers::BaseController
	skip_before_action :authenticate_request!, only: [:index, :show]
	before_action :check_seller, only: [:create]

  def index
    @films = Film.select(:id, :name, :image, :kind, :duration, :release_date).all
  end

  def show
  	@film = Film.find_by id: params[:id]
  end

  def create
  	@film = Film.new(film_params)
  	if @film.save
  		if params[:image].present?
  			@film.update_attributes(image: save_file_with_token("/images/films/#{@film.id}/",
  				params[:image]))
  		end
  		render json: {code: 1, message: "Tạo mới thành công", data: @film}
  	else
  		render json: {code: 0, message: "Tạo mới thất bại"}
  	end
  end

  private
  def film_params
  	params.permit(:name, :kind, :duration, :release_date, :content)
  end
end
