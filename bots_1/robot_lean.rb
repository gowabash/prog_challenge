@case = 1
@log = false
def main
  lines = File.open(ARGV[0]).map{ |x| x}
  lines.shift
  lines.each{ |l| do_one l; @case += 1}
end

def do_one(line = '')
  @instr = []
  @current_step = 0
  @orange, @blue = [1,1]
  @ticks = 0
  @logstring = ""
  x = line.empty? ? parseline(' 4 O 2 B 1 B 2 O 4') : parseline(line)
  while(@instr.length > 0)
    faff_about
  end
  puts 'Case #' + @case.to_s + ": #{@ticks}"
end

def faff_about
  @ticks += 1
  ogoal = goal('O').to_i
  bgoal = goal('B').to_i
  odone, bdone = [false, false]

  if  @orange > ogoal
    odone = true
    @orange -= 1
  elsif @orange < ogoal
    odone = true
    @orange += 1
  end

  if @blue > bgoal
    bdone = true
    @blue -= 1
  elsif @blue < bgoal
    bdone = true
    @blue += 1
  end
  nextinstr = @instr.first
  if nextinstr[:c] == 'O' && @orange == nextinstr[:n] && !odone
    @instr.shift
  elsif  nextinstr[:c] == 'B' && @blue == nextinstr[:n] && !bdone
    @instr.shift
  end
end

def log(text = @logstring)
  @logstring = "" if text === @logstring
end

def steplog(text)
  @logstring += text + ' '
end

def goal(tag)
  rel = @instr.select{ |x| x[:c] == tag}
  return 0 if rel.empty?
  return rel.first[:n]
end

def parseline(line)
  @instr = []
  larr = line.split(' ')
  numsteps = larr[0].to_i
  (0...numsteps).each do |i|
    i = i*2+1
    @instr << { c: larr[i], n: larr[i+1].to_i}
  end
end

main
