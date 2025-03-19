class ExercisesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_exercise, only: [ :show, :edit, :update, :destroy ]

  def index
    @categories = Exercise.pluck(:category).uniq

    @exercises = Exercise.all

    filter_by_category
    filter_by_search

    if turbo_frame_request?
      render partial: "exercises/exercise_drawer", locals: { categories: @categories, exercises: @exercises }
    else
      render :index
    end
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
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @exercise.update(exercise_params)
      redirect_to @exercise, notice: "Exercise was successfully updated."
    else
      render :edit, status: :unprocessable_entity
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

    def filter_by_category
      return if params[:category].blank? || params[:category].casecmp?("all")

      @exercises = @exercises.where("LOWER(category) = ?", params[:category].downcase)
    end

    def filter_by_search
      return if params[:search].blank?

      @exercises = @exercises.where("name ILIKE ?", "%#{params[:search]}%") if params[:search].present?
    end
end
