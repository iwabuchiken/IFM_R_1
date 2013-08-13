require 'json'

class AdminController < ApplicationController
    def main
        
        @json = Image.all
        
        @fnames = @json.collect do |n|
                    
                    n.file_name
                    
                    end
        
    end
    
    def sub1
    end
    
    def sub2
    end
end
