require_relative '../services/random_word_generator'

class GamesController < ApplicationController
  before_action :set_game, only: %i[show edit update destroy]

  # GET /games
  # GET /games.json
  def index
    @games = Game.all
  end

  # GET /games/1
  # GET /games/1.json
  def show; end

  # GET /games/new
  def new
    @game = Game.new
  end

  # POST /games
  # POST /games.json
  def create
    if params[:game]
      @game = Game.new(new_game_params)
    else
      @game = Game.new word: ::RandomWordGenerator.generate_word
    end

    respond_to do |format|
      if @game.save
        flash[:success] = 'Game was successfully created.'
        format.html { redirect_to @game }
        format.json { render :show, status: :created, location: @game }
      else
        @errors = @game.errors.full_messages
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    respond_to do |format|
      if @game.destroy
        flash[:success] = 'Game was successfully destroyed.'
        format.html { redirect_to games_url }
        format.json { head :no_content }
      else
        flash[:danger] = 'Game was not destroyed.'
        format.html { redirect_to games_url }
        format.json { head :no_content, @game.errors }
      end
    end
  end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def new_game_params
    params.require(:game).permit(:word, :lives)
  end
end
