#!/usr/bin/env ruby
require 'solidruby'
include SolidRuby

# Used to debug
# https://github.com/jglauche/CrystalScad/issues/5

pipe = Pipe.new(diameter: 10)

pipe.line(5, 'red')
pipe.cw(20, 8, 'yellow')
pipe.line(20, 'blue')

res = pipe.pipe

puts '$fn=64;'
puts res.scad_output
