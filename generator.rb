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
  whs = [*1..256].repeated_permutation(2).map do |w, h|
    next nil if bpp == 3 && w % 4 != 0
    filesize = BMP.header_size + BMP.data_size(w, h, bpp)
    s = BMP.int_to_byte4(filesize)
    [w, h, s[0]] if s[1] == '#' && s[0] =~ /[\n -~]/
  end.compact
  puts bpp
  p whs.sort_by { |w, h| [w.fdiv(h), h.fdiv(w)].max }.take(20)
end

width = 180 # 60
height = 138 # 50
bytes_per_pixel = 3
code = "\n" + <<~CODE + "\n__END__\n"
.! if eval %w(ev al ([D AT A. bi nm od e. re ad.ch ar s .m ap {| a|'%0 2b'%( +a.or  d&+3 )}.jo in ,].pa ck 'b *' )) *'';;
CODE
#0###222###444###666###888###000###222###444###666###888###000###222###444###666###888###000###222###444###666###888###000

image = ChunkyPNG::Image.from_file 'input.png'
embedded_code = File.read 'code.rb'
bits = embedded_code.unpack1('b*').chars

data_size = BMP.data_size(width, height, bytes_per_pixel)
embed_size = embedded_code.bytesize
embed_max = (data_size - code.size) * 2 / 8
puts format('embed code: %d/%d %.1f%%', embed_size, embed_max, 100.0 * embed_size / embed_max)
File.write 'out.bmp', [
  BMP.header(width, height, bytes_per_pixel),
  data_size.times.map do |i|
    next code[i] if i < code.size
    y, xpos = i.divmod data_size / height
    x, cidx = xpos.divmod 3
    ix = ((x + 0.5) * image.width / width).floor
    iy = ((height - y - 0.5) * image.height / height).floor
    color = x < width ? image[ix, iy] : 0
    col = (color >> (8 * (cidx + 1))) & 0xff
    ((col & 0b11111100) | bits.shift(2).join.to_i(2)).chr
  end.join
].join
raise "exceed #{bits.size.fdiv(8).ceil}" unless bits.empty?
