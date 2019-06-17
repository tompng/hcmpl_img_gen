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
    @depth = height.times.map{width.times.map{999}}
  end
  def clear
    color.each{|l|l.map!{1}}
    depth.each{|l|l.map!{999}}
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
    ([(width*(1+x0)*0.5).ceil,0].max..[(width*(1+x1)*0.5).floor,width-1].min).each{|ix|
      x=ix*2.0/width-1
      ax=a[0]-x
      bx=b[0]-x
      cx=c[0]-x
      y0,y1=[
        ax*bx<=0?(ax*b[1]-bx*a[1]).fdiv(ax-bx):nil,
        bx*cx<=0?(bx*c[1]-cx*b[1]).fdiv(bx-cx):nil,
        cx*ax<=0?(cx*a[1]-ax*c[1]).fdiv(cx-ax):nil
      ].compact.minmax
      vax = a[0]*a[2]
      vay = a[1]*a[2]
      vaz = a[2]
      vabx = b[0]*b[2]-vax
      vaby = b[1]*b[2]-vay
      vabz = b[2]-a[2]
      vacx = c[0]*c[2]-vax
      vacy = c[1]*c[2]-vay
      vacz = c[2]-a[2]
      ([((y0*width+height)*0.5).ceil,0].max..[((y1*width+height)*0.5).floor,height-1].min).each{|iy|
        y=(iy*2.0-height)/width
        # va+vab*s+vac*t = xy1*u
        # (vab x xy1)*s+(vac x xy1)*t = -va x xy1
        sx = vaby-vabz*y
        sy = vabz*x-vabx
        tx = vacy-vacz*y
        ty = vacz*x-vacx
        d = sx*ty-sy*tx
        vx = vaz*y-vay
        vy = vax-vaz*x
        s = (vx*ty-vy*tx).fdiv d
        t = (vy*sx-vx*sy).fdiv d
        z = vaz+vabz*s+vacz*t
        if z<depth[iy][ix]
          depth[iy][ix]=z
          color[iy][ix]=a[3]+(b[3]-a[3])*s+(c[3]-a[3])*t
        end
      }
    }
  end
  def show
    puts "\e[1;1H"+color.each_slice(2).map{|a,b|a.zip(b).map{|a,b|TABLE[a*15.9][b*15.9]}*''+'|'}*$/
  end
end

c=Canvas.new(W,H)
t=Time.now
c.triangle(
  [-1, -1, 2, 0.8],
  [-0.8, 0.5, 3, 0.3],
  [1, 0.2, 4, 0.6]
)
t=Time.now-t
c.show
puts t
