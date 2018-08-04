require 'pry

:game_hash = {
    home: {
      team_name: "Brooklyn Nets",
      colors: ["Black", "White"],
      players: {
        "Alan Anderson" => {
          number: 0,
          shoe: 16,
          points: 22,
          rebounds: 12,
          assists: 12,
          steals: 3,
          blocks: 1,
          slam_dunks: 1
        },
        "Reggie Evans" => {
          number: 30,
          shoe: 14,
          points: 12,
          rebounds: 12,
          assists: 12,
          steals: 12,
          blocks: 12,
          slam_dunks: 7 
        },
        "Brook Lopez" => {
          number: 11,
          shoe: 17,
          points: 17,
          rebounds: 19,
          assists: 10,
          steals: 3,
          blocks: 1,
          slam_dunks: 15 
        },
        "Mason Plumlee" => {
          number: 1,
          shoe: 19,
          points: 26,
          rebounds: 12,
          assists: 6,
          steals: 3,
          blocks: 8,
          slam_dunks: 5 
        },
        "Jason Terry" => {
          number: 31,
          shoe: 15,
          points: 19,
          rebounds: 2,
          assists: 2,
          steals: 4,
          blocks: 11,
          slam_dunks: 1 
        }
      }
    },
    away: {
      team_name: "Charlotte Hornets",
      colors: ["Turquoise", "Purple"],
      players: {
        "Jeff Adrien" => {
          number: 4,
          shoe: 18,
          points: 10,
          rebounds: 1,
          assists: 1,
          steals: 2,
          blocks: 7,
          slam_dunks: 2 
        },
        "Bismak Biyombo" => {
          number: 0,
          shoe: 16,
          points: 12,
          rebounds: 4,
          assists: 7,
          steals: 7,
          blocks: 15,
          slam_dunks: 10
        },
        "DeSagna Diop" => {
          number: 2,
          shoe: 14,
          points: 24,
          rebounds: 12,
          assists: 12,
          steals: 4,
          blocks: 5,
          slam_dunks: 5 
        },
        "Ben Gordon" => {
          number: 8,
          shoe: 15,
          points: 33,
          rebounds: 3,
          assists: 2,
          steals: 1,
          blocks: 1,
          slam_dunks: 0 
        },
        "Brendan Haywood" => {
          number: 33,
          shoe: 15,
          points: 6,
          rebounds: 12,
          assists: 12,
          steals: 22,
          blocks: 5,
          slam_dunks: 12 
        }
      }
    }

def num_points_scored(player)
  player_stats(player)[:points]
end 

def shoe_size(player)
  player_shoe = nil
  GAME_HASH.each do |location, team_data|
    team_data.each do |team_data_key, team_data_value|
      if team_data_key == :players
        team_data_value.each do |player_name, player_stats|
          if player_name == player 
            player_stats.each do |stat, value|
              if stat == :shoe 
                player_shoe = value
              end 
            end 
          end 
        end 
      end 
    end 
  end
  player_shoe
end 

def team_colors(team_name)
  colors = []
  game_hash.each do |location, team_data|
    if team_data.values.include?(team_name)
      colors = team_data[:colors]
    end 
  end 
  colors
end 

def team_names
  team_names = []
  game_hash.each do |location, team_data|
    team_data.each do |team_data_key, team_data_values|
      if team_data_key == :team_name
        team_names << team_data_values
      end 
    end 
  end 
  team_names
end

def player_numbers(team_name)
  jersey_numbers = []
  game_hash.each do |location, team_data|
    # if team_data.values.include?(team_name)
    #   team_data.each do |team_data_key, team_data_values|
    #     if team_data_key == :players 
    #       team_data_values.each do |player, stats|
    #         stats.each do |stat_key, stat_value|
    #           if stat_key == :number
    #             jersey_numbers << stat_value
    #           end 
    #         end 
    #       end 
    #     end 
    #   end 
    # end 
    if team_data[:team_name][team_name]
      team_data[:players].each do |player_name, stats|
        jersey_numbers << team_data[:players][player_name][:number]
      end 
    end 
  end 
  jersey_numbers
end 

def player_stats(player)
  player_stats = {}
  game_hash.each do |location, team_data|
    if team_data[:players][player]
      player_stats = team_data[:players][player]
    end 
  end 
  player_stats
end 

def big_shoe_rebounds
  biggest_shoe = 0
  biggest_shoe_player = ""
  big_shoe_rebounds = nil
  game_hash.each do |location, team_data|
    team_data.each do |team_data_key, team_data_values|
      if team_data_key == :players 
        team_data_values.each do |player_name, stats|
          
          # block to grab biggest shoe size and player
          if shoe_size(player_name) > biggest_shoe
            biggest_shoe = shoe_size(player_name)
            biggest_shoe_player = player_name
          end    
          
          if player_name == biggest_shoe_player
            stats.each do |stat_key, stat_value|
              if stat_key == :rebounds 
                big_shoe_rebounds = stat_value
              end 
            end 
          end 
        end   # end iteration of team_data_values
      end 
    end 
  end 
  big_shoe_rebounds
end 

def most_points_scored
  most_points = 0 
  most_points_player = ""
  game_hash.each do |location, team_data|
    team_data[:players].each do |player_name, stats|
      if stats[:points] > most_points
        most_points = stats[:points]
        most_points_player = player_name
      end 
    end 
  end 
  most_points_player
end 

def winning_team
  home_points = 0 
  away_points = 0
  winning_team = ""
  game_hash.each do |location, team_data|
    if location == :home 
      team_data[:players].each do |player, stats|
        home_points += team_data[:players][player][:points]
      end 
    else
      team_data[:players].each do |player, stats|
        away_points += team_data[:players][player][:points]
      end 
    end 
  end
  if home_points > away_points 
    winning_team = game_hash[:home][:team_name]
  elsif away_points > home_points
    winning_team = game_hash[:away][:team_name]
  end
  winning_team
end 

def player_with_longest_name
  longest_name = ""
  game_hash.each do |location, team_data|
    team_data[:players].each do |player_name, stats|
      if player_name.size > longest_name.size
        longest_name = player_name
      end 
    end 
  end 
  longest_name
end 

def long_name_steals_a_ton?
  longest_name = player_with_longest_name
  most_steals = 0
  long_name_steals = 0
  game_hash.each do |location, team_data|
    long_name_steals = team_data[:players][longest_name][:steals]
    team_data[:players].each do |player_name, stats|
      if team_data[:players][player_name][steals] > most_steals
        most_steals = team_data[:players][player_name][steals]
      end 
    end 
    if long_name_steals >= most_steals
      true
    end 
    false
  end 
end 

def long_name?
  # longest_name = ""
  longest_name = player_with_longest_name
  puts longest_name
end 

long_name?


