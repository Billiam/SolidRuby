#!/usr/bin/env ruby

require 'solidruby'
include SolidRuby

# This example shows the use of ScrewThreads in SolidRuby.

class CustomPartWithFemaleThread < SolidRuby::Assembly
  # this could be something like a tslot-nut

  def initialize
    @x = 8
    @y = 20
    @z = 8
  end

  def show
    res = cube([@x, @y, @z]).color(r: 180, b: 180, g: 180)
    res -= threads_top.show # - tries output normally, we want show here
  end

  def threads_top
    ScrewThread.new(x: @x / 2, y: @y / 2 + 3, size: 4, depth: @z)
  end
end

class CustomPartWithMaleThread < SolidRuby::Assembly
  def initialize
    @x = 50
    @y = 50
    @z = 15
  end

  def show
    res = cube([@x, @y, @z]).color(r: 200, b: 200, g: 200, a: 100)
    res += threads
  end

  def threads_top
    ScrewThread.new(x: @x / 2 + 2, y: @y / 2 + 2, z: @z, size: 4, depth: @z)
  end

  def threads_bottom
    ScrewThread.new(x: @x / 2 + 2, y: @y / 2 + 2, z: 0, size: 4, depth: @z, face: 'bottom')
  end

  def threads_left
    ScrewThread.new(x: 0, y: 10, z: 8, size: 4, depth: 10, face: 'left')
  end

  def threads_right
    ScrewThread.new(x: @x, y: 15, z: 3, size: 4, depth: 10, face: 'right')
  end

  def threads_front
    ScrewThread.new(x: 25, y: 0, z: 11, size: 4, depth: 10, face: 'front')
  end

  def threads_back
    ScrewThread.new(x: 25, y: @y, z: 11, size: 4, depth: 10, face: 'back')
  end
end

female = CustomPartWithFemaleThread.new
male = CustomPartWithMaleThread.new

pos = male.threads_top.position_on(female.threads_top)

res = male.show
res += female.show.translate(pos)

rotation = {}
pos = male.threads_bottom.position_on(female.threads_top, rotation)
res += female.show.rotate(rotation).mirror(z: 1).translate(pos)

rotation = { y: -90 }
pos = male.threads_left.position_on(female.threads_top, rotation)
res += female.show.rotate(rotation).translate(pos)

rotation = { y: 90 }
pos = male.threads_right.position_on(female.threads_top, rotation)
res += female.show.rotate(rotation).translate(pos)

rotation = { x: 90 }
pos = male.threads_front.position_on(female.threads_top, rotation)
# testing rotate_around here
res += female.show.rotate_around(female.threads_top, z: 90).rotate(rotation).translate(pos)

rotation = { x: -90 }
pos = male.threads_back.position_on(female.threads_top, rotation)
res += female.show.rotate(rotation).translate(pos)

puts res.scad_output
