class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
  end

  # GET /games/1
  # GET /games/1.json
  def show
    if @game.game_won?
      flash.now[:success] = 'You won!'
    elsif @game.game_lost?
      flash.now[:danger] =
        "Game lost! The word was <strong><mark>#{@game.word}</mark></strong>"
    end
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # POST /games
  # POST /games.json
  def create
    if params[:generate_word]
      @game = Game.new
      @game.word = @game.random_word
    else
      @game = Game.new(new_game_params)
    end

    respond_to do |format|
      if @game.save
        flash[:success] = 'Game was successfully created.'
        format.html { redirect_to @game }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update_guess(update_game_params)
        if @game.update_lives?
          flash[:danger] = 'Incorrect guess'
        else
          flash[:success] = 'Correct guess'
        end
        format.html { redirect_to @game }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :show }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      flash[:success] = 'Game was successfully destroyed.'
      format.html { redirect_to games_url }
      format.json { head :no_content }
    end
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def new_game_params
    params.require(:game).permit(:word, :lives)
  end

  def update_game_params
    params.require(:game).permit(:guess)
  end
end
