$KCODE='u'

require_dependency 'basic'
include Basic

class ImagesController < ApplicationController
  
  # REF global http://doc.ruby-lang.org/ja/1.9.3/doc/spec=2fvariables.html#global
  # $remote_url = "http://benfranklin.chips.jp/images"
  $remote_url = "http://benfranklin.chips.jp/image_thumbnails"
  # $log_file_path = "doc/mylog.txt"
  $log_file_path = "doc/mylog/log.log"
  
  # GET /images
  # GET /images.json
  def index

        per_page = 10
        
        # Total number of images
        @total_num_of_images = Image.all.length
        
        @server_info = request.host_with_port
        
        # Params => Search
        @images = _index_1_search_text(per_page)
  
      @contentArray = _index_get_log()
  
  
      respond_to do |format|
          format.html # index.html.erb
          format.json { render json: @images }
      end
  end

    def _index_1_search_text(per_page)
        if params['search'] and params['search']['text']
        
            search_word = params['search']['text']

            # Logic option
            # # if params ['search']['option_logic']
            # if params ['search']['option_logic'] == "search_logic_all"
            if params['search']['option_logic']
                
                # if params ['search']['option_logic'] == "search_logic_all"
                if params['search']['option_logic'] == "search_logic_all"
                    
                    return Image.paginate(
                          :page => params[:page],
                          :order => 'created_at asc',
                          :per_page => per_page,
                          :conditions => ['memos LIKE ?', "%#{search_word}%"])

                elsif params['search']['option_logic'] == "search_logic_and"
                    
                    return _index_1_search_text_1_and(per_page)
                          
                elsif params['search']['option_logic'] == "search_logic_or"
                    
                    return _index_1_search_text_2_or(per_page)
                          
                else
                    
                    return Image.paginate(
                          :page => params[:page],
                          :order => 'created_at asc',
                          :per_page => per_page)                    
                          
                end#if params['search']['option_logic'] == "search_logic_all"
                
            end#if params ['search']['option_logic']
            
            return Image.paginate(
                          :page => params[:page],
                          :order => 'created_at asc',
                          :per_page => per_page,
                          :conditions => ['memos LIKE ?', "%#{search_word}%"])

        
        else
            
            return Image.paginate(
                                  :page => params[:page],
                                  :order => 'created_at asc',
                                  :per_page => per_page)
                                  
        end#if params['search'] and params['search']['text']
        
    end#def _index_1_search_text
    
    def _index_1_search_text_1_and(per_page)
        
        search_words = params['search']['text']
        
        a = search_words.split(" ")
        
        q = []
        
        condition = []
        
        a.length.times do
        
            q.push("memos like ?")
            
        end#a.length.times do
        
        q = q.join(" and ")
        
        condition.push(q)

        a.length.times do |i|
            
            token = "%#{a[i]}%"
            
            condition.push(token)
            
        end
        
        #logout("condition=" + condition.to_s, __FILE__, __LINE__)
        
        return Image.paginate(
                  :page => params[:page],
                  :order => 'created_at asc',
                  :per_page => per_page,
                  :conditions => condition)
                  
    end#_index_1_search_text_1_and(per_page)
    
    def _index_1_search_text_2_or(per_page)
        
        search_words = params['search']['text']
        
        a = search_words.split(" ")
        
        q = []
        
        condition = []
        
        a.length.times do
        
            q.push("memos like ?")
            
        end#a.length.times do
        
        q = q.join(" or ")
        
        condition.push(q)

        a.length.times do |i|
            
            token = "%#{a[i]}%"
            
            condition.push(token)
            
        end
        
        #logout("condition=" + condition.to_s, __FILE__, __LINE__)
        
        return Image.paginate(
                  :page => params[:page],
                  :order => 'created_at asc',
                  :per_page => per_page,
                  :conditions => condition)
                  
    end#_index_1_search_text_1_and(per_page)
    
  def _index_get_log()
      
      if File.exists?($log_file_path)
      
      # File.open(target, "r") do |f|
#         
        # @contentArray = f.each_line {|line|}
        # # @content = f.read()
        # # f.write(content)
        # # f.write("\n")
      # end

        # => http://www.ruby-forum.com/topic/66733
          # @contentArray = File.readlines(target)
          
          lines = File.readlines($log_file_path)
          
          if lines.length > 0
            
              return lines
              # return File.readlines(target)
            
          else
            
              return ["no data written"]
            
          end
  
      else
        
          return ["no data"]
          # @content = "abcdefg"
        
      end
    
  end#def _index_get_log()

  # GET /images/1
  # GET /images/1.json
  def show
    @image = Image.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @image }
    end
  end

  # GET /images/new
  # GET /images/new.json
  def new
      
      res = _new__1_data_from_device()
      
      logout("res=" + res.to_s, __FILE__, __LINE__)
      
      if res == true
          
          redirect_to :controller => 'images', :action => 'index'
          
          return
        
      end
      
      # #---------------------------------------------
      # # Post from  the device
      # #---------------------------------------------
      # dev_file_name = false
      # dev_table_name = false
