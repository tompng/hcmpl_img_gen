# rubocop:disable all
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
FONT={
  H:[[[0,0],[2,0],[0,14]],[[2,14],[2,0],[0,14]],[[8,0],[10,0],[8,14]],[[10,14],[10,0],[8,14]],[[2,8],[2,6],[8,8]],[[8,6],[2,6],[8,8]]],
  A:[[[0,14],[4,0],[2,14]],[[6,0],[4,0],[2,14]],[[2,7],[2,9],[8,7]],[[8,9],[2,9],[8,7]],[[8,14],[4,0],[10,14]],[[6,0],[4,0],[10,14]]],
  C:[[[10,4],[8,4],[8,0]],[[7,2],[8,4],[8,0]],[[8,0],[7,2],[2,0]],[[3,2],[7,2],[2,0]],[[2,0],[3,2],[0,4]],[[2,4],[3,2],[0,4]],[[0,4],[2,4],[0,10]],[[2,10],[2,4],[0,10]],[[0,10],[2,10],[2,14]],[[3,12],[2,10],[2,14]],[[2,14],[3,12],[8,14]],[[7,12],[3,12],[8,14]],[[8,14],[7,12],[10,10]],[[8,10],[7,12],[10,10]]],
  K:[[[0,0],[2,0],[0,14]],[[2,14],[2,0],[0,14]],[[8,0],[10,0],[2,7]],[[4,7],[10,0],[2,7]],[[2,7],[4,7],[8,14]],[[10,14],[4,7],[8,14]]],
  E:[[[0,0],[2,0],[0,14]],[[2,14],[2,0],[0,14]],[[2,8],[2,6],[10,8]],[[10,6],[2,6],[10,8]],[[2,0],[2,2],[10,0]],[[10,2],[2,2],[10,0]],[[2,12],[2,14],[10,12]],[[10,14],[2,14],[10,12]]],
  R:[[[0,0],[2,0],[0,14]],[[2,14],[2,0],[0,14]],[[2,0],[2,2],[8,0]],[[7,2],[2,2],[8,0]],[[8,0],[7,2],[10,2]],[[8,3],[7,2],[10,2]],[[10,2],[8,3],[10,6]],[[8,5],[8,3],[10,6]],[[10,6],[8,5],[8,8]],[[7,6],[8,5],[8,8]],[[8,8],[7,6],[2,8]],[[2,6],[7,6],[2,8]],[[6,8],[8,8],[8,14]],[[10,14],[8,8],[8,14]]],
  S:[[[10,2],[8,3],[8,0]],[[7,2],[8,3],[8,0]],[[8,0],[7,2],[2,0]],[[3,2],[7,2],[2,0]],[[2,0],[3,2],[0,2]],[[2,3],[3,2],[0,2]],[[0,2],[2,3],[0,6]],[[2,5],[2,3],[0,6]],[[0,6],[2,5],[2,8]],[[3,6],[2,5],[2,8]],[[2,8],[3,6],[7,8]],[[8,6],[3,6],[7,8]],[[7,8],[8,6],[8,9]],[[10,8],[8,6],[8,9]],[[8,9],[10,8],[8,11]],[[10,12],[10,8],[8,11]],[[8,11],[10,12],[7,12]],[[8,14],[10,12],[7,12]],[[7,12],[8,14],[3,12]],[[2,14],[8,14],[3,12]],[[3,12],[2,14],[2,11]],[[0,12],[2,14],[2,11]]],
  M:[[[0,14],[2,14],[0,0]],[[2,0],[2,14],[0,0]],[[8,0],[10,0],[8,14]],[[10,14],[10,0],[8,14]],[[0,0],[4,10],[2,0]],[[6,10],[4,10],[2,0]],[[8,0],[4,10],[10,0]],[[6,10],[4,10],[10,0]]],
  P:[[[0,0],[2,0],[0,14]],[[2,14],[2,0],[0,14]],[[2,0],[2,2],[8,0]],[[7,2],[2,2],[8,0]],[[8,0],[7,2],[10,2]],[[8,3],[7,2],[10,2]],[[10,2],[8,3],[10,6]],[[8,5],[8,3],[10,6]],[[10,6],[8,5],[8,8]],[[7,6],[8,5],[8,8]],[[8,8],[7,6],[2,8]],[[2,6],[7,6],[2,8]]],
  L:[[[0,0],[2,0],[0,14]],[[2,12],[2,0],[0,14]],[[0,14],[2,12],[10,14]],[[10,12],[2,12],[10,14]]],
  O:[[[10,10],[8,10],[10,4]],[[8,4],[8,10],[10,4]],[[10,4],[8,4],[8,0]],[[7,2],[8,4],[8,0]],[[8,0],[7,2],[2,0]],[[3,2],[7,2],[2,0]],[[2,0],[3,2],[0,4]],[[2,4],[3,2],[0,4]],[[0,4],[2,4],[0,10]],[[2,10],[2,4],[0,10]],[[0,10],[2,10],[2,14]],[[3,12],[2,10],[2,14]],[[2,14],[3,12],[8,14]],[[7,12],[3,12],[8,14]],[[8,14],[7,12],[10,10]],[[8,10],[7,12],[10,10]]]
}
class Canvas
  attr_reader :width, :height, :color, :depth
  def initialize(w, h)
    @width = w
    @height = h
    @color = height.times.map{width.times.map{1}}
    @depth = height.times.map{width.times.map{999}}
  end
  def clear(z,t,sea=0.4,sky=0.6)
    depth.each{|l|l.map!{999}}
    width.times{|x|
      y1=(Math.sin(x*0.16-t)+Math.sin(x*0.23-t))*2+z*height
      y2=(Math.sin(x*0.14-t)+Math.sin(x*0.16+t))*2+z*height
      y3=(Math.sin(x*0.23+t)+Math.sin(x*0.17+t))*2+z*height
      height.times{|y|
        color[y][x]=sky+(sea-sky)*[y1,y2,y3].count{|yy|y>yy}/3.0
      }
    }
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
  def ball(x,y,z,r,c)
    x,y=((x-@camx+(y-@camy).i)*@rotxy).rect
    y,z=((y+(z-@camz).i)*@rotz).rect
    return if z<=0
    x*=2/z
    y*=2/z
    r*=2/z
    cx=width*(1+x)*0.5
    cy=(y*width+height)*0.5
    cr=r*width*0.5
    ([cx-cr,0].max.ceil..[cx+cr,width-1].min.floor).each{|ix|
      ([cy-cr,0].max.ceil..[cy+cr,height-1].min.floor).each{|iy|
        if (ix-cx)**2+(iy-cy)**2<cr*cr && depth[iy][ix]>z
          depth[iy][ix]=z
          color[iy][ix]=c
        end
      }
    }
  end
  def triangle(a,b,c)
    a,b,c=[a,b,c].map{|p|
      x,y=((p[0]-@camx+(p[1]-@camy).i)*@rotxy).rect
      y,z=((y+(p[2]-@camz).i)*@rotz).rect
      return if z<=0
      [x/z*2,y/z*2,z,p[3]]
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
      ].compact.reject(&:nan?).minmax
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
    $><< "\e[1;1H"+color.each_slice(2).map{|a,b|a.zip(b).map{|a,b|TABLE[a*15.9][b*15.9]}*''}*$/
  end
