# -*- coding: utf-8 -*-
# => REF coding http://www.kkaneko.com/rinkou/ruby/rubyintro.html
# => REF http://stackoverflow.com/questions/2440752/ruby-mixin-gives-unidentified-constant-error answered Mar 14 '10 at 1:30
require 'fileutils'

# puts "hello"
def logout(label)

  
  target = "testlog.txt"
  
  if not File.exists?(target)
    
    FileUtils.touch(target)
    
  end
  
  # content = "abcdefg"
  # File.open(target, "w+") do |f|
  File.open(target, "a") do |f|
    f.write("[" + __FILE__ + " "  + "/" + __LINE__.to_s + " " + Time.now.to_s + "]" + "\n")
    # f.write(content)
    f.write(label)
    f.write("\n")
  end

end#def logout(label)

def add_span(text, keyword, start_tag, end_tag)

  # => REF /#{}/ http://stackoverflow.com/questions/2648054/ruby-recursive-regex answered Apr 15 '10 at 18:48
  r       = /#{keyword}/
  marker  = 0
  t1      = start_tag
  t2      = end_tag
  counter = 0

  # => REF =~ http://www.rubylife.jp/regexp/ini/index4.html
  while r =~ text[marker..(text.size - 1)] do
  # while r =~ text[marker..(text.size - 1)] && counter < maxnum do

    point = (r =~ text[marker..(text.size - 1)])
    
    text.insert(marker + point, t1)
    text.insert(marker + point + t1.size + r.source.size, t2)

    marker += point + t1.size + r.source.size + t2.size
    
    counter += 1

    
  end#while r =~ text[marker..(text.size - 1)] && counter < maxnum do
  
  return text
  
end#def add_span(text, keyword, start_tag, end_tag)

def job

  a       = "闻》4月27日报道】题：中国军机展开前所未有的威吓飞行 据多名政府高官26日透露，就在中国8艘海监船23日侵入尖阁诸岛（即我钓鱼岛及其附属岛屿——本网注）周边日本领海的同时，中国的战斗机等军用飞机在尖阁诸岛周边飞行超过40架次。 军用飞机多数是战斗机，中国投入了新型苏-27和苏-30。这些战斗机趁航空自卫队战斗机飞行员疲惫的时候蜂拥而至。政府高官称这是“前所未有的威吓”。 政府方面认为中国军机的威吓飞行是为了配合海监船侵入领海。 中国军机从上空对海上保安厅的防范态势和海上自卫队护卫舰、P-3C巡逻机的部署进行侦察，估计向海监船进行了通报。 23日上午7时23分至8时25分左右，8艘海监船相继进入尖阁周边海域。其中一艘逼近鱼钓岛（即我钓鱼岛——本网注）西北约一公里处。当日下午7时半左右，8艘海监船离开了日本领海。 在海监船侵入领海之际，中国的战斗机等军用飞机也开始朝尖阁周边飞去。这些飞机交替着逼近尖阁周边上空，每次逼近时航空自卫队那霸基地的F-15等战斗机就紧急出动。飞来的中国军机总共在40架次以上。 "
  # a       = "In the above outline, expression is a Ruby expression 
              # The ruby code here marker is where the code to executed 
              # the expression evaluates to false."
           # xx <span>the</span> xx bbbb the xxxx the bb
           # 0123456789012345678901234567890123456789
  # a       = "xx the xx bbbb the xxxx the bb"
  kw      = "中国"
  # kw      = "the"
  r       = /#{kw}/
  marker  = 0
  t1      = "<span style='color: blue;'>"
  t2      = "</span>"
  counter = 0
  maxnum  = 3
  
  logout("====================================")
  logout("a=" + a)
  logout("Span added=" + add_span(a, kw, t1, t2))
  
  # puts "a=" + a
  # puts
  # 
  # puts add_span(a, kw, t1, t2)
  # puts
  
  # # 1
  # puts "<1>"
  # 
  # puts "r =~ a"
  # puts r =~ a
  # 
  # # 2
  # puts "<2>"
  # puts a
  # while r =~ a[marker..(a.size - 1)] && counter < maxnum do
  #   
    # puts "[Start while]========================"
  # 
    # puts "marker=" + marker.to_s
  # 
    # # point = (r =~ a)
    # point = (r =~ a[marker..(a.size - 1)])
    # puts "point=" + point.to_s
    # puts
  #   
    # puts "a=" + a
    # puts
  #   
    # puts "a[marker..(a.size - 1)]=" + a[marker..(a.size - 1)]
    # puts
  #   
  #   
  #   
    # a.insert(marker + point, t1)
    # a.insert(marker + point + t1.size + r.source.size, t2)
    # # a.insert(point, t1)
    # # a.insert(point + t1.size + r.source.size, t2)
  #   
    # puts "a=" + a
    # puts
  #   
    # marker += point + t1.size + r.source.size + t2.size
    # # marker = point + t1.size + r.source.size + t2.size
    # # marker = point + t1.size + r.source.size
    # # marker = point
  #   
    # counter += 1
  # 
    # puts "marker=" + marker.to_s
    # puts "point=" + point.to_s
    # puts
  #   
    # puts "[End while========================]"
  #   
  # end
  # 
  # puts a
  
  
end#def job

job()
