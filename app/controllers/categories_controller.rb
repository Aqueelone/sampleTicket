class CategoriesController < ApplicationController
  before_filter :authenticate_user! , :only => [:new, :edit, :create, :update, :destroy]
  
  # GET /categories 
  # GET /categories.json
  def index
    @categories = Category.eager_load(:tickets, :users) if current_user
    
    @categories = @categories.where(users: {id: current_user.id})
                .uniq if current_user && !(current_user.is_admin || current_user.is_moderator)
      
    @categories = Category.eager_load(:tickets, :users).where(users: {name: "demo"})  if !current_user || @categories.empty?
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categories }
    end
  end

  # GET /categories/new 
  # GET /categories/new.json
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category }
    end
  end

  # GET /categories/1
  def show
    @category = Category.find(params[:id])    
    @tickets = @category.tickets
    
    if current_user.blank?
      show_user_id = User.where(name: "demo").last.id
    else
      show_user_id = current_user.id
    end
    
    if current_user.blank? || !(current_user.is_admin || current_user.is_moderator)
      @tickets = @tickets.where(user_id: show_user_id)
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @category }
    end
  end
  
  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories 
  # POST /categories.json
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to categories_url, notice: 'Category was successfully created.' }
        format.json { render json: @category, status: :created, location: @category }
      else
        format.html { render action: "new" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1 
  # PUT /categories/1.json
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to categories_url, notice: 'Category was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1 
  # DELETE /categories/1.json
  def destroy
    @category = Category.find(params[:id])
    
    if @category.is_associated?
      redirect_to categories_url, alert: "Category not deleted because associated to a ticket."
    else
      @category.destroy
      redirect_to categories_url, notice: "Category successfully deleted."
    end
  end
end
