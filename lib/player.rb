class Player
  COLORS = %w[red green blue yellow orange violet pink white black]

  def initialize(name)
    @name = name
  end

  def player_guess
    puts 'Pick four colors to take a guess!'
    get_color_choices
  end

  def player_code
    puts 'Pick four colors to make your secret code!'
    get_color_choices
  end

  private

  def get_color_choices
    choices = []
    4.times do |i|
      loop do
        puts "Color #{i + 1}:"
        color = gets.chomp.downcase
        if COLORS.include?(color)
          choices << color
          break
        else
          puts "Invalid color! Choose from: #{COLORS.join(', ')}"
        end
      end
    end
    choices
  end
end
