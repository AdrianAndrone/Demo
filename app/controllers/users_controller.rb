class UsersController < ApplicationController
  helper_method :user_state

  def new
    @user=User.new
  end

  def index
    @confirmed_users=User.where(:state=>'accepted')
    @unconfirmed_users=User.where(:state=> 'pending')
  end


  def resource
    @current_user ||= User.find(session[:id]) if session[:id]
    @collection=@current_user.enrollments
  end

  def update
    @user=User.find params[:id]
    @user.change_role
    if @user.update_attributes(params[:user])
      redirect_to users_path
      flash[:notice]='Rolul a fost schimbat.'
    else
      render 'edit'
    end
  end

  def show
    # @user=User.find params[:id]
    @candidates=current_user.enrollments
  end

  def suspend
    @user=User.find params[:id]
    @user.suspend
    @user.drop
    flash[:notice]='Cont suspendat.'
    redirect_to :back
  end


  def accept
    @user=User.find params[:id]
    @user.approve
    redirect_to :back
  end

  private

  def user_state(user)
    @user=user
    case @user.state.to_sym
      when :pending
        "badge badge-warning"
      when :accepted
        "badge badge-success"
      else
        "badge badge-info"

    end
  end

  # def update
  #   @user=User.find_by_id params[:id]
  #   @user.update_attributes(params[:role])
  #   if @user.save
  #     redirect_to :back
  #   else
  #     render 'edit'
  #   end
  # end


end
