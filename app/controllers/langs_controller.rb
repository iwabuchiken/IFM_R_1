class LangsController < ApplicationController
  # GET /langs
  # GET /langs.json
  def index
    
    default_sort_key = :id
    
    since = params[:since]
    
    if since == nil

      logout("since == nil")
      
      @langs = Lang.all
      @langs.sort_by!{|lang| lang[default_sort_key]}
      # @langs.sort_by!{|lang| lang[:created_at]}

    else
      
        if is_numeric?(since)

          @langs = 
              Lang.find(
                    :all,
                    :conditions => [
                              # "updated_at_mill > ?", since.to_i])
                              "created_at_mill > ?", since.to_i],
                    :order => default_sort_key.to_s
                    )
          logout((Time.at(since.to_i / 1000) + (9*60*60 + 1)).to_s\
                  + "/utc="\
                  + (Time.at(since.to_i / 1000).utc + (9*60*60 + 1)).to_s\
                  + "/since=" + since.to_i.to_s
                  )

        else
          logout("since -> " + since)
          
          # logout("since -> " + since + "(" + Time.at(since.to_i / 1000) + ")")
          
          @langs =
              Text.all
          @langs.sort_by!{|lang| lang[default_sort_key]}
          
        end#if since.numeric?

    end#if since == nil
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @langs }
    end
  end

  # GET /langs/1
  # GET /langs/1.json
  def show
    @lang = Lang.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lang }
    end
  end

  # GET /langs/new
  # GET /langs/new.json
  def new
    @lang = Lang.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lang }
    end
  end

  # GET /langs/1/edit
  def edit
    @lang = Lang.find(params[:id])
  end

  # POST /langs
  # POST /langs.json
  def create
    @lang = Lang.new(params[:lang])

    respond_to do |format|
      if @lang.save
        format.html { redirect_to @lang, notice: 'Lang was successfully created.' }
        format.json { render json: @lang, status: :created, location: @lang }
      else
        format.html { render action: "new" }
        format.json { render json: @lang.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /langs/1
  # PUT /langs/1.json
  def update
    @lang = Lang.find(params[:id])

    respond_to do |format|
      if @lang.update_attributes(params[:lang])
        format.html { redirect_to @lang, notice: 'Lang was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lang.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /langs/1
  # DELETE /langs/1.json
  def destroy
    @lang = Lang.find(params[:id])
    @lang.destroy

    respond_to do |format|
      format.html { redirect_to langs_url }
      format.json { head :no_content }
    end
  end
end