end

def flower
  tris = []
  fy=->x{(0.8+0.2*x)*((1-(2*x-1)**2)/4)**0.7}
  fz=->x{2-1/(32*x*x+0.5)+x+(1-x*x)**0.5-1}
  6.times do |i|
    rot=(0.5+(3**0.5/2).i)**i
    12.times{|j|
      k=i%2
      x1=j/12.0
      x2=(j+1)/12.0
      z1=fz[x1]-k*0.2*x1
      z2=fz[x2]-k*0.2*x2
      c1=[0.4+0.7*j/12*(1-k*0.4),1].min
      c2=[0.4+0.7*(j+1)/12*(1-k*0.4),1].min
      a=(x1+fy[x1].i*(1-k*0.1))*rot
      b=(x1-fy[x1].i*(1-k*0.1))*rot
      c=(x2+fy[x2].i*(1-k*0.1))*rot
      d=(x2-fy[x2].i*(1-k*0.1))*rot
      a=[*a.rect,z1,c1]
      b=[*b.rect,z1,c1]
      c=[*c.rect,z2,c2]
      d=[*d.rect,z2,c2]
      tris<<[a,b,c].map(&:dup) if a!=b
      tris<<[b,c,d].map(&:dup) if c!=d
    }
  end
  tris.each{|t|t.each{|p|p[0]*=0.2;p[1]*=0.2;p[2]*=0.2;p[2]+=1}}
  balls=5.times.map{[0.06*rand-0.03,0.06*rand-0.03,1.36,0.008, 0]}
  balls<<[-0.02,0,1.38,0.012,1]
  8.times{|i|
    z1=i/8.0
    z2=(i+1)/8.0
    s=0.02
    c=0.3
    lc=0.3+0.2*i/8
    tris<<[[-s,0,z1,c],[s,0,z1,c],[s,0,z2,c]]
    tris<<[[-s,0,z1,c],[s,0,z2,c],[-s,0,z2,c]]
    tris<<[[0,-s,z1,c],[0,s,z1,c],[0,s,z2,c]]
    tris<<[[0,-s,z1,c],[0,s,z2,c],[0,-s,z2,c]]
    r=2**(3*i).i
    l2=(r/3).rect
    l1=((0.4+0.2i)*r/3).rect
    l3=((0.4-0.2i)*r/3).rect
    lz1=z1+0.125
    tris<<[[0,0,z1,lc],[*l1,lz1,lc],[*l3,lz1,lc]]
    tris<<[[*l1,lz1,lc],[*l3,lz1,lc],[*l2,z1+0.25,lc]]
  }
  [tris,balls]
