class StaffsController < ApplicationController
  def show
    @staff = Staff.find(params[:id])
    @title = @staff.shop.area.name
  end
end
