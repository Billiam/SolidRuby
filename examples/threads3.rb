#!/usr/bin/env ruby

require 'solidruby'
include SolidRuby

class NutPart < SolidRuby::Assembly
  def initialize
    @hardware = []
    @height = 10
    super
  end

  def part(_show)
    res = cube([50, 50, @height]).center_xy

    @hardware << Nut.new(4, direction: '-z')
    @hardware << Nut.new(4, direction: 'z').translate(x: 10, z: @height - 3)
    @hardware << Nut.new(4, slot: 15, slot_direction: '-x', direction: 'x').rotate(y: 90).translate(x: -20, y: 5, z: @height - 5)
    @hardware << Nut.new(4, slot: 15, slot_direction: 'x', direction: 'x').rotate(y: -90).translate(x: 20, y: -8, z: @height - 5)

    @hardware << Nut.new(4, slot: 15, slot_direction: '-y', direction: 'y').rotate(x: -90).translate(x: 2, y: -20, z: @height - 5)
    @hardware << Nut.new(4, slot: 15, slot_direction: 'y', direction: 'y').rotate(x: 90).translate(x: -10, y: 20, z: @height - 5)

    res -= @hardware
  end
end

class ScrewOnPart < SolidRuby::Assembly
  def initialize
    @nutpart = NutPart.new
    super
  end

  def part(_show)
    res = @nutpart.show

    @nutpart.hardware.each do |hw|
      res += hw.bolt(20)
    end
    res
  end
end

res = ScrewOnPart.new.show

puts res.scad_output
