class CoursesController < ApplicationController

  helper_method :enrollment_resourse

  def new
    @course=Course.new
  end

  def create
    @enrollment=current_user.enrollments.build params[:enrollment]
    @course=@enrollment.build_course params[:course]
    @course.add_vcode(current_user) if current_user.teacher?
    if @course.save
      redirect_to @course
      flash[:message]='Un curs a fost creat.'
    else
      render 'new'
    end
  end

  def update
    @course=Course.find params[:id]
    if @course.update_attributes params[:course]
      redirect_to courses_path
    else
      render 'edit'
  end

  end


  def index
    @all_courses=Course.all
    @first_year_collection=Course.first_year
    @second_year_collection=Course.second_year
    @third_year_collection=Course.third_year
    @last_year_collection=Course.last_year
    #@enrollment=@second_year.enrollments.where(user_id=>current_user.id).find_by params[:id]
    #@search=Course.search(params[:search])
    unless params[:search].blank?
      @search = Course.search do
        fulltext params[:search]
      end
    @courses_searched = @search.results
    end


    #@resource=find_course
    # unless params[:search]==nil
    #   flash[:notice]='Nu exista'
    # end
    # if current_user.teacher?
    #   current_user.courses. do |obj|
    #     @my_courses=[]
    #     fullname=[current_user.profile.firstname,' ',current_user.profile.lastname].join("")
    #     if obj.owner==fullname
    #       @my_courses<<obj
    #     else
    #       raise 'Nu ai cursuri'
    #     end
    #   end
    # else
    #   @my_courses=current_user.courses
    # end
    @teacher_courses=Course.where(:vcode=>current_user.profile.vcode)
    @my_courses=current_user.courses.order('name ASC').reorder('year ASC')
    @courses =Kaminari.paginate_array(@all_courses).page(params[:page]).per(10)
  end

  def show
    @course=Course.find_by_id params[:id]
    @teacher_profile = Profile.find_by_vcode(@course.vcode )
    @teacher=@teacher_profile.user
    @collection=current_user.courses
    # @collection=current_user.enrollments.where(:course_id=>@course.id)
    # if @collection.nil?
    #   @state = @collection.last.state.to_sym
    # end
  end


  def destroy
    @course=Course.find_by_id params[:id]
    @course.destroy
    redirect_to :back
    flash[:notice]='A fost sters'
  end

  private

  def resource
    current_user.courses
  end

  def enrollment_resourse
    @resourse=Course.find(params[:id]).enrollments
  end



end
