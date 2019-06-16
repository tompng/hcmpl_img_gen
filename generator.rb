require ='pry'
require 'chunky_png'
module BMP
  def self.int_to_byte4(n)
    4.times.map { |i|((n >> (8 * i)) & 0xff).chr }.join
  end

  def self.data_size(w, h, bytes_per_pixel = 3)
    (w * bytes_per_pixel + 3) / 4 * 4 * h
  end

  def self.header_size
    54
  end

  def self.header(w, h, bytes_per_pixel = 3)
    data_size = self.data_size w, h, bytes_per_pixel
    a = "BM#{int_to_byte4(header_size + data_size)}\0\0\0\0#{int_to_byte4(header_size)}#{int_to_byte4(40)}#{int_to_byte4(w)}#{int_to_byte4(h)}"
    b = "\x01\0#{(bytes_per_pixel * 8).chr}\0\0\0\0\0#{int_to_byte4(data_size)}\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"
    a + b
  end
end

[3, 4].each do |bpp|
  whs = [*1..256].repeated_permutation(2).select do |w, h|
    filesize = BMP.header_size + BMP.data_size(w, h, bpp)
    s = BMP.int_to_byte4(filesize)
    s =~ /^[&^>~]#/
  end
  p bpp
  p whs.sort_by { |w, h| [w.fdiv(h), h.fdiv(w)].max }.take(20)
end

width = 60
height = 50
bytes_per_pixel = 3
code = "\n" + <<~CODE + "\n__END__\n"
aa if eval %w(ev al ([D AT A. bi nm od e. re ad.ch ar s .m ap {| a|'%0 3b'%( +a.or  d&+7 )}.jo in ,].pa ck 'b *' )) *'';;
CODE
#0###222###444###666###888###000###222###444###666###888###000###222###444###666###888###000###222###444###666###888###000
p code

image = ChunkyPNG::Image.from_file 'input.png'
embedded_code = File.read 'code.rb' # 3300 bytes
bits = embedded_code.unpack1('b*').chars

File.write 'out.bmp', [
  BMP.header(width, height),
  (3 * width * height).times.map do |i|
    next code[i] if i < code.size
    pos, cidx = i.divmod 3
    y, x = pos.divmod width
    ix = ((x+0.5) * image.width / width).floor
    iy = ((height - y - 0.5) * image.height / height).floor
    color = image[ix, iy]
    col = (color >> (8 * (cidx + 1))) & 0xff
    ((col & 0xf8) | bits.shift(3).join.to_i(2)).chr
  end.join
].join
raise "exceed #{bits.size.fdiv(8).ceil}" unless bits.empty?
