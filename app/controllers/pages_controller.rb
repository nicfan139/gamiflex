class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    if user_signed_in?
      if policy(current_user).suggest?
        @suggestion = current_user.suggestion
        @suggestion = nil if @suggestion == []
      elsif policy(current_user).choose_games?
        games_played = current_user.states.map do |element|
          element.game_id.to_s
        end
        game_list = %w(233 987 559 1628 6036 8173 533 1942 1020 20 239 127 501 72 7331 974 27081 1905 7360 121 2691 529 12517 11198 4754 36872 1331 2350  9061 434)
        game_list = game_list - games_played
        @games = game_list.map do |game|
          Game.find_with_igdb(game)
        end
      end
    end
  end

  def profile
  end

  def mygames
  end
end
