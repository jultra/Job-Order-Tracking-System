class JobOrdersController < ApplicationController
  protect_from_forgery

  def job_order_params
    params.require(:job_order).permit(:job_type, :control_no, :where, :date_needed, :time_needed, :information, :requester, :adviser, :fund_source)
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

  def list_pending_requests
    @requests = JobOrder.where(:progress => "Waiting for Admin Approval").or(JobOrder.where(:progress => "Waiting for Adviser Approval"))
  end

  def show
    @requests = JobOrder.find params[:id]
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

end
