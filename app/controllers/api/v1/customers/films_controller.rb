class Api::V1::Customers::FilmsController < Api::V1::Customers::BaseController

  def index
    @films = Film.select(:id, :name, :image, :kind, :duration, :release_date).all
      .paginate(page: params[:page] || 1, per_page: 15)
  end
end
