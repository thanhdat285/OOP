class Api::V1::LocationsController < Api::V1::Customers::BaseController
	skip_before_action :authenticate_request!

  def index
    locations = Location.all.select(:id, :name).paginate(page: params[:page] || 1, per_page: 10)
    render json: {code: 1, data: locations}
  end
end
