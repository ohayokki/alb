class Admin::ContactsController < Admin::AdminController 
  def index
    @contacts = Contact.all.order("created_at")
  end

  def update
    @contact = Contact.find(params[:id])
    @contact.update!(status: true)
    redirect_back(fallback_location: root_url)
  end
end
