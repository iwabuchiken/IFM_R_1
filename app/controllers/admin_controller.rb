require_dependency 'basic'
include Basic

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

    #======================================
    #
    # Flash
    #
    #======================================
    if params[:item_refactor_table_word_lists]
      
      # flash[:notice] = "item_refactor_table_word_lists"
      flash[:notice] = "The user was successfully created"
      
    else
      
      flash[:notice] = "Welcome to admin/main"
      
    end
      
    
    # respond_to do |format|
        # format.html { redirect_to :controller => 'admin', :action => 'main', notice: 'Word was successfully created.' }
        # # format.html { redirect_to @word, notice: 'Word was successfully created.' }
        # format.json { render json: @word, status: :created, location: @word }
    # end

    
  end

  def sub1
    
    logout("Starting... sub1")
    
    word_lists = WordList.all()
    
    @counter = 0
    
    for i in (0..(word_lists.length - 1)) do
      
      word_list = word_lists[i]
      
      if not word_list.word_id > 0
        
        logout("word_list.word_id <= 0: id=" + word_list.word_id.to_s)
        
        word_list.destroy
        
        logout("word_list object destroyed => id=" + word_list.id.to_s)
        
        @counter += 1
        # REF http://doc.ruby-lang.org/ja/1.9.3/doc/spec=2fcontrol.html#next
        next
        
      end
      
      # Destroy?
      begin
        
        word = Word.find(word_list.word_id)
        
      rescue
        
        logout("No word object for id=" + word_list.word_id.to_s)
        
        word_list.destroy
        
        logout("word_list object destroyed => id=" + word_list.id.to_s)
        
        @counter += 1
        
        # next
      end
      
      # if word == nil
#         
        # word_list.destroy
#         
        # counter += 1
#         
      # end
      
    end#for i in (0..(word_lists.length - 1)) do
    
    logout("for operation => Done: (Destoryed:" + @counter.to_s + ")")
    
    flash[:notice] = "word_list object destroyed: " + @counter.to_s
    # if params[:item_refactor_table_word_lists]
#       
      # flash[:notice] = "Refactoring word_lists"
#       
    # else
#       
      # flash[:notice] = "Welcome"
#       
    # end
#
    # _sub1_redirection()
    
  end#def sub1

  # def _sub1_redirection
# 
    # respond_to do |format|
        # format.html { redirect_to :controller => 'admin', :action => 'sub1', notice: 'redirected' }
        # # format.html { redirect_to @word, notice: 'Word was successfully created.' }
        # # format.json { render json: @word, status: :created, location: @word }
    # end
#     
  # end
  
  def sub2
  end
end
