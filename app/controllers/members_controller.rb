require 'utils'

class MembersController < ApplicationController
  # GET /members
  # GET /members.json
  def index
    
    
    @members = Member.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @members }
    end
  end

  # GET /members/1
  # GET /members/1.json
  def show
    @member = Member.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @member }
    end
  end

  # GET /members/new
  # GET /members/new.json
  def new
    @member = Member.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @member }
    end
  end

  # GET /members/1/edit
  def edit
    @member = Member.find(params[:id])
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(params[:member])

    respond_to do |format|
      if @member.save
        format.html { redirect_to @member, notice: 'Member was successfully created.' }
        format.json { render json: @member, status: :created, location: @member }
      else
        format.html { render action: "new" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /members/1
  # PUT /members/1.json
  def update
    @member = Member.find(params[:id])

    respond_to do |format|
      if @member.update_attributes(params[:member])
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member = Member.find(params[:id])
    @member.destroy

    respond_to do |format|
      format.html { redirect_to members_url }
      format.json { head :no_content }
    end
  end
  
  def login
      
      if params['member'] && params['member']['name']
          validate = validate_login(params['member']['name'], params['member']['passwd'])
          
          if validate == true
            
              flash['notice'] = "Member set: #{params['member']['name']}"
              
              # => REF redirect_to: http://maskana-soft.com/rails/pro/body/24
              redirect_to :controller => "texts", :action => "index"
              
              return
            
          else
              
              flash['notice'] =
                      "Validation failed: Your input =>\
                        Name=#{params['member']['name']}\
                         Password=#{params['member']['passwd']}"
              
          end
          
      else
          flash['notice'] = "Not yet logged in"
      end
      
      @member = Member.new
  
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @member }
      end
  end#def login

private
  def validate_login(user_name, passwd)
      
      if user_name == "aaa" && passwd == "aaa"  
          return true
      else
          return false
      end
      
      # return false
      # return true
      
  end

end
