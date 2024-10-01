class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      redirect_to thanks_contacts_path, notice: "お問い合わせが送信されました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def post_request
    @shop = Shop.new
  end

  def shop_request_confirm
  end
  
  def thanks
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :inquiry_type, :inquiry_details)
  end
end
