class CatRentalRequestsController < ApplicationController

  def new
    @request = CatRentalRequest.new
    render :new
  end

  def create
    @request = CatRentalRequest.new(request_params)
    if @request.save
      redirect_to cat_url(@request.cat)
    else
      render :new
    end
  end

  def approve
    current_cat_rental_request.approve!
    redirect_to cat_url(current_cat)
  end

  def deny
    current_cat_rental_request.deny!
    redirect_to cat_url(current_cat)
  end

  private
  def request_params
    params.require(:cat_rental_request)
      .permit(:cat_id, :start_date, :end_date, :status)
  end

  def current_cat
    current_cat_rental_request.cat
  end

  def current_cat_rental_request
    @request ||=
      CatRentalRequest.includes(:cat).find(params[:id])
  end


end
