class ContactsController < ApplicationController
  before_action :set_contact, only: %i[ show update destroy ]
  invisible_captcha only: [:create]
  before_action :admin_only, except: [:create, :new]

  def index
    @contacts = Contact.where(responded: false, archived: false)
    @old_contacts = Contact.where(responded: true, archived: false)
    @archived_contacts = Contact.where(archived: true)
  end


  def new
    @contact = Contact.new
  end


  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        AdminMailer.new_contact(@contact).deliver
        format.html { redirect_to home_index_path, notice: "Thank you for reaching out!  I'll get back to you as soon as possible." }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to contacts_path, notice: "Contact was successfully updated." }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to contacts_url, notice: "Contact was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  def mark_responded
    @contact = Contact.find(params[:id])
    if @contact.update(responded: true)
        redirect_to contacts_path
        flash[:notice] = "Great job!  You responded the heck out of that message!"
    else
        redirect_to contacts_path
        flash[:warning] = "Oops! Something went wrong!"
    end
  end

  def mark_unresponded
    @contact = Contact.find(params[:id])
    if @contact.update(responded: false)
        redirect_to contacts_path
        flash[:notice] = "Well shoot, that's supposed to go in the other direction!"
    else
        redirect_to contacts_path
        flash[:warning] = "Oops! Something went wrong!"
    end
  end

  def mark_archived
    @contact = Contact.find(params[:id])
    if @contact.update(archived: true)
        redirect_to contacts_path
        flash[:notice] = "Great job!  You archived the heck out of that message!"
    else
        redirect_to contacts_path
        flash[:warning] = "Oops! Something went wrong!"
    end
  end

  def mark_unarchived
    @contact = Contact.find(params[:id])
    if @contact.update(archived: false)
        redirect_to contacts_path
        flash[:notice] = "Aaaaaaaand it's back!"
    else
        redirect_to contacts_path
        flash[:warning] = "Oops! Something went wrong!"
    end
  end


  private

    def set_contact
      @contact = Contact.find(params[:id])
    end


    def contact_params
      params.require(:contact).permit(
        :name,
        :email,
        :message,
        :responded,
        :archived
      )
    end
end
