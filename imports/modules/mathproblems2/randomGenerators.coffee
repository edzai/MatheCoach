_ = require "lodash"

isPrime = (n) ->
  result = true
  unless n is 2
    for i in [2..n-1]
      if n % i is 0 then result = false
  result

alphabet = "abcdefghijklmnopqrstuvwxyz".split ""

class Rnd
  constructor : () ->

  int : (max = 20) -> _.random max #returns just a single value
  intPlus : (max = 20) -> _.random 1, max
  int2Plus : (max = 20) -> _.random 2, max

  ints : (max = 20) -> (@int max for i in [1..10])
  intsPlus : (max = 20) -> (@intPlus max for i in [1..10])
  ints2Plus : (max = 20) -> (@int2Plus max for i in [1..10])

  uniqueInts : (max = 20) -> _.sampleSize [0..max], 10
  uniqueIntsPlus : (max = 20) -> _.sampleSize [1..max], 10
  uniqueInts2Plus : (max = 20) -> _.sampleSize [2..max], 10

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
  opStrich : -> _.sample ["+", "-"]
  opPunkt : -> _.sample ["*", "/"]
  opNotDiv : -> _.sample ["+", "-", "*"]

  #random variable names (a.k.a. letters)
  letter : -> _.sample alphabet
  letters : -> (letter for i in [1..10])
  uniqueLetters : -> _.sampleSize alphabet, 10

exports.Rnd = Rnd
