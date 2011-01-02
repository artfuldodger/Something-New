class CommentsController < ApplicationController
  before_filter :require_user, :only => [:new, :create, :destroy]
  before_filter :ensure_comment_or_activity_is_mine, :only => [:destroy]
  
  # GET /comments
  # GET /comments.xml
  def index
    if params[:extra] == 'mine'
#      @comments = Comment.joins(:activity).where(:comments => { :user_id => current_user.id } or :activities => { :user_id => current_user.id })
      @comments = Comment.joins(:activity).where('comments.user_id = ? or activities.user_id = ?', current_user.id, current_user.id).paginate(:page => params[:page])
    elsif params[:extra] == 'unread'
      @comments = Comment.joins(:activity).where('comments.seen = ? and activities.user_id = ?', false, current_user.id).paginate(:page => params[:page])
      @comments.each do |comment|
        Comment.find(comment.id).update_attributes(:seen => true)
      end
    else
      @comments = Comment.paginate(:page => params[:page])
    end
    
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.xml
  def show
    @comment = Comment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comment }
    end
  end

  # GET /comments/new
  # GET /comments/new.xml
  def new
    @activity = Activity.find(params[:activity_id])
    @comment = @activity.comments.new

    respond_to do |format|
      format.html # new.html.erb
      format.js
      format.xml  { render :xml => @comment }
    end
  end

  # POST /comments
  # POST /comments.xml
  def create
    @activity = Activity.find(params[:activity_id])
    @comment = @activity.comments.new(params[:comment])
    @comment.user = current_user
    # Don't want to get notified we have an unread comment from ourselves
    if @activity.user == current_user
      @comment.seen = true
    end
    @comment.save
    
    respond_to do |format|
      if @comment.save
        format.html { redirect_to(activity_path(@activity), :notice => 'Comment was successfully created.') }
        format.xml  { render :xml => @comment, :status => :created, :location => @comment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.xml
  def destroy
    @activity = Activity.find(params[:activity_id])
    @comment = @activity.comments.find(params[:id])
    @comment.destroy
    flash[:notice] = 'Comment removed.'
    redirect_to activity_path(@activity)
  end
  
  
  private
  def ensure_comment_or_activity_is_mine
    @activity = Activity.find(params[:activity_id])
    @comment = @activity.comments.find(params[:id])
    if current_user != @activity.user and current_user != @comment.user
      flash[:notice] = 'You cannot delete comments that aren\'t yours on activities that also aren\'t yours.'
      redirect_to(activity_path(@activity))
      return false
    end
  end
end

