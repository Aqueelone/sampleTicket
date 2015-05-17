class TicketStatusesController < ApplicationController
  before_filter :authenticate_user! , :only => [:new, :edit, :create, :update, :destroy]
  
  # GET /ticket_statuses
  # GET /ticket_statuses.json
  def index
    @ticket_statuses = TicketStatus.includes(:tickets).order("position ASC")

    if !(current_user.is_admin || current_user.is_moderator)
      @ticket_statuses.each do |ticket_status|
        if !ticket_status.users.include?(current_user)
          @ticket_statuses.delete(ticket_status)
        end
      end
    end   
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @ticket_statuses }
    end
  end

  # GET /ticket_statuses/new
  # GET /ticket_statuses/new.json
  def new
    @ticket_status = TicketStatus.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ticket_status }
    end
  end

  # GET /ticket_statuses/1
  def show
    @ticket_status = TicketStatus.find(params[:id])
    
    if current_user
      if current_user.is_admin || current_user.is_moderator
        @tickets = @ticket_status.tickets
      else
        @tickets = @ticket_status.tickets.where(user_id: current_user.id)
      end
    else
      demo_id = User.where(name: "demo").last.id
      @tickets = @ticket_status.tickets.where(user_id: demo_id)
    end
           
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @ticket_status }
    end
  end
  
  # GET /ticket_statuses/1/edit
  def edit
    @ticket_status = TicketStatus.find(params[:id])
  end

  # POST /ticket_statuses
  # POST /ticket_statuses.json
  def create
    @ticket_status = TicketStatus.new(params[:ticket_status])

    respond_to do |format|
      if @ticket_status.save
        format.html { redirect_to ticket_statuses_url, notice: 'Ticket_status was successfully created.' }
        format.json { render json: @ticket_status, status: :created, location: @ticket_status }
      else
        format.html { render action: "new" }
        format.json { render json: @ticket_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ticket_statuses/1
  # PUT /ticket_statuses/1.json
  def update
    @ticket_status = TicketStatus.find(params[:id])

    respond_to do |format|
      if @ticket_status.update_attributes(params[:ticket_status])
        format.html { redirect_to ticket_statuses_url, notice: 'Ticket_status was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @ticket_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ticket_statuses/1
  # DELETE /ticket_statuses/1.json
  def destroy
    @ticket_status = TicketStatus.find(params[:id])
    
    if @ticket_status.is_associated?
      redirect_to ticket_statuses_url, alert: "Ticket_status not deleted because associated to a ticket."
    else
      @ticket_status.destroy
      redirect_to ticket_statuses_url, notice: "Ticket_status successfully deleted."
    end
  end
end
