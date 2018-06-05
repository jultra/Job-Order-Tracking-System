class AdviserController < ApplicationController
  protect_from_forgery
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
