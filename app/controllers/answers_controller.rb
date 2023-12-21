class AnswersController < ApplicationController
  before_action :set_question!

  def create
    @answer = @question.answers.build(answer_params)
    if @answer.save
      flash[:success] = 'Answer created'
      redirect_to question_path(@question)
    else
      @answers = Answer.all.order(created_at: :desc)
      render 'questions/show'
    end
  end

  def edit
    @answer = @question.answers.find params[:id]
  end

  def update
    @answer = Answer.find(params[:id])
    if @answer.update(answer_params)
      redirect_to question_path(@answer.question)
    else
      render :edit
    end
  end

  def destroy
    answer = @question.answers.find params[:id]
    answer.destroy
    flash[:success] = 'Answer delete'
    redirect_to question_path(@question)
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def set_question!
    @question = Question.find(params[:question_id])
  end
end
