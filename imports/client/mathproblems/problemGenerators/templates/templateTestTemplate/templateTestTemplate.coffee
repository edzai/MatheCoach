require "./templateTestTemplate.jade"

Template.templateTestOneGeneratorTemplate.viewmodel
  points : ->
    "0,0 0,#{@la()} #{@lb()},#{@la()}"
  transform : ->
    center = "#{100-@lb()/2} #{100-@la()/2}"
    "translate(#{center})"
  unitTex : -> "\\text{#{@unit()}}"
  labels : -> [
      x : 0
      y : @la() / 2
      text : "#{@la()}#{@unit()}"
      transform : "rotate(90, 0, #{@la()/2})"
    ,
      x : @lb() / 2
      y : @la()
      text : "#{@lb()}#{@unit()}"
      transform : ""
    ]
