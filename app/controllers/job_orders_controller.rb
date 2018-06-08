class JobOrdersController < ApplicationController
  protect_from_forgery
  before_action :require_login

  def job_order_params
    params.require(:job_order).permit(:job_type, :control_no, :where, :date_needed, :time_needed, :information, :fund_source, :user_id)
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
  end

  def create
    @new_request = JobOrder.create!(job_order_params)
    @new_request.progress = "Waiting for Adviser Approval"
    @new_request.save!
    #should put notice here
    redirect_to '/job_orders/list_pending_requests'
  end
  
  def new

  end

  def list_pending_requests
    @requests = JobOrder.where(:progress => "Waiting for Admin Approval").or(JobOrder.where(:progress => "Waiting for Adviser Approval"))
  end

  def show
    @job_order = JobOrder.find params[:id]
    @job_type = @job_order.job_type
  end

  def edit
    @job_order = JobOrder.find params[:id]
    @job_type = @job_order.job_type
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
    @requests = JobOrder.where(:progress => "Waiting for Adviser Approval", :adviser => "John Ultra")
  end

  def adviser_approval
    @job_order = JobOrder.find params[:id]
    @job_type = @job_order.job_type
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
  end

  def admin_approve_job_order
    update_record = JobOrder.find params[:id]
    update_record.update_attributes!(admin_approval_params)
    update_record.update_attributes!(:progress => "On-going")
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

end
