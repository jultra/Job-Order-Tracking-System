class JobOrdersController < ApplicationController
  protect_from_forgery

  def job_order_params
    params.require(:job_order).permit(:job_type, :control_no, :where, :date_needed, :time_needed, :information, :requester, :adviser, :fund_source)
  end

  def new
  end

  def create
    @new_request = JobOrder.create!(job_order_params)
    @new_request.progress = "Waiting for Approval"
    @new_request.save!
    #should put notice here
    redirect_to '/job_orders/list_pending_requests'

  end

  def list_pending_requests
    @requests = JobOrder.where(:progress => "Waiting for Approval")
    #try using dependency injection kena
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

end
