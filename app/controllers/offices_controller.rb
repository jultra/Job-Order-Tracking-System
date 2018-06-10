class OfficesController < ApplicationController

  def index
    @office = Office.all
    @user = User.all.where(:position => 'Chairperson/Head')
  end

  def new
    @office = Office.new
  #  @user = User.all.where(:position => 'Chairperson/Head').to_a
  end

  def create
    @office = Office.new(office_params)
    begin
      @office.save!
      flash[:success] = "Office Successfully Created"
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
    params.require(:office).permit(:name, :acronym)
  end

end
