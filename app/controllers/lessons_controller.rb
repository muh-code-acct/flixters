class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_course_enrollment, only: [:show]
  
  def show
  end

  private

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end

  def require_course_enrollment
    if current_lesson.current_user != current_user.enrolled_in?(current_lesson.section.course)
      redirect_to course_path(@course) , alert: 'Please enroll in the course to access lessons'
    end
  end
end
