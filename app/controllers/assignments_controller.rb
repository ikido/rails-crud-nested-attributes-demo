class AssignmentsController < ApplicationController
  before_action :set_contact, only: [:new, :create]
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]

  def index
    @assignments = Assignment.all
  end

  def show
  end

  def new
    @assignment = Assignment.new
    @assignment.contact = @contact
  end

  def create
    @assignment = Assignment.new(assignment_params)
    @assignment.contact = @contact

    if @assignment.save
      redirect_to edit_assignment_path(@assignment), notice: 'Assignment was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @assignment.update(assignment_params)
      redirect_to assignment_path(@assignment), notice: 'Assignment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @assignment.destroy
    redirect_to assignment_path(@assignment), notice: 'Assignment was successfully destroyed.'
  end

  private

  def set_contact
    @contact = Contact.find(params[:contact_id])
  end

  def set_assignment
    @assignment = Assignment.find(params[:id])
  end

  def assignment_params
    params.require(:assignment).permit(
      :title,
      :potential_fee,
      :agreement_type,
      :agreement_currency,
      :agreement_rate_type
    )
  end

end