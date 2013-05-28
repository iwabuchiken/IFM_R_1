module Basic

  def get_time_label_now()
  
    return Time.now.strftime("%Y/%m/%d %H:%M:%S")
    # return Time.now.strftime("%Y%m%d_%H%M%S")
    
  end#def get_time_label_now()
  
  def get_time_label_now_2()
    
    return Time.now.strftime("%Y%m%d_%H%M%S")
    # return Time.now.strftime("%Y%m%d_%H%M%S")
    
  end#def get_time_label_now()
  
  def logout(text, file_name, line_number)
  
        # max_line_num = 300
      max_line_num = 20000
      #-----------------------
      # => File exists?
      #-----------------------
  
      dname = "doc/mylog"
      # fname = "mylog/log.log"
      # f = File.new(dname)
      
      if !File.exists?(dname)
          # => REF mkdir http://ruby-doc.org/stdlib-1.9.3/libdoc/fileutils/rdoc/FileUtils.html
          FileUtils.mkdir dname
      end
  
      # => REF SEPARATOR: http://doc.ruby-lang.org/ja/1.9.3/class/File.html#C_-P-A-T-H_-S-E-P-A-R-A-T-O-R
      fname = [dname, "log.log"].join(File::SEPARATOR)
      
      if !File.exists?(fname)
          # => REF touch: http://stackoverflow.com/questions/8100574/creating-an-empty-file-in-ruby-touch-equivalent answered Nov 11 '11 at 22:14
          FileUtils.touch(fname)
      end    
      
      
      # f = open(fname, "r")
      f = open(fname, "a")
      # f = open("mylog/log.log", "a")
      # f = open("log.log", "a")
      
      #-----------------------
      # => File full?
      #-----------------------    
      # lines = f.readlines()
      
      # if lines.length > @max_line_num
      
      # if File.size?(fname) > @max_line_num
      # if File.size(fname) && File.size(fname) > @max_line_num
      if File.size(fname) && File.size(fname) > max_line_num
          # => REF rename http://stackoverflow.com/questions/5530479/how-to-rename-a-file-in-ruby answered Apr 3 '11 at 15:29
          # File.rename(f, 
                  # dname + File::SEPARATOR +
                  # File.basename(f, File.extname(f)) + "_" +
                  # get_time_label_now_2 + File.extname(f))
          new_fname = [dname,
                      File.basename(f, File.extname(f)) + "_" +
                        get_time_label_now_2 + File.extname(f)].join(File::SEPARATOR)
          
          # => REF cp: http://miyohide.hatenablog.com/entry/20050916/1126881010
          # => REF cp: http://doc.ruby-lang.org/ja/search/module:FileUtils/query:FileUtils.%23cp/
          FileUtils.cp(fname, new_fname)
                      
                    # File.basename(f, File.extname(f)) + "_" +
                      # get_time_label_now_2 + File.extname(f))
          
          f.close
          
          # f = open(fname, "a")
          f = open(fname, "w")
      
      end
      
        
      
      f.write("[begin]------------------------=\n")
      
      # f.write("[#{get_time_label_now()}]" + line + ": " + text)
      f.write("[#{get_time_label_now()}] [#{file_name}: #{line_number}]\n")
      # f.write("[#{get_time_label_now()}] [#{file}: #{line}]\n")
      # f.write("\n#{text}")
      # f.write("\n")
      # f.write("\n\nyes")
      f.write(text)
      
      f.write("\n")
      # f.write("<br/>")
      
      if File.size(fname)
          f.write("File size=" + File.size(fname).to_s)
          # f.write("@max_line_num=" + @max_line_num.to_s)
      else 
        
          f.write("File.size(fname) => nil")
        
      end
      
      f.write("------------------------=[end]\n\n")
      
      f.close

    
    # target = "doc/mylog.txt"
#     
    # if not File.exists?(target)
#       
      # FileUtils.touch(target)
#       
    # end
#     
    # # content = "abcdefg"
    # # File.open(target, "w+") do |f|
    # File.open(target, "a") do |f|
      # f.write("[" + file_name + " "  + "/" + line_number.to_s + " " + Time.now.to_s + "]" + "\n")
      # # f.write(content)
      # f.write(label)
      # f.write("\n")
    # end

  end#def logout(label)

  # def logout(label)
#   
#     
    # target = "doc/mylog.txt"
#     
    # if not File.exists?(target)
#       
      # FileUtils.touch(target)
#       
    # end
#     
    # # content = "abcdefg"
    # # File.open(target, "w+") do |f|
    # File.open(target, "a") do |f|
      # f.write("[" + __FILE__ + " "  + "/" + __LINE__.to_s + " " + Time.now.to_s + "]" + "\n")
      # # f.write(content)
      # f.write(label)
      # f.write("\n")
    # end
# 
  # end#def logout(label)
# 
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