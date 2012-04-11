class Bot
  attr_accessor :loc, :steps, :name, :log

  def initialize(name)
    @name = name
    @steps = 0
    @loc = 1
  end

  def move(bot, number)
    if bot == name
      @steps += (number - @loc).abs + 1
      @loc = number
      @my_step = true
    else
      @my_step = false
    end
  end

  def sync
    if @my_step && @other.steps >= @steps
      @steps = @other.steps + 1
    end
  end

  def other(bot)
    @other = bot
  end
end

file = File.open ARGV[0]
count = file.readline 
i = 0
file.each do |line|
  i +=1
  line.gsub!(/^\d+ /, '')
  buttons = line.split(' ')
  o = Bot.new 'O'
  b = Bot.new 'B'
  b.other o
  o.other b
  (0..(buttons.length / 2 - 1)).each do |t|
    bot = buttons[2*t]
    number = buttons[2*t + 1].to_i
    o.move(bot, number)
    b.move(bot, number)
    o.sync
    b.sync
  end
  max = o.steps > b.steps ? o.steps : b.steps 
  puts "Case ##{i}: #{max}"
end

