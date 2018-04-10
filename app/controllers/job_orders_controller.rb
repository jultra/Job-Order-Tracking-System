class JobOrdersController < ApplicationController
  protect_from_forgery

  def request_form
    puts 'hehe'
    control_no = params['control_no']
    where = params['where']
    date_needed = params['date_needed']
    time_needed = params['time_needed']
    problem_area = params['problem_area']
    requester = params['requester']
    adviser = params['adviser']
    fund_source = params['fund_source']


      new_request = JobOrder.new
      new_request.control_no = control_no
      new_request.where = where
      new_request.date_needed = date_needed
      new_request.time_needed = time_needed
      new_request.information = problem_area
      new_request.requester = requester
      new_request.fund_source = fund_source
      new_request.adviser = adviser

      for i in 1..22
        if params["checkbox#{i}"] != nil
          new_request.job_type = params["checkbox#{i}"];
          puts params["checkbox#{i}"]
        end
      end
      new_request.save

  end
end
