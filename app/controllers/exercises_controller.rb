class ExercisesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_exercise, only: [ :show, :edit, :update, :destroy ]

  def index
    @exercises = Exercise.all
  end

  def show
  end

  def new
    @exercise = Exercise.new
  end

  def create
    @exercise = Exercise.new(exercise_params)
    if @exercise.save
      redirect_to @exercise, notice: "Exercise was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @exercise.update(exercise_params)
      redirect_to @exercise, notice: "Exercise was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @exercise.destroy
    redirect_to exercises_url, notice: "Exercise was successfully destroyed."
  end

  private
    def exercise_params
      params.require(:exercise).permit(:name, :category, :description)
    end

    def set_exercise
      @exercise = Exercise.find(params[:id])
    end
end
