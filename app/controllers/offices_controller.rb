class OfficesController < ApplicationController

  def index
    @office = Office.all
  end

  def new
    @office = Office.new
  end

  def create
    @office = Office.new(office_params)

    if @office.save
      redirect_to @office 
    else 
      flash[:errors] = @office.errors.full_messages
      render :new
    end
  end

  def show
    @office = Office.find params[:id]

    if @office.user_id != nil
      @head = User.find(@office.user_id)
      @office_head = @head.fname + " " + @head.mname + " " + @head.lname
    else
      @head = ""
    end
  end

  def edit
    @office = Office.find params[:id]
  end

  def update
    @office = Office.find params[:id]
    @new_head = User.find(params[:office][:user_id])

    if @office.user_id != nil && @office.user_id != @new_head.id
      @old_head = User.find(@office.user_id)
      @old_head.remove_role :Office_Head
      @old_head.add_role :Staff
      @old_head.position = "Staff"
      @old_head.save
    end

    if @new_head.has_role? :Staff
      @new_head.remove_role :Staff
      @new_head.add_role :Office_Head
      @new_head.position = "Office Head"
    elsif @new_head.has_role? :Faculty
      @new_head.remove_role :Faculty
      @new_head.add_role :Office_Head
      @new_head.position = "Office Head"
    end

    if @office.update(office_params) && @new_head.save
      redirect_to @office
    else
      flash[:errors] = @office.errors.full_messages + @old_head.errors.full_messages + @new_head.errors.full_messages
      render :edit
    end
  end

  def destroy
    puts "Delete not allowed!"
    # @office = Office.find(params[:id])
    # @office.destroy

    # redirect_to offices_path
  end 


  private
  def office_params
    params.require(:office).permit(:name, :acronym, :user_id)
  end

end
