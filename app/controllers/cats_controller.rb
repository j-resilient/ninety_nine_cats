class CatsController < ApplicationController
    def index
        @cats = Cat.all
        render :index
    end

    def show
        @current_cat = Cat.find_by(id: params[:id])
        @requests = @current_cat.rental_requests.order(:start_date)
        render :show
    end

    def new
        @cat = Cat.new
        render :new
    end

    def create
        @cat = Cat.new(cat_params)
        if @cat.save
            redirect_to cat_url(@cat)
        else
            render :new
        end
    end

    def edit
        @cat = Cat.find_by(id: params[:id])
        render :edit
    end

    def update
        @cat = Cat.find_by(id: params[:id])
        if @cat.update_attributes(cat_params)
            redirect_to cat_url(@cat)
        else
            render :edit
        end
    end

    private
    def cat_params
        params.require(:cat).permit(:name, :sex, :color, :birth_date, :description)
    end
end