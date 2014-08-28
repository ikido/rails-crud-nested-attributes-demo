class ContactsController < ApplicationController
  before_action :set_client, only: [:new, :create]
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  def index
    @contacts = Contact.all
  end

  def show
    @assignments = @contact.assignments
  end

  def new
    @contact = Contact.new
    @contact.client = @client
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.client = @client

    if @contact.save
      redirect_to contact_path(@contact), notice: 'Contact was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @contact.update(contact_params)
      redirect_to contact_path(@contact), notice: 'Contact was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @contact.destroy
    redirect_to client_path(@contact.client), notice: 'Contact was successfully destroyed.'
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