#       
      # # File name ----------------------------------
      # if params['file_name']
#         
          # msg = "params['file_name'] => " + params['file_name']
#           
          # dev_file_name = true
#         
      # else
#       
          # msg = "params['file_name'] => null"
# 
      # end
# 
# #           
      # logout(msg, __FILE__, __LINE__)
      # # logout(msg)
#   
      # # Table name -------------------------------------
      # if params['table_name']
#         
          # msg = "params['table_name'] => " + params['table_name']
#           
          # dev_table_name = true
#         
      # else
#       
          # msg = "params['table_name'] => null"
# 
      # end      
#       
      # logout(msg, __FILE__, __LINE__)
      # # logout(msg)
#       
      # # Save image
      # if dev_file_name
#           
          # msg = "dev_file_name => true"
          # logout(msg, __FILE__, __LINE__)
# 
#           
          # image = Image.new()
#           
          # image.file_name = params['file_name']
          # image.table_name = params['table_name']
#           
#           
#           
          # respond_to do |format|
              # if image.save
#                   
                  # msg = "image.save => Done"
                  # logout(msg, __FILE__, __LINE__)
#                 
                  # format.json { render json: image}
                  # # format.json { render json: image, status: :created, location: image }
#                   
              # else
# 
                # msg = "image.save => Failed"
                # logout(msg, __FILE__, __LINE__)
#                 
                # format.json { render json: image}
                # # format.json { render json: image.errors, status: :unprocessable_entity }
#                 
              # end
#               
              # return
          # end#respond_to do |format|
#           
      # else#if dev_file_name
#         
      # end#if dev_file_name
      
      
            
      @image = Image.new
  
      respond_to do |format|
          format.html # new.html.erb
          format.json { render json: @image }
      end
  end


  # GET /images/1/edit
  def edit
    @image = Image.find(params[:id])
  end

  # POST /images
  # POST /images.json
  def create
    @image = Image.new(params[:image])

    respond_to do |format|
      if @image.save
        format.html { redirect_to @image, notice: 'Image was successfully created.' }
        format.json { render json: @image, status: :created, location: @image }
      else
        format.html { render action: "new" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /images/1
  # PUT /images/1.json
  def update
    @image = Image.find(params[:id])

    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.html { redirect_to @image, notice: 'Image was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.html { redirect_to images_url }
      format.json { head :no_content }
    end
  end
  
private
  #===================================
  # return true => Data posted from the device. Hence,
  #                 the method 'new' terminates
  #        false => Data _not_ posted from the device. Hence,
  #                 the method 'new' continues
  #
  #===================================
  def _new__1_data_from_device
      
      logout("Start: _new__1_data_from_device", __FILE__, __LINE__)
      
      #---------------------------------------------
      # Post from  the device
      #---------------------------------------------
      dev_file_name = false
      dev_table_name = false
      
      # File name ----------------------------------
      if params['file_name']
        
          msg = "params['file_name'] => " + params['file_name']
          
          dev_file_name = true
        
      else
      
          msg = "params['file_name'] => null"

      end

#           
      logout(msg, __FILE__, __LINE__)
      # logout(msg)
  
      # Table name -------------------------------------
      if params['table_name']
        
          msg = "params['table_name'] => " + params['table_name']
          
          dev_table_name = true
        
      else
      
          msg = "params['table_name'] => null"

      end      
      
      logout(msg, __FILE__, __LINE__)
      # logout(msg)
      
      # Save image
      if dev_file_name
          
          msg = "dev_file_name => true"
          logout(msg, __FILE__, __LINE__)

          
          image = Image.new()
          
          image.file_name = params['file_name']
          image.table_name = params['table_name']
          image.memos = params['memos']
          
          
          
          respond_to do |format|
              if image.save
                  
                  msg = "image.save => Done"
                  logout(msg, __FILE__, __LINE__)
                
                  format.json { render json: image}
                  # format.json { render json: image, status: :created, location: image }
                  
              else

                msg = "image.save => Failed"
                logout(msg, __FILE__, __LINE__)
                
                format.json { render json: image}
                # format.json { render json: image.errors, status: :unprocessable_entity }
                
              end
              
              return true
          end#respond_to do |format|
          
      else#if dev_file_name
        
          return false
        
      end#if dev_file_name
  end#def _new__1_data_from_device
end
