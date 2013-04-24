# => http://stackoverflow.com/questions/1698225/where-to-put-common-code-found-in-multiple-models ## "answered Nov 8 '09 at 23:29" 
require_dependency 'basic'
include Basic

class TextsController < ApplicationController
  
  # include Basic
  
  # GET /texts
  # GET /texts.json
  def index
    
    since = params[:since]
    
        if since == nil

      logout("since == nil")
      @texts = Text.all
      
    else
      
        if since.numeric?
      
          @texts = 
              Text.find(
                    :all,
                    :conditions => [
                              "updated_at_mill > ?", since.to_i])
                              # "created_at_mill > ?", since.to_i])
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
          
          @texts =
              Text.all
          
        end

      # @texts = Text.find(:all, :conditions => ["created_at > ?", Time.at(since.to_i / 1000).utc])
      
    end    

    
    
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
  
end#class TextsController < ApplicationController

#REF=> http://stackoverflow.com/questions/5661466/test-if-string-is-a-number-in-ruby-on-rails
class String
  def numeric?
    return true if self =~ /^\d+$/
    true if Float(self) rescue false
  end
end  
