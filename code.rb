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
  def camera(x,y,z,vxy,vz)
    @camx=x
    @camy=y
    @camz=z
    @rotxy = Math::E**(Math::PI/2-vxy).i
    @rotz = Math::E**(Math::PI/2-vz).i
  end

  def render(t)
    width.times{|ix|height.times{|iy|
      x=(2.0*ix-width)/height
      y=(2.0*iy-height)/height
      color[iy][ix]=(t+x*x+y*y+2*Math.sin(5*Math.atan2(y,x)+t))/3%1
    }}
  end
  def triangle(a,b,c)
    [a,b,c].each{|p|
      x,y=((p[0]-@camx+(p[1]-@camy).i)*@rotxy).rect
      y,z=((y+(p[2]-@camz).i)*@rotz).rect
      return if z<=0
      p[0]=x/z
      p[1]=y/z
      p[2]=z
    }
    x0,x1=[a[0],b[0],c[0]].minmax
    ([width*(1+x0)*0.5,0].max.ceil..[width*(1+x1)*0.5,width-1].min).each{|ix|
      x=ix*2.0/width-1
      ax=a[0]-x
      bx=b[0]-x
      cx=c[0]-x
      y0,y1=[
        ax*bx<=0?(ax*b[1]-bx*a[1]).fdiv(ax-bx):nil,
        bx*cx<=0?(bx*c[1]-cx*b[1]).fdiv(bx-cx):nil,
        cx*ax<=0?(cx*a[1]-ax*c[1]).fdiv(cx-ax):nil
      ].compact.reject(&:nan?).minmax rescue (require'pry';binding.pry)
      next if y0.nil?
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
cnt=0
loop{
  cnt+=1
  t=cnt*0.01
  c.camera(-2*Math.cos(t),-2*Math.sin(t),1.5,t,-0.5)
  conv=->x,y{
    z=0.2*(Math.sin(4.1*x-3.2*y)+Math.cos(2.3*x-3.7*y))
    [1.2*x,1.2*y,z,Math.sin(4*z)*0.5+0.5].tap{|p|p[3]=0}
  }
  c.clear
  num=20
  num.times{|i|
    num.times{|j|
      c.triangle(conv[i*2.0/num-1,j*2.0/num-1],conv[i*2.0/num-1,(j+1)*2.0/num-1],conv[(i+1)*2.0/num-1,j*2.0/num-1])
      c.triangle(conv[(i+1)*2.0/num-1,(j+1)*2.0/num-1],conv[i*2.0/num-1,(j+1)*2.0/num-1],conv[(i+1)*2.0/num-1,j*2.0/num-1])
    }
  }

  srand 0
  gdx=-Math.sin(t)*0.04
  gdy=Math.cos(t)*0.04
  64.times{|i|
    x=rand(-1..1.0)
    y=rand(-1..1.0)
    c.triangle(
      conv[x-gdx,y-gdy],
      conv[x,y].tap{|p|p[0]+=0.2*Math.sin(8*t);p[1]+=0.2*Math.cos(7*t);p[2]+=0.4;p[3]=1},
      conv[x+gdx,y+gdy]
    )
  }

  c.show
  sleep 0.05
}
