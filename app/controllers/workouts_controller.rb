class WorkoutsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_workout, only: [ :show, :edit, :update, :destroy ]

  def index
      @workouts = current_user.workouts.where(status: :completed).order(started_at: :desc)
  end

  def completed
    if !turbo_frame_request?
      redirect_to workouts_path
    end

    @workouts = current_user.workouts.where(status: :completed).order(started_at: :desc)

    render partial: "workouts/completed", workouts: @workouts
  end

  def templates
    if !turbo_frame_request?
      redirect_to workouts_path
    end

    @templates = current_user.workouts.where(is_template: true).order(started_at: :desc)

    render partial: "workouts/templates", templates: @templates
  end

  def show
  end

  def new
    @workout = current_user.workouts.new(is_template: params[:template] == "true")
  end

  def create
    @workout = current_user.workouts.new(workout_params)
    @workout.is_template = params[:template] == "true"

    if @workout.save
      notice = @workout.is_template ? "Template created successfully." : "Workout started successfully."
      redirect_to @workout, notice: notice
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
      notice = @workout.is_template ? "Template destroyed successfully." : "Workout destroyed successfully."
    redirect_back fallback_location: workouts_path, notice: "Workout was successfully destroyed."
  end

  private
  def workout_params
    params.require(:workout).permit(
      :name, :notes, :started_at, :ended_at, :status, :weight_unit,
      workout_exercises_attributes: [
        :id, :exercise_id, :notes, :order, :_destroy,
        exercise_sets_attributes: [
          :id, :reps, :weight, :set_number, :notes, :_destroy
        ]
    ])
  end

  def set_workout
    @workout = current_user.workouts.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to workouts_path, alert: 'Workout not found.'
  end
end
