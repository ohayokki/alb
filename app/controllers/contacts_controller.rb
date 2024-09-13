class ContactsController < ApplicationController
  def index
  end

  def post_request
    @shop = Shop.new
  end
end
