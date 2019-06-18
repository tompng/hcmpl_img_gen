char_pattern = /class="(.)".+((?:\n +<p.+)*)\n +<\/g>/
File.read('font.svg').scan(char_pattern).each do |ch, content|
  triangles = []
  content.scan(/d="[^"]+"/).each do |path|
    nums = path.scan(/[0-9.]+/).map { |a| a.to_f.*(2).round }
    coords = nums.each_slice(2)
    n = coords.size / 2
    l1 = coords.take(n)
    l2 = coords.drop(n).reverse
    (n-1).times do |i|
      triangles<<[l1[i], l2[i], l1[i+1]]
      triangles<<[l2[i+1], l2[i], l1[i+1]]
    end
  end
  puts "#{ch}:#{triangles.inspect.delete(' ')},"
end
