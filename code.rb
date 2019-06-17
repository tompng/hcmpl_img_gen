W = 120
H = 80
TABLE = [
"MMMMMM###TTTTTTT",
"QQBMMNW##TTTTTV*",
"QQQBBEK@PTTTVVV*",
"QQQmdE88P9VVVV**",
"QQQmdGDU0YVV77**",
"pQQmAbk65YY?7***",
"ppgAww443vv?7***",
"pggyysxcJv??7***",
"pggyaLojrt<<+**\"",
"gggaauuj{11!//\"\"",
"gggaauui])|!/~~\"",
"ggaauui]((;::~~^",
"ggaauu](;;::-~~'",
"ggauu(;;;;---~``",
"gaau;;,,,,,...``",
"gau,,,,,,,,...  "]
class Canvas
  attr_reader :width, :height, :color, :depth
  def initialize(w, h)
    @width = w
    @height = h
    @color = height.times.map{width.times.map{1}}
    @depth = height.times.map{width.times.map{0}}
  end
  def clear
    color.each{|l|l.map!{1}}
    depth.each{|l|l.map!{0}}
  end
  def render(t)
    width.times{|ix|height.times{|iy|
      x=(2.0*ix-width)/height
      y=(2.0*iy-height)/height
      color[iy][ix]=(t+x*x+y*y+2*Math.sin(5*Math.atan2(y,x)+t))/3%1
    }}
  end
  def triangle(a,b,c)
    x0,x1=[a[0],b[0],c[0]].minmax
    x0=0 if x0<0&&x=0
    x1=width-1 if x1>width-1
    (x0.ceil..x1.floor).each{|x|
      ax=a[0]-x
      bx=b[0]-x
      cx=c[0]-x
      y0,y1=[
        ax*bx<=0?(ax*b[1]-bx*a[1])/(ax-bx):nil,
        bx*cx<=0?(bx*c[1]-cx*b[1])/(bx-cx):nil,
        cx*ax<=0?(cx*a[1]-ax*c[1])/(cx-ax):nil
      ].compact.minmax
      abx=b[0]-a[0]
      aby=b[1]-a[1]
      acx=c[0]-a[0]
      acy=c[1]-a[1]
      d=abx*acy-acx*aby
      y0=0 if y0<0
      y1=height-1 if y1>height-1
      (y0.ceil..y1.floor).each{|y|
        dx=x-a[0]
        dy=y-a[1]
        s=(acy*dx-acx*dy).fdiv d
        t=(abx*dy-aby*dx).fdiv d
        color[y][x]=s
      }
    }
  end
  def show
    puts "\e[1;1H"+color.each_slice(2).map{|a,b|a.zip(b).map{|a,b|TABLE[a*15.9][b*15.9]}*''+'|'}*$/
  end
end

c=Canvas.new(W,H)
c.triangle(
  [20,40],
  [40,50],
  [80,15]
)
c.show
