require_relative("game.rb")
module Codebreaker
  class GameController
    def initialize()
      @default="This is a codebreaker game.\nPress n for new game, h for highscore, q for quit"
    end

    def start()
      puts @default
      while true
        a=gets.chomp
        case a
          when "n"
            g=Game.new()
            puts "You started a new game. \n Press h for hint, e to end game\nYou have #{g.attempts} attempts."
            while true
              b=gets.chomp
              # puts b
              case b
              when /\d/
                z=g.submit_guess(b.to_s)
                puts z
                if z=="You lose!"
                  puts "Press n to start a new game or q to quit"
                  break
                elsif z=="++++"
                  puts "You win! Press s to save your result."
                  if gets.chomp == 's'
                    puts "Enter you name"
                    name=gets.chomp
                    puts "You used #{6 - g.attempts} #{g.attempts>5 ? 'attempts' : 'attempt'} and #{g.hint_used ? 'hint' : 'no hint'}\n\n"
                    result=[6 - g.attempts, g.hint_used]
                    Game.save(name, result)
                    puts @default
                    break
                  else 
                    puts @default
                    break
                  end
                  end
              when 'h'
                puts g.get_hint
              when 'c'
                puts g.zzz
              when 't'
                k=g.set(gets.chomp)
                puts k
              when 'e'
                puts "You ended the game!\n"
                puts @default
                break
            end
          end
          when 'h'
            highscore
            puts "\nPress n to start a new game or q to quit"
          when 'q'
            puts "bye!"
          break

          else puts @default
        end
      end
    end
    def highscore
      a=Game.load_score
      puts "Name       |Attempts used |Hint used |"
      puts a
      a.each do |x|
        puts "#{x[:name]}       | #{x[:result][0]}            | #{x[:result][1] == true ? 'yes' : 'no'} "
      end
    end
  end
end
