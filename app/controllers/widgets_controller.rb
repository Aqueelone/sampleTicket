class WidgetsController < ApplicationController
  before_filter :authenticate_user!
  include WidgetsHelper

  # GET /widgets GET /widgets.json
  def index
    @widgets = Widget.eager_load(:widget_rules, :user).where(users: {id: current_user.id}) 
    @widget_rules = WidgetRule.includes(:controlled, :widgets).order("created_at DESC")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @widgets }
    end
  end
  
  # GET /widgets/new GET /widgets/new.json
  def new
    @widget = Widget.new
    @templates = Widget.where(is_template: true).map { |w| [w.name, w.id] }
    @widget_rules = WidgetRule.includes(:controlled).order("created_at DESC")
    .map { |c| [( c.allow ? "allow " : "deny " ) + 
          "[#{c.controlled_type}] #{c.controlled.name}", c.id] }

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @widget }
    end
  end

  # GET /widgets/1
  def show   
    @category_ids = ''
    @status_ids = ''
    @widget = Widget.find(params[:id])
    
    @widget_rules = WidgetRule.distinct.where(:id => @widget.widget_rules.map {|r| r.id})
    @widget_rules.each do |c|
      case c.controlled_type
      when "Category"
        @category_ids += "#{c.controlled_id},"
      when "TicketStatus"
        @status_ids += "#{c.controlled_id},"
      end
    end
    
    @tickets = Ticket.joins(:category, :ticket_status, :user)
    .where("tickets.category_id IN(#{@category_ids.chomp(',')}) AND tickets.ticket_status_id IN(#{@status_ids.chomp(',')})")    
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @widget}
    end
  end
  
  # GET /widgets/1/edit
  def edit
    @widget = Widget.find(params[:id])
    @widget_rules_selected_id = @widget.widget_rules.map {|r| r.id}
    @templates = Widget.where("widgets.is_template AND widgets.id != #{params[:id]}").map { |w| [w.name, w.id] }
    .map { |t| t.last == @widget.template_id ? t.push({selected: t.last}) : t }
    @widget_rules = WidgetRule.includes(:controlled).order("created_at DESC")
    .map { |c| ["[#{c.controlled_type}] #{c.controlled.name}", c.id] }
    .map { |c| @widget_rules_selected_id.include?(c.last) ? c.push({selected: c.last}) : c}
  end
  
  # GET /widgets/1/get_template.json
  def get_template
    @widget = Widget.find(params[:widget_id])
    @widget_rules_selected_id = @widget.widget_rules.map {|r| r.id}
    
    respond_to do |format|
      format.json { render json: @widget_rules_selected_id }
    end
  end

  # POST /widgets POST /widgets.json
  def create
    @widget = Widget.new params[:widget]
    @widget_rules = WidgetRule.find params[:widget][:widget_rules]
    @widget.widget_rules = @widget_rules
    @widget.is_readonly = true
    
    respond_to do |format|
      if @widget.save
        format.html { redirect_to widgets_url, notice: 'Widget was successfully created.' }
        format.json { render json: @widget, status: :created, location: @ticket_status }
      else
        format.html { render action: "new" }
        format.json { render json: @widget.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /widgets/1 PUT /widgets/1.json
  def update
    @widget = Widget.find params[:id]
    @widget_rules = WidgetRule.find params[:widget][:widget_rules]
    @widget.widget_rules = @widget_rules
    @widget.is_readonly = true
    
    respond_to do |format|
      if @widget.update_attributes(params[:widget])
        format.html { redirect_to widgets_url, notice: 'widget was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @widget.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /widgets/1 DELETE /widgets/1.json
  def destroy
    @widget = Widget.find(params[:id])
    
    if @widget.is_associated?
      redirect_to widgets_url, alert: "Widget not deleted because it is a template."
    else
      @widget.destroy
      redirect_to widgets_url, notice: "Widget successfully deleted."
    end
  end

end
