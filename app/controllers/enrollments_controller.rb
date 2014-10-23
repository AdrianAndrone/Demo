class EnrollmentsController < ApplicationController
  #before_filter :uniqueness
  helper_method :resource, :helper_state, :remove_course_on_reject


  def join
    @course=Course.find(params[:course_id])
    @enrollment=@course.enrollments.build(:user_id => current_user.id, :course_id=>@course.id)
    # case @enrollment.state
    # when :accepted
    #   flash[:notice]='Ai fost inscris.'
    #   redirect_to controller: 'courses', action: 'index'
    # when :rejected
    #   flash[:notice]='Ai fost respins'
    #   redirect_to @courses
    # else
    #   flash[:notice]='Waiting for approving.'
    # @a=uniqueness
    # if @a==true or @a.empty?
    #   @enrollment.save
    #   flash[:notice]='Asteptati confirmarea'
    #   redirect_to :back
    # else
    #   redirect_to :back
    #   flash[:message]='Esti inscris deja.Asteapta confirmarea'
    # end
    #end
    # @a=uniqueness(@enrollment)
    # if @a==true or Enrollment.all.empty
    @enrollment.increment(:frequency, 1)
    @enrollment.save

    flash[:notice]='Așteptați confirmarea !'
    @enrollment.change_taken_attributes


    redirect_to :back
    # else
    #   redirect_to :back
    #   flash[:message]='Esti inscris deja.Asteapta confirmarea'
    # end
  end

  def accept
    @course=Course.find(params[:course_id])
    @enrollment=@course.enrollments.find(params[:id])
    @accept_q=@enrollment.increment(:frequency, 1)
    @enrollment.approve
    #flash[:notice]='Ai fost acceptat'
    redirect_to :back
  end


  def reject
    @course=Course.find(params[:course_id])
    @enrollment=@course.enrollments.find(params[:id])
    @accept_q=@enrollment.increment(:frequency, 1)
    #remove_course_on_reject @enrollment
    @enrollment.reject
    redirect_to :back
    #flash[:notice]='Ai fost respins'
  end

  def suspend
    @course=Course.find(params[:course_id])
    @enrollment=@course.enrollments.find(params[:id])
    @enrollment.suspend
    @enrollment.drop
    #flash[:notice]='Suspendat'
    redirect_to :back
  end

  def index
    @course=Course.find(params[:course_id])
    @enrollments=@course.enrollments
  end

  private

  def helper_state(enrollment)
    @enrollment=enrollment
    case @enrollment.state.to_sym
      when :pending
        "badge badge-warning"
      when :accepted
        "badge badge-success"
      else
        "badge badge-info"

    end
  end

  # def remove_course_on_reject(enrollment)
  #   @enrollment=enrollment
  # end

  # private

  # def uniqueness(enrollment)
  #   # @course=Course.find(params[:course_id])
  #   # @enrollment=@course.enrollments.find(params[:id])
  #   # @q=Enrollment.all.each do |t|
  #   # @enrollment.user_id == t.user_id and   @enrollment.course_id == t.course_id
  #   # end
  #   @enrollment=enrollment
  #   @collection=Enrollment.all
  #   unless @collection.empty?
  #     @collection.each do |inst|
  #       @enrollment.user_id == inst.user_id and   @enrollment.course_id == inst.course_id
  #       return true
  #     end
  #   end
  #end


end

