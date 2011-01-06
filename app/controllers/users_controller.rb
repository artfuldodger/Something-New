class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user]) 
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_back_or_default account_url
    else
      render :action => :new
    end
  end
  
  def show
    if params[:id]
      @user = User.find(params[:id])
    else
      @user = current_user
    end
    @activities = @user.activities.find(:all, :order => 'date ASC').paginate(:page => params[:page], :per_page => 10)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user, :except => [:password_salt, :crypted_password, :perishable_token, :persistence_token, :single_access_token] }
    end
  end

  def edit
    @user = @current_user
  end
  
  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
  
  def index
    @users = User.paginate(:order => 'created_at desc', :page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users, :except => [:password_salt, :crypted_password, :perishable_token, :persistence_token, :single_access_token] }
    end
  end
end