require 'json'

def do_json
    
    #a = [1,2,3,4,5]
    a = ["aaa","bbb","ccc"]
    
    p JSON.generate(a)
    puts JSON.generate(a)
    
end#def do_json

def do_job

    do_json

end#def do_job

do_job
