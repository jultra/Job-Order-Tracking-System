class JobOrdersController < ApplicationController
  protect_from_forgery

  def request_form
    new_request = JobOrder.new
    new_request.control_no = params['control_no']
    new_request.where = params['where']
    new_request.date_needed = params['date_needed']
    new_request.time_needed = params['time_needed']
    new_request.information = params['problem_area']
    new_request.requester = params['requester']
    new_request.fund_source = params['fund_source']
    new_request.adviser = params['adviser']

    for i in 1..22
      if params["checkbox#{i}"] != nil
        new_request.job_type = params["checkbox#{i}"];
      end
    end

    if (params['submit']) 
      if new_request.save
        redirect_to '/pending_requests'
      end
    elsif (params['cancel'])
      redirect_to '/index'
    end
  end

  def pending_requests
    if(params['cancel'])
      JobOrder.where(control_no: params['cancel']).delete_all;
      @requests = JobOrder.all
    else
      @requests = JobOrder.all
    end
  end
end