end


fl,flb=flower

renderfont=->c,t0{
  c.camera(0,0,0,Math::PI/2,-Math::PI/2)
  %w[HACKERS CHAMPLOO].each_with_index{|s,yi|
    s.chars.each_with_index{|ch,xi|
      t = [2+(xi+4*yi)*0.04-t0,0].max
      next if t>1
      t*=t
      vx,vy,vz,r1,r2,r3=6.times.map{|k|Math.sin(123*~k*~xi*~yi)*4%1}
      FONT[ch.to_sym].each{|tri|
        c.triangle *tri.map{|fx,fy|
          x=(fx-5)/120.0*(1-t)
          y=(7-fy)/120.0*(1-t)
          z=0
          x0=-0.4+xi*0.1
          y0=0.2-0.4*yi
          2.times{
            x,y=(x+y.i).*(32**(t*r1).i).rect
            y,z=(y+z.i).*(32**(t*r2).i).rect
            z,x=(z+x.i).*(32**(t*r3).i).rect
          }
          [x0+vx*t/2+x,y0+vy*t/2+y,-1+vz*t/2+z,1]
        }
      }
    }
  }
}

c=Canvas.new(W,H)
cnt=0
loop{
  time0=Time.now
  cnt+=1
  t=cnt*0.01
  conv = ->p{
    x,y,z,*e=p
    cdist=1.5+0.1*Math.sin(8*t)
    r=cdist-x
    th=z/cdist
    x=cdist-r*Math.cos(th)
    z=r*Math.sin(th)
    x,z=(x+z.i).*(2.7**-0.2i).rect
    [x-0.7,y-0.5,z,*e]
  }

  th = Math::PI/2+0.8
  cam1 = [-1.2*Math.cos(th),-1.2*Math.sin(th),1.5,th,-0.5]
  cam2 = [-1.2*Math.cos(th*1.3)-0.3,-0.2-1.2*Math.sin(th*1.3),1.3,th*1.3,-0.3]
  cam3 = [-1.2*Math.cos(th*1.6)+0.4,-0.4-1.2*Math.sin(th*1.6),0.9,th*1.6,0.1]
  camt = Math.acos(Math.cos(Math::PI*t))/Math::PI*2
  t6 = t**6
  camt = 2*t6/(1+t6)
  cam=cam1.zip(cam2,cam3).map{|a,b,c|
    (1-camt)*(2-camt)/2*a+camt*(2-camt)*b+camt*(camt-1)/2*c
  }
  c.camera(*cam)
  sk=0.6/(1+0.5*camt)
  if camt<1.9
    c.clear 0.4+(cam[4]+0.5)*2, t*10, 0.4/(1+camt), sk
  else
    c.clear 0.6, t*10, sk*(20-10*camt), sk+0.25*(10*camt-19)
  end
  fl.each{|tri|c.triangle *tri.map(&conv)}
  flb.each{|b|c.ball(*conv[b] )}

  srand 0
  gdx=-Math.sin(th)*0.05
  gdy=Math.cos(th)*0.05
  r=0.7
  gpos=->x,y{[x-0.3,y,0.1-0.2*(x*x+y*y)/r/r+0.05*Math.cos(x*7+y*8),0]}
  mdl=->a,b{a.zip(b).map{|a,b|(a+b)/2.0}}
  10.times{|i|10.times{|j|
    x0=2.0*i/9-1;x1=x0+2/9.0
    y0=2.0*j/9-1;y1=y0+2/9.0
    x0*=r;x1*=r;y0*=r;y1*=r
    c.triangle(gpos[x0,y0],gpos[x1,y0],gpos[x0,y1])
    c.triangle(gpos[x1,y1],gpos[x1,y0],gpos[x0,y1])
  }}
  64.times{|i|
    x,y=(r*rand**0.7).*(Math::E**(2*Math::PI*rand).i).rect
    gx0=0.1+0.1*rand
    gy0=0.1+0.1*rand
    gh=0.4+0.1*rand
    a=0.6+0.6*rand
    gx=0.05*a*Math.sin(8*t+2*x+1.3*y)
    gy=0.05*a*Math.sin(7*t+2*y-1.2*x)
    pa=gpos[x-gdx,y-gdy]
    pb=gpos[x+gdx,y+gdy]
    pe=mdl[pa,pb];pe[2]+=gh;pe[3]=0.8
    pc=mdl[pa,pe];pd=mdl[pb,pe]
    pe[0]+=gx0+gx;pe[0]+=gy0+gy
    pc[0]+=gx0/2+gx/4;pc[0]+=gy0/2+gy/4
    pd[0]+=gx0/2+gx/4;pd[0]+=gy0/2+gy/4
    c.triangle(pa,pb,pc)
    c.triangle(pb,pc,pd)
    c.triangle(pc,pd,pe)
  }
  gpos2=->x,y{
    z=0.7-3.2*((1+x*x+y*y)**0.5-1)+Math.sin(6*x+4*y)*0.1
    x=0.4+1.6*x
    y=2.5+1.6*y
    [x,y,z,0.3+0.3*Math.sin(z)]
  }
  16.times{|i|16.times{|j|
    x0=2.0*i/15-1;x1=x0+2/15.0
    y0=2.0*j/15-1;y1=y0+2/15.0
    c.triangle(gpos2[x0,y0],gpos2[x1,y0],gpos2[x0,y1])
    c.triangle(gpos2[x1,y1],gpos2[x1,y0],gpos2[x0,y1])
  }}
  renderfont[c,t]
  c.show
  sleep [0.05-(Time.now-time0), 0.01].max
}
