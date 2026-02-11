class Game
  MAX_TURNS = 12

  def initialize
    @player = Player.new
    @computer = Computer.new
    @board = []
  end

  def game_mode
    mode = nil
    until %w[maker breaker].include?(mode)
      puts 'Please pick a game mode! (maker/breaker)'
      mode = gets.chomp.downcase
    end

    case mode
    when 'maker' then @code = @player.player_code
    when 'breaker' then @code = @computer.generate_code
    end
  end

  def display_board
    @board.each do |guess|
      guess.each_with_index do |color, i|
        if @code[i] == color
          print "#{color} ".colorize(:green)
        elsif @code.include?(color)
          print "#{color} ".colorize(:yellow)
        else
          print "#{color} ".colorize(:red)
        end
      end
      puts
    end
  end

  def generate_feedback(guess)
    feedback = []
    guess.each_with_index do |color, i|
      feedback[i] = if @code[i] == color
                      :exact
                    elsif @code.include?(color)
                      :wrong_position
                    else
                      :not_in_code
                    end
    end
    feedback
  end

  def winner?
    @board.last == @code
  end

  def game_over?
    @board.length >= MAX_TURNS
  end

  def play
    puts 'Do you want to be the code maker or code breaker?'
    game_mode
    puts "You can choose from #{Player::COLORS.join(', ')}"

    until winner? || game_over?
      turn_number = @board.length + 1
      remaining = MAX_TURNS - @board.length
      puts "\n=== Turn #{turn_number}/#{MAX_TURNS} (#{remaining} remaining) ==="
      if mode == 'breaker'
        guess = @player.player_guess
        @board.push(guess)
        display_board
      else
        guess = @computer.computer_guess
        @board.push(guess)
        display_board

        feedback = generate_feedback(guess)
        @computer.record_feedback(guess, feedback)
      end
    end

    if winner?
      if mode == 'breaker'
        puts 'Congratulation! You cracked the code!'
      else
        puts 'The computer cracked your code!'
      end
    else
      puts "Game Over! The code was: #{@code.join(', ')}"
    end
  end
end
