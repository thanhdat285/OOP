class Api::V1::Customers::LocationsController < Api::V1::Customers::BaseController

  def index
    locations = Location.all.select(:id, :name).paginate(page: params[:page] || 1, per_page: 10)
    render json: {code: 1, data: locations}
  end
end
