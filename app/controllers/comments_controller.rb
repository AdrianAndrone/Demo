class CommentsController < ApplicationController
  def new
    @announcement=Announcement.find params[:announcement_id]
    @comment=@announcement.comments.build
  end

  def create
    @announcement=Announcement.find params[:announcement_id]
    @comment=@announcement.comments.build params[:comment]
    @comment.user_id=current_user.id
    @comment.save
    redirect_to @announcement
  end

  def index
    @announcement=Announcement.find params[:announcement_id]
    @comments=@announcement.comments.all
  end

  def edit
    @announcement=Announcement.find params[:announcement_id]
    @comment=@announcement.comments.find params[:id]
  end

  def update

    @announcement=Announcement.find params[:announcement_id]
    @comment=@announcement.comments.find params[:id]
    if @announcement.user == current_user or current_user.admin?
      if @comment.update_attributes(params[:comment])
        redirect_to @announcement
        flash[:notice]='update'
      else
        render 'edit'
      end
    else
      redirect_to @announcement
      flash[:notice] = 'Nu esti autorizat'
    end
  end

  def destroy
    @announcement=Announcement.find params[:announcement_id]
    if @announcement.user == current_user or current_user.admin?
      @comment=Comment.where(announcement_id=@announcement.id).find(params[:id])
      @comment.destroy
      redirect_to :back
      flash[:notice]='A fost sters.'
    else
      redirect_to :back
      flash[:notice]='Nu esti autorizat sa stergi acest comment.'
    end
  end

end
