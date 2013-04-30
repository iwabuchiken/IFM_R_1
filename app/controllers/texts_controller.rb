# => http://stackoverflow.com/questions/1698225/where-to-put-common-code-found-in-multiple-models ## "answered Nov 8 '09 at 23:29" 
require_dependency 'basic'
include Basic

class TextsController < ApplicationController
  
  # include Basic
  
  # GET /texts
  # GET /texts.json
  def index
    
    #debug
    # default_sort_key = :title
    default_sort_key = :id
    
    since = params[:since]
    
    if since == nil

      logout("since == nil")
      @texts = Text.all
      
      # => REF sort_by! http://ref.xaio.jp/ruby/classes/array/sort
      # => REF {...} http://stackoverflow.com/questions/5739158/rails-ruby-how-to-sort-an-array answered Apr 21 '11 at 3:36
      @texts.sort_by!{|word| word[default_sort_key]}
      # @texts.sort_by!{|word| word[:created_at]}
      
    else
      
        if is_numeric?(since)
        # if since.numeric?
      
          @texts = 
              Text.find(
                    :all,
                    :conditions => [
                              # "updated_at_mill > ?", since.to_i])
                              "created_at_mill > ?", since.to_i],
                    # => REF http://rubyrails.blog27.fc2.com/blog-entry-13.html
                    :order => default_sort_key.to_s
                    # :order => "created_at"
                    )
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
          logout("since -> " + since)
          
          # logout("since -> " + since + "(" + Time.at(since.to_i / 1000) + ")")
          
          @texts =
              Text.all
          @texts.sort_by!{|word| word[default_sort_key]}
          # @texts.sort_by!{|word| word[:created_at]}
          
        end#if since.numeric?

      # @texts = Text.find(:all, :conditions => ["created_at > ?", Time.at(since.to_i / 1000).utc])
      
    end#if since == nil    

    
    
    # @texts = Text.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @texts }
    end
  end

  # GET /texts/1
  # GET /texts/1.json
  def show
    @text = Text.find(params[:id])

    #B14
    if @text != nil
      
      @text.text = _show__1_colorize_words(@text)
      
    end#if @text != nil
    

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @text }
    end
  end

  # GET /texts/new
  # GET /texts/new.json
  def new
    @text = Text.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @text }
    end
  end

  # GET /texts/1/edit
  def edit
    @text = Text.find(params[:id])
  end

  # POST /texts
  # POST /texts.json
  def create
    @text = Text.new(params[:text])
    
    # #debug  => http://stackoverflow.com/questions/3479551/how-to-get-an-array-with-column-names-of-a-table
    # Text.columns.map {|c|
      # c.name
      # logout("c.name=" + c.name)
    # }
    
    
    @text.created_at_mill = (Time.now.to_f * 1000.0).to_i
    
        #D-9
    if @text.title == ""
      
      if @text.text.length > 30
        
        @text.title = @text.text[0..30]
        
      else
        
        @text.title = @text.text
        
      end
      
    end#if @text.title == ""

    
    respond_to do |format|
      if @text.save
        format.html { redirect_to @text, notice: 'Text was successfully created.' }
        format.json { render json: @text, status: :created, location: @text }
      else
        format.html { render action: "new" }
        format.json { render json: @text.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /texts/1
  # PUT /texts/1.json
  def update
    @text = Text.find(params[:id])

    respond_to do |format|
      if @text.update_attributes(params[:text])
        format.html { redirect_to @text, notice: 'Text was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @text.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /texts/1
  # DELETE /texts/1.json
  def destroy
    @text = Text.find(params[:id])
    @text.destroy

    respond_to do |format|
      format.html { redirect_to texts_url }
      format.json { head :no_content }
    end
  end

  # private
  def _show__1_colorize_words(text)
    
    text_id = text.id
    
    # => REF http://d.hatena.ne.jp/nakakoh/20080510/1210390013
    words = Word.find_all_by_text_id(text_id)
    # words = Word.find_by_text_id(text_id)
    
    if words != nil
    
      msg = "text.id=" + text_id.to_s + "/" + "Num of words=" + words.length.to_s
      # msg = "text.id=" + text_id.to_s + "/" + "Num of words=" + words.count
      
    else
      
      msg = "text.id=" + text_id.to_s + "/" + "words => nil"
      
    end
    
    logout(msg)
    
    ##########################
    #
    #
    #
    ##########################
    new_text = ""
    tag1 = "<span style='color: blue;'>"
    tag2 = "</span>"
    
    for i in 0..(words.length - 1)
#       
      word = words[i]
#       

      text.text = _add_span(text.text, word.w1, tag1, tag2)
      # reg = Regexp.compile(word.w1)
# #       
# # => REF http://www.rubylife.jp/ini/string_class/index7.html
      # if reg =~ text.text
# #       # Start tag
        # text.text.insert((reg =~ text.text), tag1)
#         
        # #debug
        # logout("text=" + text.text)
#         
        # # End tag
        # text.text.insert((reg =~ text.text) + word.w1.size, tag2)
        # # text.text.insert((reg =~ text.text) + reg.to_s.size, tag2)
#         
        # #debug
        # logout("reg.to_s=" + reg.to_s)
#         
        # # text.text.insert((reg =~ text.text) + tag1.size + reg.to_s.size, tag2)
#         
        # #debug
        # logout("text=" + text.text)
# 
        # # text.text.insert((reg =~ text.text) + tag1.size + word.size, tag2)
# #    
        # logout("match: " + word.w1)
      # else
# #         
      # end#if reg =~ text.text
#       
#       
#       
    end#for i in 0..(words.length - 1)
    
    # text.text.insert(5, tag1)
    # text.text.insert(5 + tag1.size + 5, tag2)
#     
    return text.text
    
  end#def _show__1_colorize_words(@text)
  
  def _add_span(text, keyword, start_tag, end_tag)

    # => REF /#{}/ http://stackoverflow.com/questions/2648054/ruby-recursive-regex answered Apr 15 '10 at 18:48
    r       = /#{keyword}/
    marker  = 0
    t1      = start_tag
    t2      = end_tag
    counter = 0
  
    # => REF =~ http://www.rubylife.jp/regexp/ini/index4.html
    while r =~ text[marker..(text.size - 1)] do
    # while r =~ text[marker..(text.size - 1)] && counter < maxnum do
      #debug
      logout("r=" + r.source)
      
      point = (r =~ text[marker..(text.size - 1)])
      
      text.insert(marker + point, t1)
      text.insert(marker + point + t1.size + r.source.size, t2)
  
      marker += point + t1.size + r.source.size + t2.size
      
      counter += 1
  
      
    end#while r =~ text[marker..(text.size - 1)] && counter < maxnum do
    
    return text
    
  end#def _add_span(text, keyword, start_tag, end_tag)

  
end#class TextsController < ApplicationController

#REF=> http://stackoverflow.com/questions/5661466/test-if-string-is-a-number-in-ruby-on-rails
# class String
  # def numeric?
    # return true if self =~ /^\d+$/
    # true if Float(self) rescue false
  # end
# end  
