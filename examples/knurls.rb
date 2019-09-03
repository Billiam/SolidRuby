#!/usr/bin/env ruby
require 'solidruby'
include SolidRuby

res = knurled_cube([41, 10, 4])
# Total rendering time: 0 hours, 5 minutes, 53 seconds

# Total rendering time: 0 hours, 1 minutes, 41 seconds

# res = knurled_cylinder(d:16,h:10)

puts '$fn=64;'
puts res.scad_output
