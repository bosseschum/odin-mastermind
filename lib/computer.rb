class Computer
  COLORS = %w[red green blue yellow orange violet pink white black]

  def initialize
    @guesses = []
    @exact_matches = {}
    @colors_in_code = []
    @eliminated = []
  end

  def generate_code
    COLORS.sample(4)
  end

  def record_feedback(guess, feedback_array)
    guess.each_with_index do |color, position|
      case feedback_array[position]
      when :exact
        @exact_matches[position] = color
        @colors_in_code << color unless @colors_in_code.include?(color)
      when :wrong_position
        @colors_in_code << color unless @colors_in_code.include?(color)
      when :not_in_code
        @eliminated << color unless @eliminated.include?(color)
      end
    end
    @guesses << guess
  end

  def computer_guess
    if @guesses.empty?
      guess = generate_code
      @guesses.push(guess)
      return guess
    end

    guess = Array.new(4)

    @exact_matches.each do |position, color|
      guess[position] = color
    end

    4.times do |i|
      next if guess[i]

      available_colors = COLORS - @eliminated
      guess[i] = available_colors.sample
    end
    guess
  end
end
