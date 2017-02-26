SolidRuby
===========

SolidRuby is a framework for programming 2d and 3d OpenSCAD models in Ruby.
It is a fork of [CrystalScad](https://github.com/Joaz/CrystalScad) with the aim to update and improve the codebase.

SolidRuby, like CrystalScad and RubyScad on which it is based, is released under the GPLv3 license.

Installation:
===========

Dependencies:

- Ruby 1.9.3+

Install via gem:
### \# gem install solidruby

if you have multiple ruby versions, you likely need to use gem1.9.3 instead of gem.

Install via git:

- clone repository
- \# rake install

Getting started
===========
SolidRuby comes with a generator that generates project stubs automatically for you. Run this command from a terminal in the directory that you want to create a project:

```
# solidruby new [my_project_name]
```
Change [my_project_name] to the name of your project

A project named "my_project" will create those files and directories:

- my_project/my_project.rb - the controller
- my_project/lib/assemblies - for putting together assemblies of individual parts
- my_project/lib/electronics - put electronics here
- my_project/lib/hardware - put hardware parts in here
- my_project/lib/printed - put parts that you want to print in here
- my_project/lib/lasercut - put sheets that need to be cut (by laser or other) in here
- my_project/lib/assemblies/my_project_assembly.rb  - dummy assembly
- my_project/lib/printed/testcube.rb  - dummy printed part
- my_project/Guardfile - guard

Open up the controller (here my_project/my_project.rb ) in the text editor of your choice.
A Guardfile is also created to automatically update the output scad files.

Coding
===========
Nearly all OpenSCAD functions are implemented. You can use the same parameters as in OpenSCAD, although SolidRuby provides some convenient variable names like f.e. Diameter (d) for cylinders.

Some examples:

CSG Modeling:

  res = cylinder(d:10,h:10)
  # union
  res += cube(x:5,y:20,z:20)
  # difference
  res -= cylinder(d:5,h:10)
  # intersection
  res *= cylinder(d:10,h:10)


Chain transformations:  
  res = cube([1,2,3]).rotate(x:90).translate(x:20,y:2,z:1).mirror(z:1)


Hull:   
  res = hull(cylinder(d:10,h:10).cube([20,10,10].translate(x:10)))

Center cubes in X/Y direction only:     
  cube([10,10,10]).center_xy # note: does only work on cubes and must be put before any transformations

Also implemented: center_x, center_y, center_z  


Long slots:   
  # produces a hull of two cylinders, 14mm apart        
  long_slot(d:4.4,h:10,l:14)  



A few tips:

- Be visual. Put your desired situation on the screen, then model your object around it
- On bigger project, do output multiple files automatically. Use .save(filename) to save openscad code of your desired objects
- When porting OpenScad code, beware of dividing integers. Example:
  cylinder(r=11/2,h=10);
  needs to be ported to
  cylinder(r:11.0/2,h:10)
  or
  cylinder(d:11,h:10)


License:
===========
GPLv3
