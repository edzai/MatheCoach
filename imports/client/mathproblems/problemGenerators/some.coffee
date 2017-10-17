{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

someGenerators =
  oneGenerator : (level = 1, language="de") ->
    #set variables a and b to random ints
    #I set up some helpers for bits of random data that I use alot (see the require)
    [a, b] = rnd.ints()
    #set up a variable that depends on level
    op = switch level
      when 1 then "+"
      when 2 then "-"
      when 3 then "*"
      else "^"
    #return the object with all the required data
    problem : "#{a}#{op}#{b}" #this is used to automatically produce problemTeX and solution
    description : "This comes before the problemTeX" #you should alway supply this
    hint : "this comes after the problemTeX" #this is optional
    #problemTeX : <string with TeX> we can do that ourselves if the default doesn't do it
    #solution : <string with the solution> if nerdamer(problem).text("fractions") doesn't do
    #solutionTeX : <string with TeX> if we need to
    #checks : array of functions that check the result defaults to [Check.equivalent, Check.noReducableFractionsOptional]
    #answerPreprocessor : a function that takes the answer string and does things too it. The default turns "abc" into "a*b*c" but leaves some reserved words like sin, cos or sqrt unchanged. Nerdamer would otherwise treat abc as one variable named abc. So far I have not used anything but the default behavior. So you can probably just leave it alone

  anotherGenerator : (level=1) ->
    #just some nonsense
    problem : "fnord" # if we supply everything else ourselves, this isn't used. I check it in some very basic unit testing though, so I always supply it so those don't fail.
    problemTeX : "1"
    solution : "1"
    solutionTeX : "\\frac{\\sqrt{16}}{2^2}"
    description : "Enter the displayed number"
    hint : "you find the key to press on the upper left side of your keyboard"

#here we put the generators together into a module
exports.someModule =
  title :
    de : "This is the title of the module"
  description :
    de : "this is a description what the module is about"
  problems : [
    levels : [1..2] # the levels at wich this type of problem will appear
    generator : someGenerators.oneGenerator
  ,
    levels : [2..3]
    levelOffset : -1 # at level 2 we will call anotherGenerator(1)
    generator : someGenerators.anotherGenerator
  ]
