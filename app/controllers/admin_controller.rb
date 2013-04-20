class AdminController < ApplicationController
  def main
    
    target = "doc/mylog.txt"
    
    # @content = "111111111"
    @content = ""
    
    if File.exists?(target)
      
      # File.open(target, "r") do |f|
#         
        # @contentArray = f.each_line {|line|}
        # # @content = f.read()
        # # f.write(content)
        # # f.write("\n")
      # end

      # => http://www.ruby-forum.com/topic/66733
      @contentArray = File.readlines(target)

    else
      
      @content = "abcdefg"
      
    end

    
  end

  def sub1
  end

  def sub2
  end
end
