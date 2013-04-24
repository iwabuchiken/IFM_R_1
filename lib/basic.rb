module Basic
  
  def logout(label)
  
    
    target = "doc/mylog.txt"
    
    if not File.exists?(target)
      
      FileUtils.touch(target)
      
    end
    
    # content = "abcdefg"
    # File.open(target, "w+") do |f|
    File.open(target, "a") do |f|
      f.write("[" + __FILE__ + " " + Time.now.to_s + "/" + __LINE__.to_s + "]" + "\n")
      # f.write(content)
      f.write(label)
      f.write("\n")
    end

  end

  
end