class ContactsController < ApplicationController
  before_action :set_client, except: :index
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  def index
    @contacts = Contact.all
  end

  def show
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.client = @client

    if @contact.save
      redirect_to client_path(@client), notice: 'Contact was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @contact.update(contact_params)
      redirect_to client_contact_path(@client, @contact), notice: 'Contact was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @contact.destroy
    redirect_to client_path(@client), notice: 'Contact was successfully destroyed.'
  end

  private

  def set_client
    @client = Client.find(params[:client_id])
  end

  def set_contact
    @contact = Contact.find(params[:id])
  end

  def contact_params
    params.require(:contact).permit(:name, :job_title, :email, :phone, :account_manager)
  end

end