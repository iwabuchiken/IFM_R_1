require_dependency 'basic'
include Basic

class WordListsController < ApplicationController
  # GET /word_lists
  # GET /word_lists.json
  def index
    # @word_lists = WordList.all
    
    default_sort_key = :id
    
    since = params[:since]
    
    if since == nil

      logout("since == nil")
      @word_lists = WordList.all
      
      @word_lists.sort_by!{|word_list| word_list[default_sort_key]}
      
    else
      
        if is_numeric?(since)
        # if since.numeric?
      
          @word_lists = 
              WordList.find(
                      :all,
                      :conditions => [
                                # "updated_at_mill > ?", since.to_i])
                                "created_at_mill > ?", since.to_i],
                      :order => default_sort_key.to_s
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
          logout("since -> " + since + "(" + Time.at(since.to_i / 1000) + ")")
          
          @word_lists =
              WordList.all
          
          @word_lists.sort_by!{|word_list| word_list[default_sort_key]}
          
        end#if since.numeric?

      # @texts = Text.find(:all, :conditions => ["created_at > ?", Time.at(since.to_i / 1000).utc])
      
    end#if since == nil    


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @word_lists }
    end
  end

  # GET /word_lists/1
  # GET /word_lists/1.json
  def show
    @word_list = WordList.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @word_list }
    end
  end

  # GET /word_lists/new
  # GET /word_lists/new.json
  def new
    @word_list = WordList.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @word_list }
    end
  end

  # GET /word_lists/1/edit
  def edit
    @word_list = WordList.find(params[:id])
  end

  # POST /word_lists
  # POST /word_lists.json
  def create
    @word_list = WordList.new(params[:word_list])

    @word_list.created_at_mill = (Time.now.to_f * 1000.0).to_i

    respond_to do |format|
      if @word_list.save
        
        logout("created_at_mill=" + @word_list.created_at_mill.to_s)
        format.html { redirect_to @word_list, notice: 'Word list was successfully created.' }
        format.json { render json: @word_list, status: :created, location: @word_list }
      else
        format.html { render action: "new" }
        format.json { render json: @word_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /word_lists/1
  # PUT /word_lists/1.json
  def update
    @word_list = WordList.find(params[:id])

    respond_to do |format|
      if @word_list.update_attributes(params[:word_list])
        format.html { redirect_to @word_list, notice: 'Word list was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @word_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /word_lists/1
  # DELETE /word_lists/1.json
  def destroy
    @word_list = WordList.find(params[:id])
    @word_list.destroy

    respond_to do |format|
      format.html { redirect_to word_lists_url }
      format.json { head :no_content }
    end
  end
end
