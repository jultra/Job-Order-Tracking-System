class OfficesController < ApplicationController

  def index
    @office = Office.all
    @user = User.all.where(:position => 'Chairperson/Head').map{|i| i.fname + " " + i.lname}
  end

  def new
    @office = Office.new
    @user = User.all.where(:position => 'Chairperson/Head')
    @user_n = @user.map{|x| x.fname + ' '+ x.mname + ' ' + x.lname}
    @user_id = @user.map{|x| x.id}
    #@user_name = Hash.new
    #@user_name[] = @user_n.map{|x| [x.id, x.fname + ' '+ x.mname + ' ' + x.lname]}
    @user_name = @user.collect{|x| [x.fname + ' '+ x.mname + ' ' + x.lname, x.id]}
  end

  def create
    @office = Office.new(office_params)
    begin
      @office.save!
      @user_head = User.find(@office.user_id)
      @user_head.Division_Department = @office.name
      @user_head.save!
      flash[:success] = "Hi #{params[:office][:name]} Successfully Created"
      rescue ActiveRecord::RecordNotUnique => e
      puts e.message
      if e.message != nil || e.message != ""
        flash[:danger] = "Office Creation Unsuccessful"
      else
      end
    end
    redirect_to offices_path
  end

  def edit

  end

  private

  def office_params
    params.require(:office).permit(:name, :acronym, :user_id)
  end

end
