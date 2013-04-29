require_dependency 'basic'
include Basic

class WordsController < ApplicationController
  # GET /words
  # GET /words.json
  def index
    # @words = Word.all

    since = params[:since]
    
    if since == nil

      logout("since == nil")
      @words = Word.all
      
    else
      
        if since.numeric?
      
          @words = 
              Word.find(
                    :all,
                    :conditions => [
                              # "updated_at_mill > ?", since.to_i])
                              "created_at_mill > ?", since.to_i])
                              # "created_at_mill > ?", since.to_i + (9*60*60)])
                              # "created_at > ?",
                              # Time.at(since.to_i / 1000).utc])
                              # Time.at(since.to_i / 1000).utc + (9*60*60)])

                              # REF=> http://www.treeder.com/2011/06/converting-ruby-time-to-milliseconds.html
                              # Time.at(since.to_i / 1000).utc + (9*60*60 + 1)])

                              
                    # :conditions => ["created_at > ?", Time.at(since.to_i / 1000)])
          
          # logout(Time.at(since.to_i / 1000) + "/utc=" + Time.at(since.to_i / 1000).utc)
          # logout(Time.at(since.to_i / 1000).to_s + "/utc=" + Time.at(since.to_i / 1000).utc.to_s)
          logout((Time.at(since.to_i / 1000) + (9*60*60 + 1)).to_s\
                  + "/utc="\
                  + (Time.at(since.to_i / 1000).utc + (9*60*60 + 1)).to_s\
                  + "/since=" + since.to_i.to_s
                  )
          
          # logout((Time.at(since.to_i / 1000) + (9*60*60)).to_s\
                  # + "/utc="\
                  # + (Time.at(since.to_i / 1000).utc + (9*60*60)).to_s)
          
          # @texts.paginate
          
        else
          logout("since -> " + since + "(" + Time.at(since.to_i / 1000) + ")")
          
          @words =
              Word.all
          
        end#if since.numeric?

      # @texts = Text.find(:all, :conditions => ["created_at > ?", Time.at(since.to_i / 1000).utc])
      
    end#if since == nil    


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @words }
    end
  end

  # GET /words/1
  # GET /words/1.json
  def show
    @word = Word.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @word }
    end
  end

  # GET /words/new
  # GET /words/new.json
  def new
    @word = Word.new

    
    if params[:text_id] && is_numeric?(params[:text_id])
    # if params[:text_id] && params[:text_id].numeric?
      
      @word.text_id = params[:text_id].to_i
      
    end

    #debug
    if params[:text_id] != nil
      
      logout("params[:text_id]=" + params[:text_id])
      logout(is_numeric?(params[:text_id]))
        
    else
      
      logout("params[:text_id] => nil")
      
    end
    
    

    # REF http://stackoverflow.com/questions/3757491/can-i-get-the-name-of-the-current-controller-in-the-view answered Sep 21 '10 at 5:27
    #debug
    @current_controller = params[:controller]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @word }
    end
  end

  # GET /words/1/edit
  def edit
    @word = Word.find(params[:id])
  end

  # POST /words
  # POST /words.json
  def create
    @word = Word.new(params[:word])

    @word.created_at_mill = (Time.now.to_f * 1000.0).to_i
    
    # Get text instance
    text_id = @word.text_id
    
    if text_id != 0
    
      text = Text.find(text_id.to_i)
      
      logout("text_id => " + text_id.to_s)
      
    else

      text = nil
      
      logout("text_id => nil")
      
    end
    
    respond_to do |format|
      if @word.save
        if text != nil
          
          text.words << @word
          
          logout("word added to the text: id=" + @word.id.to_s)
          
        else
          
          logout("text == nil")
          
        end

        format.html { redirect_to @word, notice: 'Word was successfully created.' }
        # format.html { redirect_to @word, notice: 'Word was successfully created.' }
        format.json { render json: @word, status: :created, location: @word }
      else
        format.html { render action: "new" }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /words/1
  # PUT /words/1.json
  def update
    @word = Word.find(params[:id])

    respond_to do |format|
      if @word.update_attributes(params[:word])
        format.html { redirect_to @word, notice: 'Word was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /words/1
  # DELETE /words/1.json
  def destroy
    @word = Word.find(params[:id])
    @word.destroy

    respond_to do |format|
      format.html { redirect_to words_url }
      format.json { head :no_content }
    end
  end
end

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
      # f.write("[" + __FILE__ + " " + Time.now.to_s + "/" + __LINE__.to_s + "]" + "\n")
      # # f.write(content)
      # f.write(label)
      # f.write("\n")
    # end
# 
# end
