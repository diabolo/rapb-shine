class CustomersController < ApplicationController
  PAGE_SIZE = 10

  def index
    @page = (params[:page] || 0).to_i

    if params[:keywords].present?
      @keywords = params[:keywords]
      @customers = ::CustomerSearch.new(@keywords).
        search.offset(PAGE_SIZE * @page).limit(PAGE_SIZE)
    else
      @customers = []
    end
  end
end

