module Basic
  
  def logout(label)
  
    
    target = "doc/mylog.txt"
    
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

  def is_numeric?(label)
    logout("label=" + label)
    
    return true if label =~ /^\d+$/
    
    true if Float(label) rescue false
  end#def is_numeric?(label)
    
  class String
    def numeric?
      return true if self =~ /^\d+$/
      true if Float(self) rescue false
    end
  end#class String

end