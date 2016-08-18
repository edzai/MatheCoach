{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ re } = require "../RegExs.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"


exports.fractionGenerator =

  strichGleichnamig : (level = 1) ->
    [a, b, c] = if level is 1
      rnd.ints2Plus(9)
    else
      rnd.ints2Plus(20)
    op = rnd.opStrich()
    if op is "+"
      opStr = "Addiere"
    else
      opStr = "Subtrahiere"
      if b > a then [a, b] = [b, a]
    #return:
    problem : "#{a}/#{c} #{op} (#{b}/#{c})"
    form : re.fraction
    description : "#{opStr} die Brüche:"
    hint : "Die Brüche sind schon gleichnamig."

  strichUngleichnamig : (level = 1) ->
    maxN = switch level
      when 1 then 9
      when 2 then 20
      when 3 then 100
      else 1000
    [a, b, c, d] = rnd.uniqueInts2Plus maxN
    op = rnd.opStrich()
    if op is "+"
      opStr = "Addiere"
      opStr2 = "addierst"
    else
      opStr = "Subtrahiere"
      opStr2 = "subtrahierst"
      if a/c < b/c
        [a, b, c, d] = [b, a, d, c]
    #return:
    problem : "#{a}/#{c} #{op} (#{b}/#{d})"
    form : re.fraction
    description : "#{opStr} die Brüche:"
    hint : "Mache die Brüche gleichnamig ehe du sie #{opStr2}."

  malGanzeZahl : (level = 1) ->
    switch level
      when 1 then maxN = 9
      when 2 then maxN = 20
      when 3 then maxN = 100
      else maxN = 1000
    [a, b] = rnd.uniqueInts2Plus maxN
    c = rnd.int2Plus maxN
    head = rnd.bool()
    #return
    problem :
      if head
        "(#{a}/#{b}) * #{c}"
      else
        "#{c} * (#{a}/#{b})"
    form : re.fraction
    description : "Multipliziere den Bruch mit der Zahl:"

  malBruch : (level = 1) ->
    switch level
      when 1 then maxN = 9
      when 2 then maxN = 20
      else maxN = 100
    [a, b] = rnd.uniqueInts2Plus maxN
    [c, d] = rnd.uniqueInts2Plus maxN
    #return
    problem : "(#{a}/#{b}) * (#{c}/#{d})"
    form : re.fraction
    description : "Multipliziere die Brüche:"

  malBruchKuerzbar : (level = 1) ->
    switch level
      when 1 then maxN = 9
      when 2 then maxN = 20
      else maxN = 100
    [a, b] = rnd.uniqueInts2Plus maxN
    [c, d] = rnd.uniqueInts2Plus maxN
    e = rnd.int2Plus(9)
    head = rnd.bool()
    #return
    problem :
      if head
        "(#{a*e}/#{b*e}) * (#{c}/#{d})"
      else
        "(#{a}/#{b}) * (#{c*e}/#{d*e})"
    form : re.fraction
    description : "Multipliziere die Brüche:"
    hint :
      "Du kannst auf jeden Fall mindestens einen der beiden Brüche \
      kürzen ehe Du die Brüche multiplizierst."

  malKreuzKuerzbar : (level = 1) ->
    switch level
      when 1 then maxN = 9
      when 2 then maxN = 20
      else maxN = 100
    [a, b] = rnd.uniqueInts2Plus maxN
    [c, d] = rnd.uniqueInts2Plus maxN
    e = rnd.int2Plus 9
    head = rnd.bool()
    #return
    problem :
      if head
        "(#{a*e}/#{b}) * (#{c}/#{d*e})"
      else
        "(#{a}/#{b*e}) * (#{c*e}/#{d})"
    form : re.fraction
    description : "Multipliziere die Brüche:"
    hint :
      "Du kannst auf jeden Fall mindestens einmal überkreuz \
      kürzen ehe Du die Brüche multiplizierst. Überkreuz kürzen \
      geht nur bei Mal. Nicht bei Plus oder Minus!"

  zusammenGesetzt : (level = 1) ->
    head = rnd.bool()
    switch level
      when 1
        maxN1 = maxN2 = maxN3 = 9
      when 2
        if head
          maxN1 = 9
          maxN2 = 9
          maxN3 = 20
        else
          maxN1 = 20
          maxN2 = 9
          maxN3 = 9
      when 3
        if head
          maxN1 = 9
          maxN2 = 20
          maxN3 = 20
        else
          maxN1 = 20
          maxN2 = 20
          maxN3 = 9
      else
        maxN1 = maxN2 = maxN3 = 20
    [a, b] = rnd.uniqueInts2Plus maxN1
    [c, d] = rnd.uniqueInts2Plus maxN2
    [e, f] = rnd.uniqueInts2Plus maxN3
    op1 = rnd.op()
    op2 = rnd.opNotDiv()
    head = rnd.bool()
    switch op1
      when "+"
        opStr1 = "eine Summe"
        opStr2 = "addiert"
      when "-"
        opStr1 = "eine Differenz"
        opStr2 = "subtrahiert"
      when "*"
        opStr1 = "ein Produkt"
        opStr2 = "multipliziert"
      when "/"
        opStr1 = "ein Quotient"
        opStr2 = "dividiert"
    opStr3 = switch op2
      when "+" then "die Summe"
      when "-" then "die Differenz"
      when "*" then "das Produkt"
    #return
    problem :
      if head
        "(#{a}/#{b}) #{op1} ((#{c}/#{d}) #{op2} (#{e}/#{f}))"
      else
        "((#{a}/#{b}) #{op2} (#{c}/#{d})) #{op1} (#{e}/#{f})"
    form : re.fraction
    description : "Löse die Bruchrechenaufgabe:"
    hint :
      "Nebenbei: Der Term ist #{opStr1}, weil man einen Bruch und #{opStr3} \
      von zwei Brüchen #{opStr2}."
