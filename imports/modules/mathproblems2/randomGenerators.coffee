_ = require "lodash"

isPrime = (n) ->
  result = true
  for i in [2..n-1]
    if n % i is 0 then result = false
  result

class Rnd
  constructor : () ->

  int : (max = 20) -> _.random max
  intPlus : (max = 20) -> _.random 1, max
  int2Plus : (max = 20) -> _.random 2, max

  ints : (max = 20) -> (@int max for i in [1..10])
  intsPlus : (max = 20) -> (@intPlus max for i in [1..10])
  ints2Plus : (max = 20) -> (@int2Plus max for i in [1..10])

  uniqueInts : (max = 20) -> (_.shuffle [0..max])[0..9]
  uniqueIntsPlus : (max = 20) -> (_.shuffle [1..max])[0..9]
  uniqueInts2Plus : (max = 20) -> (_.shuffle [2..max])[0..9]

  primes : (max = 19) -> (i for i in [2..max] when isPrime i)
  prime : (max = 19) -> _.sample @primes(max)
  uniquePrimes : (max = 19) -> _.shuffle @primes(max)

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

exports.Rnd = Rnd
