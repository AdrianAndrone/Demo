class AnnouncementsController < ApplicationController

  def new
    @announcement = Announcement.new
  end

  def index
    @announcements = Announcement.desc
  end

  def create
    @announcement=current_user.announcements.build params[:announcement]
    if @announcement.save
      redirect_to @announcement
      flash[:message]= 'Un anunt a fost creat.'
    else
      render 'new'
    end
  end

  def show
    @announcement=Announcement.find_by_id params[:id]
    @comment=@announcement.comments
    @comm=Comment.new
  end

  def update
    @announcement=Announcement.find params[:id]
    #@comment=@announcement.comments.find(params[:announcement_id][:id])
    if @announcement.user==current_user or current_user.admin?
      if @announcement.update_attributes params[:announcement]
        redirect_to announcement_path(@announcement)
      else
        render 'edit'
      end
    else
      redirect_to :back
      flash[:notice]='Nu esti autorizat sa stergi acest anunt.'
    end
  end

  def destroy
    @announcement=Announcement.find_by_id params[:id]
    if  @announcement.user==current_user or current_user.admin?
      @announcement.destroy
      redirect_to :back
      flash[:notice]='A fost sters'
    else
      redirect_to :back
      flash[:notice]='Nu esti autorizat sa stergi acest anunt.'
    end
  end


  def edit
    @announcement=Announcement.find params[:id]
  end
end
