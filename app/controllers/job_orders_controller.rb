class JobOrdersController < ApplicationController
  protect_from_forgery
  before_action :require_login

  def job_order_params
    params.require(:job_order).permit(:job_type, :control_no, :where, :adviser_id,:date_needed, :time_needed,:information,:available_materials, :adviser_id, :fund_source, :user_id)
  end

  def index
    #SAO Admin wuvwuv
    name = User.find(session['user_credentials_id']).fname + ' ' + User.find(session['user_credentials_id']).lname
    if User.find(session['user_credentials_id']).has_role? :SAO_admin
      @pending_request_num = JobOrder.where(:progress => "Waiting for Adviser Approval").count
      @pending_request_num2 = JobOrder.where(:progress => "Waiting for Admin Approval").count
      @pending_request_num += @pending_request_num2
      @ongoing_request_num = JobOrder.where(:progress => "On going").count
      @finished_request_num = JobOrder.where(:progress => "Completed").count
      @pending_Accounts = User.where(:active => false, :approved => false, :confirmed => false).count
    #Adviser
    #elsif User.find(session['user_credentials_id']).has_role? :Adviser
    #  @pending_request_num = JobOrder.where(:progress => "Waiting for Adviser Approval").count
    #  @pending_request_num2 = JobOrder.where(:progress => "Waiting for Admin Approval").count
    #  @pending_request_num += @pending_request_num2
    #  @ongoing_request_num = JobOrder.where(:progress => "On going").count
    #  @finished_request_num = JobOrder.where(:progress => "Completed").count
    #Chairperson/Head
    #elsif User.find(session['user_credentials_id']).has_role? :Head
    #  @pending_request_num = JobOrder.where(:progress => "Waiting for Adviser Approval").count
    #  @pending_request_num2 = JobOrder.where(:progress => "Waiting for Admin Approval").count
    #  @pending_request_num += @pending_request_num2
    #  @ongoing_request_num = JobOrder.where(:progress => "On going").count
    #  @finished_request_num = JobOrder.where(:progress => "Completed").count
    #Student, Faculty, Staff
    else
      @pending_request_num = JobOrder.where(:progress => "Waiting for Adviser Approval", :user_id => session['user_credentials_id']).count
      @pending_request_num2 = JobOrder.where(:progress => "Waiting for Admin Approval", :user_id => session['user_credentials_id']).count
      @pending_request_num += @pending_request_num2
      @ongoing_request_num = JobOrder.where(:progress => "On going", :user_id => session['user_credentials_id']).count
      @finished_request_num = JobOrder.where(:progress => "Completed", :user_id => session['user_credentials_id']).count
    end

  end

  def admin_approval_params
    params.require(:job_order).permit(:job_office, :delivery_date)
  end

  def new
    @user_name = User.find(session['user_credentials_id']).fname + " " + User.find(session['user_credentials_id']).lname
  end

  def create
    @new_request = JobOrder.create!(job_order_params)
    if(@new_request.adviser_id == "" || @new_request.adviser_id == nil)
      @new_request.progress = "Waiting for Admin Approval"
    else
      @new_request.progress = "Waiting for Adviser Approval"
    end
    @new_request.user_id = session['user_credentials_id']
    @new_request.save!
    #should put notice here
    redirect_to '/job_orders/list_pending_requests'
  end

  def list_pending_requests
    @requests = JobOrder.where(:progress => "Waiting for Admin Approval", :user_id => session['user_credentials_id']).or(JobOrder.where(:progress => "Waiting for Adviser Approval", :user_id => session['user_credentials_id']))
  end

  def show
    @job_order = JobOrder.find params[:id]
    @job_type = @job_order.job_type
  end

  def edit
    @job_order = JobOrder.find params[:id]
    @job_type = @job_order.job_type
    if(@job_order.adviser_id != "")
      @user = User.find(@job_order.adviser_id)
      @adviser_name = @user.fname + " " + @user.mname + " " + @user.lname
    end
  end

  def update
    update_record = JobOrder.find params[:id]
    update_record.update_attributes!(job_order_params)
    #should put notice here
    redirect_to '/job_orders/list_pending_requests'
  end

  def destroy
    @job_order = JobOrder.find params[:id]
    @job_order.destroy
    redirect_to '/job_orders/list_pending_requests'
  end

  def list_pending_admin_approval
    @requests = JobOrder.where(:progress => "Waiting for Admin Approval")
  end

  def list_pending_adviser_approval
    @requests = JobOrder.where(:progress => "Waiting for Adviser Approval", :adviser_id => session['user_credentials_id'])
  end

  def adviser_approval
    @job_order = JobOrder.find params[:id]
    @job_type = @job_order.job_type
    if(@job_order.adviser_id != "")
      @user = User.find(@job_order.adviser_id)
      @adviser_name = @user.fname + " " + @user.mname + " " + @user.lname
    end
  end

  def adviser_approve_job_order
    update_attribute("Waiting for Admin Approval")
    redirect_to '/job_orders/list_pending_adviser_approval'
  end

  def adviser_reject_job_order
    update_attribute("Rejected")
    redirect_to '/job_orders/list_pending_adviser_approval'
  end

  def update_attribute(attribute)
    update_record = JobOrder.find params[:id]
    update_record.update_attributes!(:progress => attribute)
  end

  def list_ongoing_jobs
    @requests = JobOrder.where(:progress => "Approved")
  end

  def admin_approval
    @job_order = JobOrder.find params[:id]
    @job_type = @job_order.job_type
    if(@job_order.adviser_id != "" && @job_order.adviser_id != nil)
      @user = User.find(@job_order.adviser_id)
      @adviser_name = @user.fname + " " + @user.mname + " " + @user.lname
    end
  end

  def admin_approve_job_order
    update_record = JobOrder.find params[:id]
    update_record.update_attributes!(admin_approval_params)
    update_record.update_attributes!(:progress => "Waiting for Assignment")
    redirect_to '/job_orders/list_pending_admin_approval'
  end

  def admin_reject_job_order
    update_attribute("Rejected")
    redirect_to '/job_orders/list_pending_admin_approval'
  end

  def require_login
    unless session['user_credentials_id']
      redirect_to '/'
    end
  end

  def live_search
    if(params[:undefined] != "")
          @results = (User.where("(fname LIKE ? OR mname LIKE ? OR lname LIKE ?) AND position LIKE ?", "#{params[:undefined]}%", "#{params[:undefined]}%", "#{params[:undefined]}%", "Faculty"))
    else
      @results = ""
    end
    render :layout => false
  end

  def live_search2
    if(params[:undefined] != "")
      @results = (Office.where("name LIKE ? ", "%#{params[:undefined]}%"))
    else
      @results = ""
    end
    render :layout => false
  end

end
