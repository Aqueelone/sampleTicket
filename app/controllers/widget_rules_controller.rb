class WidgetRulesController < ApplicationController
before_filter :authenticate_user!

  # GET /widget_rules
  # GET /widget_rules.json
  def index
    @widget_rules = WidgetRule.order("created_at DESC")
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @widget_rules }
    end
  end
  
  # GET /widget_rules/new
  # GET /widget_rules/new.json
  def new
    @widget_rule = WidgetRule.new
    @categories = Category.order("name ASC")
    @ticket_statuses = TicketStatus.order("position ASC")
    @controlleds = @categories + @ticket_statuses 
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @widget_rule }
    end
  end

  # GET /widget_rules/1
  def show
    @widget_rule = WidgetRule.find(params[:id])
           
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @widget_rule }
    end
  end
  
  # GET /widget_rules/1/edit
  def edit
    @widget_rule = WidgetRule.find(params[:id])
    @categories = Category.order("name ASC")
    @ticket_statuses = TicketStatus.order("position ASC")
    @controlleds = @categories + @ticket_statuses 
  end

  # POST /widget_rules
  # POST /widget_rules.json
  def create
    @widget_rule = WidgetRule.new(params[:widget_rule])
    controlled = params[:widget_rule][:controlled].split(":")
    @widget_rule.controlled_type = controlled[0]
    @widget_rule.controlled_id = controlled[1].to_i
    
    respond_to do |format|
      if @widget_rule.save
        format.html { redirect_to widget_rules_url, notice: 'Widget rules was successfully created.' }
        format.json { render json: @widget_rule, status: :created, location: @widget_rule }
      else
        format.html { render action: "new" }
        format.json { render json: @widget_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /widget_rules/1
  # PUT /widget_rules/1.json
  def update
    @widget_rule = WidgetRule.find(params[:id])
    controlled = params[:widget_rule][:controlled].split(":")
    @widget_rule.controlled_type = controlled[0]
    @widget_rule.controlled_id = controlled[1].to_i

    respond_to do |format|
      if @widget_rule.update_attributes(params[:widget_rule])
        format.html { redirect_to widget_rules_url, notice: 'Widget rule was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @widget_rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /widget_rules/1
  # DELETE /widget_rules/1.json
  def destroy
    @widget_rule = WidgetRule.find(params[:id])
    
    if @widget_rule.is_associated?
      redirect_to widget_rule_url, alert: "Widget rule not deleted because associated to a widget."
    else
      @widget_rule.destroy
      redirect_to widget_rule_url, notice: "Widget rule was successfully deleted."
    end
  end
end
