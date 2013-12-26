module Api
  module V1
    class QuotationsController < ApplicationController
      # class Quotation < ::Quotation
        # Note: this does not take into consideration the create/update actions for changing released_on
        # def as_json(options = {})
        #   super.merge(released_on: released_at.to_date)
        # end
      # end
      
      respond_to :json

      def index
        respond_with Quotation.all
      end

      def show
        respond_with Quotation.find(params[:id])
      end

      # def create
      #   respond_with Quotation.create(params[:quotation])
      # end

      # def update
      #   respond_with Quotation.update(params[:id], params[:quotation])
      # end

      # def destroy
      #   respond_with Quotation.destroy(params[:id])
      # end
    end
  end
end
