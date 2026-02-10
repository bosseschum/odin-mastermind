require 'colorize'
require_relative './lib/player'
require_relative './lib/computer'
require_relative './lib/game'

puts "Welcome to Mastermind! Let's play!"
puts 'What is your name?'
name = gets.chomp
game = Game.new(name)
game.play
