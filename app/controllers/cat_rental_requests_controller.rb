class CatRentalRequestsController < ApplicationController
    def new
        @cats = Cat.all
        render :new
    end

    def create
        @request = CatRentalRequest.new(request_params)
        if @request.save
            redirect_to cat_url(id: @request.cat_id)
        else
            @cats = Cat.all
            render :new
        end
    end

    def approve_or_deny
        request = CatRentalRequest.find_by(id: params[:id])
        # if params[:option] == "approve"
        #     request.approve!
        # else
        #     request.deny!
        # end
        params[:option] == "approve" ? request.approve! : request.deny!
        redirect_to cat_url(id: request.cat_id)       
    end

    private
    def request_params
        params.require(:request).permit(:cat_id, :start_date, :end_date, :status)
    end
end