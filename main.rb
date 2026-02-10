require 'colorize'
require_relative './lib/player'
require_relative './lib/computer'
require_relative './lib/game'

puts "Welcome to Mastermind! Let's play!"
game = Game.new
game.play
