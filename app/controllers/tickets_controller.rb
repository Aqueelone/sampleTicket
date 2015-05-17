class TicketsController < ApplicationController
  before_filter :store_location
  before_filter :authenticate_user!, :only => [:new, :delete]
  
  # GET /tickets 
  # GET /tickets.json
  def index
    @tickets = Ticket.joins(:ticket_status, :category, :user).order('created_at DESC')
    if !current_user.blank?
      if !(current_user.is_admin || current_user.is_moderator)
      @tickets = @tickets.where(user_id: current_user.id)
      end
    end
    
    if current_user.blank? || @tickets.blank?
      demo_id = User.where(name: "demo").last.id 
      @tickets = Ticket.joins(:ticket_status, :category, :user).where(user_id: demo_id)
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tickets }
    end
  end

  # GET /tickets/1 
  # GET /tickets/1.json
  def show
    @ticket = Ticket.find(params[:id])
    demo_id = User.where(name: "demo").last.id
    if @ticket.user_id != demo_id && (current_user.blank? || (@ticket.user_id != current_user.id && !(current_user.is_admin || current_user.is_moderator)))
      respond_to do |format|
        format.html {redirect_to root_url} # return to home
        format.json {redirect_to root_url} # return to home
      end
    else
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @ticket }
      end
    end
  end

  # GET /tickets/new 
  # GET /tickets/new.json
  def new
    @ticket = Ticket.new
    @ticket.ticket_status = TicketStatus.find_by_name("Open")
    current_user ? @ticket.user_id = current_user.id : @ticket.user_id == 0 
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ticket }
    end
  end

  # GET /tickets/1/edit
  def edit
    @ticket = Ticket.find(params[:id])
  end

  # POST /tickets 
  # POST /tickets.json
  def create
    @ticket = Ticket.new(params[:ticket])
    respond_to do |format|
      if @ticket.save
        # Tell the AdminMailer to send a ticket create email after save
        AdminMailer.ticket_email(@ticket)
        
        format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        format.json { render json: @ticket, status: :created, location: @ticket }
      else
        format.html { render action: "new" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tickets/1 
  # PUT /tickets/1.json
  def update
    @ticket = Ticket.find(params[:id])

    respond_to do |format|
      if @ticket.update_attributes(params[:ticket])
        # Tell the AdminMailer to send a ticket update email after save
        AdminMailer.ticket_update_email(@ticket)
        
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1 
  # DELETE /tickets/1.json
  def destroy
    @ticket = Ticket.find(params[:id])    
    @ticket.destroy
    
    respond_to do |format|
      format.html { redirect_to tickets_url }
      format.json { head :ok }
    end
  end
end
