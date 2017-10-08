class CustomersController < ApplicationController
  def index
    if params[:keywords].present?
      @keywords = params[:keywords]
      customer_search = ::CustomerSearch.new(@keywords)
      byebug
      @customers = customer_search.search
    else
      @customers = []
    end
  end
end

