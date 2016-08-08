{ Rnd } = require "./randomGenerators.coffee"

rnd = new Rnd()

exports.problemDefinitions =
  examples :
    title : "Vermischte Übungsaufgaben"
    problems : [
      ->
        [a, b, c] = rnd.ints2Plus()
        #return:
        problem : "#{a}/#{c} + #{b}/#{c}"
        #solution : "#{a+b}/#{c}"
        form : /\d+\/\d+/
        description : "Addiere die Brüche:"
        hint : "Die Brüche sind schon gleichnamig."
    ,
      ->
        [a, b] = rnd.intsPlus()
        [c, d] = rnd.uniqueInts2Plus()
        #return:
        problem : "#{a}/#{c} + #{b}/#{d}"
        #solution : "#{a*d + b*c} / #{c*d}"
        form : /\d+\/\d+/
        description : "Addiere die Brüche:"
        hint : "Mache gleichnamig ehe Du addierst"
    ,
      ->
        [a, b, c, d] = rnd.uniqueInts2Plus()
        op = rnd.op()
        #return:
        problem : "#{a}/#{c} #{op} #{b}/#{d}"
        description : "Löse die Bruchrechenaufgabe"
    ,
      ->
        [a, c] = rnd.primeReducable(10)
        [b, d] = rnd.primeReducable(20)
        op = rnd.opStrich()
        opStr = if op is "+"
          "die Summe"
        else
          "die Differenz"
        #return
        problem : "#{a}/#{c} #{op} #{b}/#{d}"
        form: /\d+\/\d+/
        description : "Berechne #{opStr} der Brüche"
        hint : "Wenn Du die Brüche Kürzt, ehe du #{opStr} berechnest, \
        werden die Produkte beim Gleichnamigmachen in den meisten \
        Fällen deutlich einfacher."
    ,
      ->
        [a, b, c, d, e, f] = rnd.uniquePrimes(30)
        op = rnd.opStrich()
        #return:
        problem : "#{a}/#{b} * (#{c}/#{d} #{op} #{e}/#{f})"
        description : "Löse die einfache Bruchrechenaufgabe:"
        hint : "Die Aufgabe ist deshalb 'einfach', weil man sich keine\
          Gedanken über das Kürzen zu machen braucht. Aber dafür werden\
          die Produkte beim Gleichnamigmachen ziemlich gemein."
    ]
