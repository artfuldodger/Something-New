class MessagesController < ApplicationController
  before_filter :require_user
  before_filter :ensure_to_me, :only => [:destroy]
  before_filter :ensure_my_message, :except => [:destroy, :index, :new, :create]
  # GET /messages
  # GET /messages.xml
  def index
    @messages = Message.where(:to_user => current_user.id).order('id desc').paginate(:page => params[:page])
    @sent_messages = Message.where(:user_id => current_user.id).order('id desc').paginate(:page => params[:sent_page])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
    
    # Update message as seen
    if !@message.seen and @message.to_user == current_user.id
      @message.seen = true
      @message.save
    end
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # POST /messages
  # POST /messages.xml
  def create
    params[:message][:user] = current_user
    to_user = User.find_by_login(params[:message][:to_user])
    if !to_user
      flash[:notice] = "Couldn't find that person! Make sure you're typing the name correctly."
      redirect_to :back
      return false
    end
    params[:message][:to_user] = to_user.id
    
    @message = Message.new(params[:message])

    respond_to do |format|
      if @message.save
        to_user = User.find(@message.to_user)
        format.html { redirect_to(messages_path, :notice => "Message was sent to #{to_user.login}") }
        format.xml  { render :xml => @message, :status => :created, :location => @message }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy
    @message.destroy

    respond_to do |format|
      format.html { redirect_to(messages_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  def ensure_my_message
    @message = Message.find(params[:id])
    if @message.user != current_user && @message.to_user != current_user.id
      flash[:notice] = 'This is not your message.'
      redirect_to :back
      return false
    end
  end
  
  def ensure_to_me
    @message = Message.find(params[:id])
    if @message.to_user != current_user.id
      flash[:notice] = 'This was not sent to you.'
      redirect_to :back
      return false
    end
  end
end
