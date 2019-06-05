require 'date'

class JobOrdersController < ApplicationController
  protect_from_forgery
  before_action :require_login
  # before_action :get_job, only: [:show, :edit, :destroy, :adviser_approval, :admin_approval, :unapproved, :unassigned]

  ADVISER_APPROVAL = "Waiting for adviser approval."
  SAO_APPROVAL = "Waiting for SAO approval."
  WORKER_ASSIGNMENT = "Waiting for worker assignment."
  READY_JOB = "Ready to start job order."
  ONGOING_JOB = "Ongoing job order."
  FINISHED_JOB = "Finished job order."
  CANCELLED = "Cancelled job order."
  REJECTED_SAO = "Rejected by SAO."
  REJECTED_ADVISER = "Rejected by adviser."
  REJECTED_HEAD = "Rejected by office head."
  REJECTED_STAFF = "Rejected by staff."

  $job_types = ["Aircon cleaning / repair / install", "Bulb tube replacement", "Carpentry / fabrication work / repair", "Computer hardware servicing",
    "Computer software servicing", "Cost estimate formulation / POW", "DLP / LCD Sevices", "Door knob installation / repair", "Electric fan cleaning / repair",
    "Electrical installation / repair", "Internet & network problems", "Inventory taking & recording", "Painting / repainting / varnish works",
    "Photography / video coverage", "Plumbing / sanitary install / repair", "Printer / peripheral related problems", "Request for personnel assistance",
    "Sounds & lights services", "Streamer / signage making", "Streamer installation", "Transfer / transport items", "Others"]
  $codes = [["E (within 2 hours)", "E"], ["U (within 24 hours)", "U"], ["P (within 5 working days)", "P"], ["R (within 10 working days)", "R"]]

  def job_order_params
    params.require(:job_order).permit(:job_type, :where, :date_needed, :time_needed, :acknowledgment, :information, :adviser_id, :fund_source, :money_budget,
      :code, :available_materials, :delivery_date, :inspection_remarks, :assignment_remarks, :office_id, :inspected_by_id, :assigned_to_id)
  end

  def index
    @job_orders = nil
    @current_user = User.find session['user_credentials_id']

    @type = params[:type]

    if @type == "pending"
      @title = "Pending Job Orders"
      if @current_user.has_role? :Standard_User
        @job_orders = JobOrder.where(:progress => [SAO_APPROVAL, ADVISER_APPROVAL, WORKER_ASSIGNMENT, READY_JOB], :user_id => @current_user.id)
      elsif @current_user.has_role? :Staff 
        @job_orders = JobOrder.where(:progress => READY_JOB, :assigned_to_id => @current_user.id)
      elsif @current_user.has_role? :Faculty
        @job_orders = JobOrder.where(:progress => [SAO_APPROVAL, WORKER_ASSIGNMENT, READY_JOB], :adviser_id => @current_user.id)
      elsif @current_user.has_role? :Office_Head
        @job_orders = JobOrder.where(:progress => READY_JOB, :office_id => @current_user.office_id)
      end
    elsif @type == "ongoing"
      @title = "Ongoing Job Orders"
      if @current_user.has_role? :Standard_User
        @job_orders = JobOrder.where(:progress => ONGOING_JOB, :user_id => @current_user.id)
      elsif @current_user.has_role? :Staff 
        @job_orders = JobOrder.where(:progress => ONGOING_JOB, :assigned_to_id => @current_user.id)
      elsif @current_user.has_role? :Faculty
        @job_orders = JobOrder.where(:progress => ONGOING_JOB, :adviser_id => @current_user.id)
      elsif @current_user.has_role? :Office_Head
        @job_orders = JobOrder.where(:progress => ONGOING_JOB, :office_id => @current_user.office_id)
      end
    elsif @type == "finished"
      @title = "Finished Job Orders"
      if @current_user.has_role? :Standard_User
        @job_orders = JobOrder.where(:progress => FINISHED_JOB, :user_id => @current_user.id)
      elsif @current_user.has_role? :Staff 
        @job_orders = JobOrder.where(:progress => FINISHED_JOB, :assigned_to_id => @current_user.id)
      elsif @current_user.has_role? :Faculty
        @job_orders = JobOrder.where(:progress => FINISHED_JOB, :adviser_id => @current_user.id)
      elsif @current_user.has_role? :Office_Head
        @job_orders = JobOrder.where(:progress => FINISHED_JOB, :office_id => @current_user.office_id)
      end
    elsif @type == "trash"
      @title = "Trash"
      if @current_user.has_role? :Standard_User
        @job_orders = JobOrder.where(:progress => CANCELLED, :user_id => @current_user.id)
      end
    elsif @type == "unapproved"
      @title = "Unapproved Job Orders"
      if @current_user.has_role? :Faculty
        @job_orders = JobOrder.where(:progress => ADVISER_APPROVAL, :adviser_id => @current_user.id)
      else
        @job_orders = JobOrder.where(:progress => SAO_APPROVAL)
      end
    elsif @type == "unassigned"
      @title = "Unassigned Job Orders"
      @job_orders = JobOrder.where(:progress => WORKER_ASSIGNMENT, :office_id => @current_user.office_id)
    elsif @type == "rejected"
      @title = "Rejected Job Orders"
      if @current_user.has_role? :Standard_User
        @job_orders = JobOrder.where(:progress => [REJECTED_ADVISER,REJECTED_SAO,REJECTED_HEAD,REJECTED_STAFF], :user_id => @current_user.id)
      elsif @current_user.has_role? :Faculty 
        @job_orders = JobOrder.where(:progress => REJECTED_SAO, :adviser_id => @current_user.id)
      elsif @current_user.has_role? :Office_Head and Office.find(@current_user.office_id).name == "Supervising Administrative Office"
        @job_orders = JobOrder.where(:progress => REJECTED_HEAD)
      elsif @current_user.has_role? :Office_Head 
        @job_orders = JobOrder.where(:progress => REJECTED_STAFF, :office_id => @current_user.office_id)
      end
    end
  end

  def new
    @job_order = JobOrder.new
    
    @readonly = false
    @summary = false
    @information = true
    @inspection = false
    @office_assignment = false
    @task_assignment = false
  end

  def create
    current_time = DateTime.now
    @current_user = User.find session['user_credentials_id']

    if Date.parse(params[:job_order][:date_needed].to_s).past?
      flash[:errors] = ["The date provided has already past!"]
    end

    @job_order = JobOrder.new(job_order_params)
    @job_order.date_filed = current_time.strftime "%Y-%m-%d"
    @job_order.user_id = session['user_credentials_id']

    if @job_order.valid? && flash[:errors] == nil

      if @job_order.adviser_id != nil
        @job_order.progress = ADVISER_APPROVAL
      else
        @job_order.progress = SAO_APPROVAL
      end

      @job_order.save!
      Log.create(job_order: @job_order, actor: @current_user, action_at: DateTime.now, action: "create")
      if @job_order.adviser_id != nil
        Notification.create(recipient: User.find(@job_order.adviser_id), actor: current_user, action: "SUBMIT", notifiable: @job_order)
      else
        # NOTIFICATION FOR FACULTY REQUEST I DONT KNOW WHAT TO PUT IN recipient:
        Notification.create(recipient: @job_order.user, actor: current_user, action: "SUBMIT", notifiable: @job_order)
      end
      
      redirect_to @job_order
    else
      if flash[:errors].any?
        if @job_order.errors.full_messages.any?
          flash[:errors] <<  @job_order.errors.full_messages
        end
      else
        flash[:errors] = @job_order.errors.full_messages
      end
      @summary = false
      @information = true
      @inspection = false
      @office_assignment = false
      @task_assignment = false
      render :new
    end
  end

  def show
    @show = true
    @edit = false

    @job_order = JobOrder.find params[:id]
    @current_user = User.find session['user_credentials_id']

    @readonly = true
    @summary = true
    @information = true
    @inspection = true
    @office_assignment = true
    @task_assignment = true

    print @job_order

    print "\n\n\nassigned_to_id: #{@job_order.assigned_to_id}\n\n\n"
    # if @job_order.progress == ADVISER_APPROVAL or @job_order.progress == SAO_APPROVAL
    #   @inspection = false
    #   @office_assignment = false
    #   @task_assignment = false
    # elsif @job_order.progress == WORKER_ASSIGNMENT
    #   @task_assignment = false
    # end
  end

  def edit
    @show = false
    @edit = true

    @job_order = JobOrder.find params[:id]
    @current_user = User.find session['user_credentials_id']
    current_time = DateTime.now

    @readonly = false
    @summary = true
    @information = true
    @inspection = true
    @office_assignment = true
    @task_assignment = true

    if @current_user.has_role? :Standard_User or @current_user.has_role? :Faculty
      @inspection = false
      @office_assignment = false
      @task_assignment = false
    elsif @job_order.assigned_to_id == @current_user.id and @current_user.has_role? :Staff
      @inspection = false
      @office_assignment = false
    elsif @job_order.office_id == @current_user.office_id and @current_user.has_role? :Office_Head
      @inspection = false
      @office_assignment = false
    elsif @job_order.office_id != @current_user.office_id
      @task_assignment = false
    end
  end

  def update
    @job_order = JobOrder.find params[:id]
    @current_user = User.find session['user_credentials_id']
    current_time = DateTime.now

    if @job_order.progress == SAO_APPROVAL or @job_order.progress == REJECTED_HEAD and @current_user.has_role? :Office_Head and Office.find(@current_user.office_id).name == "Supervising Administrative Office"
      @job_order.update(job_order_params)
      @job_order.progress = WORKER_ASSIGNMENT
      @job_order.date_approved = current_time.strftime "%Y-%m-%d"
      @job_order.control_no = Date.today.year.to_s + '-' + @job_order.id.to_s
      @job_order.inspection_date = @job_order.date_approved

      @job_order.save!
      Log.create(job_order: @job_order, actor: @current_user, action_at: current_time, action: "assign", comment: Office.find(@job_order.office_id).name)
      redirect_to @job_order
    elsif (@job_order.progress == WORKER_ASSIGNMENT or @job_order.progress == REJECTED_STAFF) and @current_user.has_role? :Office_Head and @job_order.office_id == @current_user.office_id
      @job_order.update(job_order_params)
      @job_order.progress = READY_JOB
      @job_order.assignment_date = current_time.strftime "%Y-%m-%d"

      @job_order.save!
      Log.create(job_order: @job_order, actor: @current_user, action_at: current_time, action: "assign", comment: User.find(@job_order.assigned_to_id).username)
      redirect_to @job_order
    elsif @job_order.progress == ONGOING_JOB and @current_user.id == @job_order.assigned_to_id
      @job_order.update(job_order_params)
      Log.create(job_order: @job_order, actor: @current_user, action_at: current_time, action: "edit")
      redirect_to @job_order
    elsif @job_order.user_id == @current_user.id or @job_order.adviser_id = @current_user.id
      @job_order.update(job_order_params)
      Log.create(job_order: @job_order, actor: @current_user, action_at: current_time, action: "edit")
      redirect_to @job_order 
    end
  end

  def destroy
    # destructive!!!!
    @job_order = JobOrder.find params[:id]
    @job_order.destroy

    redirect_to job_orders_path
  end

  def approve_job_order
    @job_order = JobOrder.find params[:id]
    @current_user = User.find session['user_credentials_id']

    if @current_user.has_role? :Faculty
      @job_order.progress = SAO_APPROVAL
      
      current_time = DateTime.now
      @job_order.date_approved = current_time.strftime "%Y-%m-%d"

      @job_order.save!
      Notification.create(recipient: @job_order.user, actor: current_user, action: "APPROVE", notifiable: @job_order)
      Log.create(job_order: @job_order, actor: @current_user, action_at: current_time, action: "approve")
      redirect_to @job_order

    elsif @current_user.has_role? :Office_Head
      redirect_to edit_job_order_path(@job_order)
    end
  end

  def reject_job_order
    current_time = DateTime.now
    @job_order = JobOrder.find params[:id]
    @current_user = User.find session['user_credentials_id']

    if @current_user.has_role? :Faculty
      @job_order.progress = REJECTED_ADVISER
    elsif @current_user.has_role? :Office_Head and Office.find(@current_user.office_id).name == "Supervising Administrative Office"
      @job_order.progress = REJECTED_SAO
    elsif @current_user.has_role? :Office_Head
      @job_order.progress = REJECTED_HEAD
    elsif @current_user.has_role? :Staff
      @job_order.progress = REJECTED_STAFF
    end

    @job_order.save!
    if @current_user.has_role? :Faculty
      Notification.create(recipient: @job_order.user, actor: current_user, action: "REJECT", notifiable: @job_order)
    elsif @current_user.has_role? :Office_Head and Office.find(@current_user.office_id).name == "Supervising Administrative Office"
      Notification.create(recipient: @job_order.user, actor: current_user, action: "REJECT", notifiable: @job_order)
    elsif @current_user.has_role? :Office_Head
      Notification.create(recipient: @job_order.user, actor: current_user, action: "REJECT", notifiable: @job_order)
    elsif @current_user.has_role? :Staff
      Notification.create(recipient: @job_order.user, actor: current_user, action: "REJECT", notifiable: @job_order)
    end

    Log.create(job_order: @job_order, actor: @current_user, action_at: current_time, action: "reject", comment: params[:reason].to_s)
    redirect_to @job_order
  end

  def start_job_order
    @job_order = JobOrder.find params[:id]
    @job_order.progress = ONGOING_JOB

    current_time = DateTime.now
    @job_order.date_started = current_time.strftime "%Y-%m-%d"

    @job_order.save!
    Notification.create(recipient: @job_order.user, actor: current_user, action: "START", notifiable: @job_order)
    Log.create(job_order: @job_order, actor: @current_user, action_at: current_time, action: "start")
    redirect_to @job_order
  end

  def done_job_order
    @job_order = JobOrder.find params[:id]
    @job_order.progress = FINISHED_JOB

    current_time = DateTime.now
    @job_order.date_completed = current_time.strftime "%Y-%m-%d"

    @job_order.save!
    Notification.create(recipient: @job_order.user, actor: current_user, action: "DONE", notifiable: @job_order)
    Log.create(job_order: @job_order, actor: @current_user, action_at: current_time, action: "done")
    redirect_to @job_order
  end

  def resubmit_job_order
    @job_order = JobOrder.find params[:id]
    @current_user = User.find session['user_credentials_id']
    current_time = DateTime.now
    if @job_order.progress == REJECTED_ADVISER and @current_user.has_role? :Standard_User
      @job_order.progress = ADVISER_APPROVAL
      @job_order.save!
      Notification.create(recipient: User.find(@job_order.adviser_id), actor: current_user, action: "RESUBMIT", notifiable: @job_order)
      Log.create(job_order: @job_order, actor: @current_user, action_at: current_time, action: "resubmit")
      redirect_to @job_order
    elsif @job_order.progress == REJECTED_SAO and @current_user.has_role? :Faculty
      @job_order.progress = SAO_APPROVAL
      @job_order.save!
      Notification.create(recipient: @job_order.user, actor: current_user, action: "RESUBMIT", notifiable: @job_order)
      Log.create(job_order: @job_order, actor: @current_user, action_at: current_time, action: "resubmit")
      redirect_to @job_order
    elsif @job_order.progress == REJECTED_HEAD and @current_user.has_role? :Office_Head
      Notification.create(recipient: @job_order.user, actor: current_user, action: "RESUBMIT", notifiable: @job_order)
      Log.create(job_order: @job_order, actor: @current_user, action_at: current_time, action: "resubmit")
      redirect_to edit_job_order_path(@job_order)
    end
  end

  def comment_job_order
    @job_order = JobOrder.find params[:id]
    @current_user = User.find session['user_credentials_id']
    current_time = DateTime.now
    if params[:comment]
      Log.create(job_order: @job_order, actor: @current_user, action_at: current_time, action: "comment", comment: params[:comment])
    end
    Notification.create(recipient: @job_order.user, actor: current_user, action: "COMMENT", notifiable: @job_order)
    redirect_to @job_order
  end

  def cancel_job_order
    current_time = DateTime.now
    @job_order = JobOrder.find params[:id]
    @job_order.progress = CANCELLED;
    @job_order.save!
    Log.create(job_order: @job_order, actor: @current_user, action_at: current_time, action: "cancel")
    redirect_to @job_order
  end

  def require_login
    unless session['user_credentials_id']
      redirect_to '/'
    end
  end
end
