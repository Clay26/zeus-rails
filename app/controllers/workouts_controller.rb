class WorkoutsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_workout, only: [ :show, :edit, :update, :destroy ]

  def index
    case params[:tab]
    when "templates"
      @workouts = current_user.workouts.where(is_template: true).order(started_at: :desc)
      if turbo_frame_request?
        render partial: "workout_list", locals: { workouts: @workouts }
      else
        render :index
      end
    else
      @workouts = current_user.workouts.where(status: :completed).order(started_at: :desc)
      if turbo_frame_request?
        render partial: "workout_list", locals: { workouts: @workouts }
      else
        render :index
      end
    end
  end

  def templates
    @workouts = current_user.workouts.where(is_template: true)
  end

  def show
  end

  def new
    @workout = current_user.workouts.new
  end

  def create
    @workout = current_user.workout.new(workout_params)
    if @workout.save
      redirect_to @workout, notice: "Workout was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @workout.update(workout_params)
      redirect_to @workout, notice: "Workout was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @workout.destroy
    redirect_to workouts_path, notice: "Workout was successfully destroyed."
  end

  private
  def workout_params
    params.require(:workout).permit(:name, :started_at, :ended_at, :status, :is_template)
  end

  def set_workout
    @workout = current_user.workouts.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to workouts_path, alert: 'Workout not found.'
  end
end
