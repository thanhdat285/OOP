class Api::V1::Customers::LocationsController < Api::V1::Customers::BaseController
	skip_before_action :authenticate_request!

  def index
    locations = Location.all.select(:id, :name)
    render json: {code: 1, data: locations}
  end
end
