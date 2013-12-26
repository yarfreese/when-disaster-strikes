class QuotationsController < ApplicationController

  def create
  end

  def index
    @quotations = Quotation.all
    # for API
    # respond_to do |format|
    #   format.html
    #  format.json { render json: @quotations }
    # end
  end

  def show
  end

end
