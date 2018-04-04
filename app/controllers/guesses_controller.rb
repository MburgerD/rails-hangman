class GuessesController < ApplicationController
  def create
    respond_to do |format|
      @game = Game.find(params[:game_id])
      @guess = @game.guesses.create(guess_params)
      @game.reload
      if @guess.valid?
        if @game.letter_in_word?(@guess.letter)
          flash[:success] = 'Correct guess'
        else
          flash[:danger] = 'Incorrect guess'
        end
        format.html { redirect_to @game }
        format.json { render :show, status: :created, location: @game }
      else
        @errors = @guess.errors.full_messages
        format.html { render 'games/show' }
        format.json { render json: @guess.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def guess_params
    params.require(:guess).permit(:letter)
  end
end
