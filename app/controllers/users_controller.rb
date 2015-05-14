class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /users GET /users.json
  def index
    @users = User.includes(:tickets).order("name ASC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end
  
  # GET /users/1 GET /users/1.json
  def show
    @user = User.find(params[:id])
    @tickets = @user.tickets

    if current_user == @user || current_user.is_admin || current_user.is_moderator
      respond_to do |format|
        format.html # show.html.erb 
        format.json { render json: @user }
      end
    else
      respond_to do |format|
        format.html {redirect_to root_url} # return to home 
        format.json {redirect_to root_url} # return to home
      end
    end
  end
  
  # GET /users/new GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users POST /users.json
  def create
    @user = User.new(params[:user])
    @user.is_admin = User.count == 0

    respond_to do |format|
      if @user.save
        # Tell the AdminMailer to send a welcome email after save
        AdminMailer.welcome_email(@user)
        
        format.html { redirect_to users_url, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1 PUT /users/1.json
  def update
    @user = User.find(params[:id])
    @param = params[:user]
    
    if @param[:password].empty?
      @param.delete(:password)
      @param.delete(:password_confirmation)
    end

    respond_to do |format|
      if @user.update_attributes(@param)
        format.html { redirect_to users_url, notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end

  # DELETE /users/1 DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])

    if @user.is_admin
      redirect_to users_path, alert: 'Cannot delete admin.'
    else
      if @user.is_associated?
        redirect_to users_path, alert: 'Cannot delete user because associated to a ticket.'
      else
        @user.destroy
        redirect_to users_url, notice: 'User was successfully deleted.'
      end
    end
  end
end
