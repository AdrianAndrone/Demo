class ProfileController < ApplicationController

  layout :resolve_layout

  def new
    @profile=Profile.new
  end

  def create
    @profile=current_user.build_profile params[:profile]
    @profile[:vcode]=SecureRandom.hex(10)
    if @profile.save
      redirect_to courses_path
      flash[:notice] =  'Profilul a fost creat.'
    else
      render 'new'
    end
  end

  def show
    @user=User.find_by_id params[:id]
    @profile=@user.profile
  end

  def edit
    @profile=current_user.profile
  end

  def update
    @profile=current_user.profile
    if @profile.update_attributes(params[:profile])
      flash[:notice]='succes'
      redirect_to [current_user, @profile]
    else
      render 'edit'
    end

  end




  def index

  end

  protected

  def resolve_layout
    case action_name
      when 'new'
        'other'
      else
        'application'
    end
  end

end
