_ = require "lodash"

isPrime = (n) ->
  result = true
  unless n is 2
    for i in [2..n-1]
      if n % i is 0 then result = false
  result

#dropped some letters because they look weird in TeX output
#or have a special meaning in nerdamer (like i or e)
alphabet = "abcdhjkmnpqrstuvwxyz".split ""

namesOfThings = [
  sg : "Dings"
  pl : "Dingse"
,
  sg : "Knotz"
  pl : "Knötze"
,
  sg : "Bramf"
  pl : "Brämfe"
,
  sg : "Gnargel"
  pl : "Gnargel"
,
  sg : "Fomp"
  pl : "Fömpe"
,
  sg : "Dork"
  pl : "Dorks"
,
  sg : "Sack Heu"
  pl : "Säcke Heu"
,
  sg : "Wumpel"
  pl : "Wumpel"
,
  sg : "Glas Öl"
  pl : "Gläser Öl"
,
  sg : "Tüte Gnel"
  pl : "Tüten Gnel"
]

verbList = [
  sg : "kostet"
  pl : "kosten"
,
  sg : "macht"
  pl : "machen"
,
  sg : "kabunzelt"
  pl : "kabunzeln"
,
  sg : "kombobuliert"
  pl : "kombobulieren"
,
  sg : "verdinkelt"
  pl : "verdinkeln"
,
  sg : "unterstritzelt"
  pl : "unterstritzeln"
,
  sg : "verknust"
  pl : "verknusen"
,
  sg : "überbratzelt"
  pl : "überbratzeln"
,
  sg : "zerknüttert"
  pl : "zerknüttern"
,
  sg : "interplumbiert"
  pl : "interplumbieren"
]

numerusFunction = (word) ->
  (amount = 1) ->
    if amount in [0,1] then word.sg else word.pl

class Rnd
  constructor : () ->

  coeffify : (n) -> if n is 0 then "" else "#{n}"

  int : (max = 20) -> _.random max #returns just a single value
  intPlus : (max = 20) -> _.random 1, max
  int2Plus : (max = 20) -> _.random 2, max
  intMin : (min=2, max = 20) -> _.random min, max

  ints : (max = 20) -> (@int max for i in [1..10])
  intsPlus : (max = 20) -> (@intPlus max for i in [1..10])
  ints2Plus : (max = 20) -> (@int2Plus max for i in [1..10])
  intsMin : (min=2, max=20) -> (@intMin(min, max) for i in [1..10])

  uniqueInts : (max = 20) -> _.sampleSize [0..max], 10
  uniqueIntsPlus : (max = 20) -> _.sampleSize [1..max], 10
  uniqueInts2Plus : (max = 20) -> _.sampleSize [2..max], 10
  uniqueIntsMin : (min=2, max=20) -> _.sampleSize [min..max], 10

  primes : (max = 19) -> (i for i in [2..max] when isPrime i)
  prime : (max = 19) -> _.sample @primes(max) #returns just a single value
  uniquePrimes : (max = 19) -> _.shuffle @primes(max)

  bool : -> _.sample [true, false]
  bools : -> (@bool() for i in [1..10])

  #produces numbers up to max^2
  reducable : (max = 20) ->
    n = @int2Plus(max)
    arr = @uniqueIntsPlus(max)
    (n*c for c in arr)

  primeReducable : (max = 20) ->
    n = @prime(max)
    arr = @uniqueIntsPlus(max)
    (n*c for c in arr)

  reducablePrimes : (max = 20) ->
    n = @int2Plus(max)
    arr = _.shuffle @primes(max)
    (n*c for c in arr)

  #random operators
  op : -> _.sample ["+", "-", "*", "/"]
  ops : -> (@op() for i in [1..10])
  opStrich : -> _.sample ["+", "-"]
  opsStrich : -> (@opStrich() for i in [1..10])
  opMinus : -> _.sample ["", "-"]
  opsMinus : -> (@opMinus() for i in [1..10])
  opPunkt : -> _.sample ["*", "/"]
  opsPunkt : -> (@opPunkt() for i in [1..10])
  opNotDiv : -> _.sample ["+", "-", "*"]
  opsNotDiv : -> (@opNotDiv() for i in [1..10])

  #random variable names (a.k.a. letters)
  letter : -> _.sample alphabet
  letters : -> (@letter() for i in [1..10])
  uniqueLetters : -> _.sampleSize alphabet, 10

  lengthUnitNames = ["mm", "cm", "dm", "m", "km"]
  lengthUnit : -> _.sample lengthUnitNames
  lengthUnits : -> (@lengthUnit() for i in [1..10])
  uniqueLengthUnits : -> _.sampleSize lengthUnitNames, 5

  areaUnitNames = ["mm^2", "cm^2", "dm^2", "m^2", "km^2"]
  areaUnit : -> _.sample areaUnitNames
  areaUnits : -> (@areaUnit() for i in [1..10])
  uniqueAreaUnits : -> _.sampleSize areaUnitNames, 5

  volumeUnitNames = ["mm^3", "cm^3", "dm^3", "m^3", "km^3", "l"]
  volumeUnit : -> _.sample volumeUnitNames
  volumeUnits : -> (@volumeUnit() for i in [1..10])
  uniqueVolumeUnits : -> _.sampleSize volumeUnitNames, 5

  #random names for things
  #returns a function that returns the sg or pl form of the name

  thing : ->
    numerusFunction(_.sample namesOfThings)
  verb : ->
    numerusFunction(_.sample verbList)
  #things and verbs are always a list of unique elements
  uniqueThings : ->
    (numerusFunction(thing) for thing in _.shuffle namesOfThings)
  uniqueVerbs : ->
    (numerusFunction(verb) for verb in _.shuffle verbList)

exports.Rnd = Rnd
