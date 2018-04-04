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
    if params[:generate_word]
      @game = Game.new
      @game.word = ::RandomWordGenerator.generate_word
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
end
