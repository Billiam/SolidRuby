#!/usr/bin/env ruby

require 'solidruby'
include SolidRuby

t1 = PrintedThread.new(diameter: 20, pitch: 2.5, length: 22.5, internal: true)
t2 = PrintedThread.new(diameter: 20, pitch: 2.5, length: 20, internal: false)

res = cube([25, 25, z = 26]).center_xy
res -= t1.output
res += t2.output.translate(z: z)

puts res.scad_output
