#!/usr/bin/env ruby

require 'solidruby'
include SolidRuby

g1 = PrintedGear.new(module: 2.0, teeth: 40, bore: 8.5, height: 6)
res = g1.show.color('red')

res += cylinder(d: 20, h: nut_support_height = 20)

n = Nut.new(8)
res -= n.output.translate(z: nut_support_height - n.height + 0.1)

res -= cylinder(d: 8.5, h: nut_support_height)

puts res.scad_output
