class JobOrdersController < ApplicationController
  protect_from_forgery

  def job_order_params
    params.require(:job_order).permit(:job_type, :control_no, :where, :date_needed, :time_needed, :information, :requester, :adviser, :fund_source)
  end

  def index
    #SAO Admin
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
      @pending_request_num = JobOrder.where(:progress => "Waiting for Adviser Approval", :requester => name).count
      @pending_request_num2 = JobOrder.where(:progress => "Waiting for Admin Approval", :requester => name).count
      @pending_request_num += @pending_request_num2
      @ongoing_request_num = JobOrder.where(:progress => "On going", :requester => name).count
      @finished_request_num = JobOrder.where(:progress => "Completed", :requester => name).count
    end
 
  end
  def create
    @new_request = JobOrder.create!(job_order_params)
    @new_request.control_no = "XXXX-XXXX"
    @new_request.progress = "Waiting for Approval"
    @new_request.save!
    #should put notice here
    redirect_to '/job_orders/list_pending_requests'

  def new

  end

  def list_pending_requests
    @requests = JobOrder.where(:progress => "Waiting for Approval")
    #try using dependency injection kena
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

  def list_pending_approval
    @requests = JobOrder.where(:progress => "Waiting for Approval", :adviser => "John Ultra")
  end

  def approve_job_order
    update_attribute("Approved")
  end

  def reject_job_order
    update_attribute("Rejected")
  end

  def update_attribute(attribute)
    update_record = JobOrder.find params[:id]
    update_record.update_attributes!(:progress => attribute)
    redirect_to '/job_orders/list_pending_approval'
  end

  def list_ongoing_jobs
    @requests = JobOrder.where(:progress => "Approved")
  end

end
