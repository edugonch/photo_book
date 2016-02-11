# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
values = %w{animals   architecture   art   asia   australia   autumn   baby   band   barcelona   beach   berlin   bike  bird  birds   birthday   black   blackandwhite   blue   bw   california   canada   canon   car   cat   chicago   china   christmas   church   city   clouds   color   concert   dance   day   de   dog   england   europe   fall   family   fashion   festival   film   florida   flower   flowers   food   football   france   friends   fun   garden   geotagged   germany   girl   graffiti   green   halloween   hawaii   holiday   house   india   instagramapp   iphone   iphoneography   island   italia   italy   japan   kids   la   lake   landscape   light   live   london   love   macro   me   mexico   model   museum   music   nature   new   newyork   newyorkcity   night   nikon   nyc   ocean   old   paris   park   party   people   photo   photography   photos   portrait   raw   red   river   rock   san   sanfrancisco   scotland   sea   seattle   show   sky   snow   spain   spring   square   squareformat   street   summer   sun   sunset   taiwan   texas   thailand   tokyo   travel   tree   trees   trip   uk   unitedstates   urban   usa   vacation   vintage   washington   water   wedding   white   winter }
Tag.create(values.map{|v| {description: v}})
