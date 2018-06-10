require 'date'

class JobOrdersController < ApplicationController
  protect_from_forgery
  before_action :require_login

  def job_order_params
    params.require(:job_order).permit(:job_type, :where, :date_needed, :time_needed, :available_materials, :information, :fund_source, :user_id)
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

  def new

  end

  def create
    current_time = DateTime.now

    if !(params[:job_order][:date_needed] == "") && !Date.parse(params[:job_order][:date_needed].to_s).past?
      @new_request = JobOrder.new(job_order_params)
      @new_request.date_filed = current_time.strftime "%Y-%m-%d"

      if !(params[:job_order][:adviser] == "")
        #do some query here to set @new_request.adviser_id =
        @new_request.progress = "Waiting for adviser approval"
      else
        @new_request.progress = "Waiting for admin approval"
      end

      if @new_request.valid?
        @new_request.save!
        redirect_to '/job_orders/pending_requests'
      else
        flash[:notice] = "Insufficient information provided!"
        redirect_to '/job_orders/new'
      end
    else
      flash[:notice] = "Date provided is not valid!"
      redirect_to '/job_orders/new'
    end
  end

  def pending_requests
    @requests = JobOrder.where("progress LIKE 'Waiting%' OR progress LIKE 'Ready%'")
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
    redirect_to '/job_orders/pending_requests'
  end

  def destroy
    @job_order = JobOrder.find params[:id]
    @job_order.update_column(:progress, "Cancelled")
    redirect_to '/job_orders/pending_requests'
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

  def require_login
    unless session['user_credentials_id']
      redirect_to '/'
    end
  end

  def trash
    @rejected_requests = JobOrder.where("user_id = ? AND (progress LIKE ? OR progress = 'Cancelled')", session['user_credentials_id'], 'Rejected by%')
  end

  def finished_jobs
    @finished_jobs = JobOrder.where("user_id = ? AND progress = 'Finished'", session['user_credentials_id'])
  end

  def ongoing_jobs
    @ongoing_jobs = JobOrder.where("user_id = ? AND progress LIKE ?", session['user_credentials_id'], 'Ongoing%')
  end

  def approved_job_orders
    if User.find(session['user_credentials_id']).has_role? :SAO_admin   #admin
      @approved_requests = JobOrder.where("progress = 'Waiting for assignment'")
    elsif User.find(session['user_credentials_id']).has_role? :Adviser  #faculty
      @approved_requests = JobOrder.where("progress = 'Waiting for admin approval' AND adviser_id = ?", session['user_credentials_id'])
    end
  end

  def unapproved_job_orders
    if User.find(session['user_credentials_id']).has_role? :SAO_admin   #admin
      @unapproved_requests = JobOrder.where("progress = 'Waiting for admin approval'")
    elsif User.find(session['user_credentials_id']).has_role? :Adviser  #faculty
      @unapproved_requests = JobOrder.where("progress = 'Waiting for faculty approval' AND adviser_id = ?", session['user_credentials_id'])
    end
  end

  def ongoing_job_orders
    if User.find(session['user_credentials_id']).has_role? :SAO_admin   #admin
      @ongoing_jobs = JobOrder.where("progress LIKE ?", 'Ongoing%')
    elsif User.find(session['user_credentials_id']).has_role? :Adviser  #faculty
      @ongoing_jobs = JobOrder.where("progress LIKE ? AND adviser_id = ?", 'Ongoing%', session['user_credentials_id'])
    elsif User.find(session['user_credentials_id']).has_role? :Head     #head/chair
      @office = Office.where(:user_id => session['user_credentials_id'])
      if !@office.blank?
        @ongoing_jobs = JobOrder.where("progress LIKE ? AND office_id = ?", 'Ongoing%', @office.office_id)
      end
    else  #staff
      @ongoing_jobs = JobOrder.where("assigned_to_id = ? AND progress LIKE ?", session['user_credentials_id'], 'Ongoing%')
    end
  end

  def finished_job_orders
    if User.find(session['user_credentials_id']).has_role? :SAO_admin   #admin
      @finished_jobs = JobOrder.where("progress = 'Finished'")
    elsif User.find(session['user_credentials_id']).has_role? :Adviser  #faculty
      @finished_jobs = JobOrder.where("progress = 'Finished' AND adviser_id = ?", session['user_credentials_id'])
    elsif User.find(session['user_credentials_id']).has_role? :Head     #head/chair
      @office = Office.where(:user_id => session['user_credentials_id'])
      if !@office.blank?
        @finished_job = JobOrder.where("progress = 'Finished' AND office_id = ?", @office.office_id)
      end
    else  #staff
      @finished_jobs = JobOrder.where("assigned_to_id = ? AND progress = 'Finished'", session['user_credentials_id'])
    end
  end

  def assigned_job_orders
    if User.find(session['user_credentials_id']).has_role? :Head     #head/chair
      @office = Office.where(:user_id => session['user_credentials_id'])
      if !@office.blank?
        @assigned_requests = JobOrder.where("progress = 'Ready to start' AND office_id = ?", @office.office_id)
      end 
    end
  end

  def unassigned_job_orders
    if User.find(session['user_credentials_id']).has_role? :Head     #head/chair
      @office = Office.where(:user_id => session['user_credentials_id'])
      if !@office.blank?
        @unassigned_requests = JobOrder.where("progress = 'Waiting for assignment' AND office_id = ?", @office.office_id)
      end
    end
  end

  def pending_job_orders
    @pending_jobs = JobOrder.where("assigned_to_id = ? AND progress = 'Ready to start'", session['user_credentials_id'])
  end

  def manage_job_orders
    if User.find(session['user_credentials_id']).has_role? :SAO_admin   #admin
      @approved_requests = JobOrder.where("progress = 'Waiting for assignment'")
      @unapproved_requests = JobOrder.where("progress = 'Waiting for admin approval'")
      @ongoing_jobs = JobOrder.where("progress LIKE ?", 'Ongoing%')
      @finished_jobs = JobOrder.where("progress = 'Finished'")
    elsif User.find(session['user_credentials_id']).has_role? :Adviser  #faculty
      @approved_requests = JobOrder.where("progress = 'Waiting for admin approval' AND adviser_id = ?", session['user_credentials_id'])
      @unapproved_requests = JobOrder.where("progress = 'Waiting for faculty approval' AND adviser_id = ?", session['user_credentials_id'])
      @ongoing_jobs = JobOrder.where("progress LIKE ? AND adviser_id = ?", 'Ongoing%', session['user_credentials_id'])
      @finished_jobs = JobOrder.where("progress = 'Finished' AND adviser_id = ?", session['user_credentials_id'])
    elsif User.find(session['user_credentials_id']).has_role? :Head     #head/chair
      @office = Office.where(:user_id => session['user_credentials_id'])
      if !@office.blank?
        @assigned_requests = JobOrder.where("progress = 'Ready to start' AND office_id = ?", @office.office_id)
        @unassigned_requests = JobOrder.where("progress = 'Waiting for assignment' AND office_id = ?", @office.office_id)
        @ongoing_jobs = JobOrder.where("progress LIKE ? AND office_id = ?", 'Ongoing%', @office.office_id)
        @finished_job = JobOrder.where("progress = 'Finished' AND office_id = ?", @office.office_id)
      end
    else  #staff
      @pending_jobs = JobOrder.where("assigned_to_id = ? AND progress = 'Ready to start'", session['user_credentials_id'])
      @ongoing_jobs = JobOrder.where("assigned_to_id = ? AND progress LIKE ?", session['user_credentials_id'], 'Ongoing%')
      @finished_jobs = JobOrder.where("assigned_to_id = ? AND progress = 'Finished'", session['user_credentials_id'])
    end
  end

end
