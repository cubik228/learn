class QuestionsController < ApplicationController
  before_action :set_question!, only: %i[edit update show destroy]

  def show
    @answer = @question.answers.build
    @answers = @question.answers.order(created_at: :desc)
  end

  def destroy
    @question.destroy
    redirect_to questions_path
  end

  def edit; end

  def update
    if @question.update(question_params)
      redirect_to question_path(@question, anchor: "answer-#{@answer.id}")
    else
      render :edit
    end
  end

  def index
    @questions = Question.order(created_at: :desc).page params[:page]
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:success] = 'Question created'
      redirect_to question_path(@question)
    else
      render :new
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def set_question!
    @question = Question.find(params[:id])
  end
end
