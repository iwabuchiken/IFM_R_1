# -*- coding: utf-8 -*-
# => REF coding http://www.kkaneko.com/rinkou/ruby/rubyintro.html
# => REF http://stackoverflow.com/questions/2440752/ruby-mixin-gives-unidentified-constant-error answered Mar 14 '10 at 1:30
require 'fileutils'

# puts "hello"
class ABC
  
  def initialize(name, number)
    
    @name   = name
    @number = number
    
  end
  
  def get_name
    
    @name
    
  end
  
  def get_number
    @number
  end
end

def logout(label)

  
  target = "testlog_#{__FILE__}.txt"
  
  if not File.exists?(target)
    
    FileUtils.touch(target)
    
  end
  
  # content = "abcdefg"
  # File.open(target, "w+") do |f|
  File.open(target, "a") do |f|
    f.write("[" + __FILE__ + " "  + "/" + __LINE__.to_s + " " + Time.now.to_s + "]" + "\n")
    # f.write(content)
    f.write(label)
    f.write("\n")
  end

end#def logout(label)

def job
  
  a1 = ABC.new("a1", 111)
  a2 = ABC.new("a2", 222)
  a3 = ABC.new("a3", 333)
  a4 = ABC.new("a4", 444)
  a5 = ABC.new("a5", 555)
  
  aaa = [a1, a2, a3, a4,a5]
  
  puts "<1>"
  puts aaa.class
  puts aaa.length

  puts "<2>"
  aaa2 = aaa.select{|x| x.get_number % 2 == 0}
  
  puts "aaa2.length.to_s=" + aaa2.length.to_s
  puts "aaa2.class.to_s=" + aaa2.class.to_s
  puts "aaa2[0]=" + aaa2[0].class.to_s

  puts  
  puts aaa2.length

  puts "<3>"
  puts
  aaa3 = aaa.select{|x| x.get_number}
  
  puts "aaa3.length.to_s=" + aaa3.length.to_s  
  puts "aaa3.class.to_s=" + aaa3.class.to_s  
  puts "aaa3[0].class=" + aaa3[0].class.to_s
  
  puts "<4>"
  puts
  
  numbers = []
  aaa.each {|x|
    
    if x.get_number % 2 == 0
      numbers << x.get_number
    end 
      
    
  }
  
  puts "numbers.length=" + numbers.length.to_s
  puts "numbers[0].class.to_s=" + numbers[0].class.to_s
  
  puts "<5>"
  puts
  
  bbb = aaa.map{|x|
    if x.get_number > 300
      
      x.get_number
      
    end
  }
  
  puts "bbb.length=" + bbb.length.to_s
  
  
end#def job

job()
