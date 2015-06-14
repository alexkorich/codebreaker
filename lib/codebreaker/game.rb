module Codebreaker
  class Game
    attr_reader :attempts, :hint_used

    def initialize()
      @hint_used = false
      @hint=''
      @secret_code = generate_code
      @attempts=10
    end

    def get_hint
      if @hint_used then return @hint
      else
        @hint_used=true
        a="xxxx"
        b=rand(4)
        a[b] = @secret_code[b]
        @hint = a
      end 
    end

    def zzz
      @secret_code
    end
    
    def submit_guess(guess)
      if has_attempts
        if valid(guess)
          respond=[]
          g=guess.to_s.split(//)
          s=@secret_code.split(//)
          g.each_index do |i|
            if g[i]==s[i]
              respond.push("+")
              s[i]="x"
              g[i]="z"
            end
          end
          g.each_index do |i|
            s.each_index do |j|
              if g[i] == s[j]
                respond.push("-") 
                s[j]="y"
                g[i]="t"
              else next
              end
            end
          end
          @attempts-=1
          {result:respond.join,attempts_left: @attempts}
          else "Please, enter 4-digits code with 1-6 numbers"
          end
        else "You lose!"
      end
    end

    def set(tt)
      @secret_code=tt
    end

    def has_attempts
      @attempts > 0
    end

    def valid (code)
      code.to_s.match(/^[1-6]{4}$/)
    end

    def self.save(name, result)
      t={name: name, result:result}
      if File.exist?('codebreaker.score')
        a=Marshal.load(File.read('codebreaker.score'))
        a<<t
        b=a.sort_by {|h| h[:result][0]}
        File.open("codebreaker.score", 'w') {|f| f.write(Marshal.dump(b)) }
      else
        a=[]<<t
        File.open("codebreaker.score", 'w') {|f| f.write(Marshal.dump(a)) }
      end
    end

    def self.load_score
      begin
        a=Marshal.load(File.read('codebreaker.score'))
        return a
      rescue =>err
        puts "No highscore file found!"
      end
      # raise Error
    end

    private
    def generate_code
      a=[]
      4.times do
        a<<1+rand(6)
      end
      a.join
    end
    
  end
end