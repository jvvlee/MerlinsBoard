class Api::GradesController < Api::ApiController
  before_action(except: [:index]) {admins_only(params["course_id"])} #wil always need to pass this in on every fetch
  
  def destroy
    @grade = Grade.find(params[:id])
    @grade.destroy
    render json: {}
  end
  
  def create
    @grade = Grade.new(grade_params)
    
    if @grade.save
      render json: @grade
    else
      render json: status: 422, @grade.errors.full_messages
    end
  end
  
  def update
    @grade = Grade.find(params[:id])
    
    if @grade.save
      render json: @grades
    else
      render json: status: 422, @grade.errors.full_messages
    end
  end
  
  def index
    #I may want an internal control here instead of using the before_action...
    @grades = Grade.includes(:assignment, :course, :user).where("user_id = ? AND course_id", params["user_id"], params["course_id"])    
  end
  
  private 
  
  def grade_params
    params.require(:grade).permit(:grade, :assignment_id, :user_id)
  end
end
