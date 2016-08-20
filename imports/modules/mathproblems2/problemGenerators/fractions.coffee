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
      when 3 then 50
      else 100
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
      when 3 then maxN = 50
      else maxN = 100
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
    head = rnd.bool()
    switch level
      when 1
        maxN1 = maxN2 = 9
      when 2
        if head
          maxN1 = 20
          maxN2 = 9
        else
          maxN1 = 9
          maxN2 = 20
      else maxN1 = maxN2 = 20
    [a, b] = rnd.uniqueInts2Plus maxN1
    [c, d] = rnd.uniqueInts2Plus maxN2
    #return
    problem : "(#{a}/#{b}) * (#{c}/#{d})"
    form : re.fraction
    description : "Multipliziere die Brüche:"

  malBruchKuerzbar : (level = 1) ->
    switch level
      when 1
        maxN1 = maxN2 = 9
      when 2
        if head
          maxN1 = 20
          maxN2 = 9
        else
          max N1 = 9
          max N2 = 20
      else maxN1 = maxN2 = 20
    [a, b] = rnd.uniqueInts2Plus maxN1
    [c, d] = rnd.uniqueInts2Plus maxN2
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
      when 2 then maxN = 15
      else maxN = 20
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

  bruchDurchZahl : (level = 1) ->
    switch level
      when 1
        maxN1 = 5
        maxN2 = 30
      when 2
        maxN1 = 9
        maxN2 = 100
      else
        maxN1 = 20
        maxN2 = 400
    [a, n] = rnd.ints2Plus maxN1
    b = rnd.int2Plus maxN2
    #return
    problem : "#{a}/#{b}"
    problemTeX : "\\frac{#{a*n}}{#{b}} : #{n}"
    description : "Teile den Bruch durch die natürliche Zahl."
    hint: "#{a*n} Äpfel durch #{n} sind..."

  bruchDurchZahl2 : (level = 1) ->
    switch level
      when 1
        maxP = 17
        maxN = 15
        maxE = 1
      when 2
        maxP = 11
        maxN = 20
        maxE = 2
      else
        maxP = 13
        maxN = 25
        maxE = 2
    console.log rnd.uniquePrimes 10
    [a1, a2, c1, c2] = rnd.uniquePrimes maxP
    [ae1, ae2] = rnd.uniqueInts maxE
    [ce1, ce2] = rnd.uniqueInts maxE
    [a1, a2, c1, c2] = [a1**ae1, a2**ae2, c1**ce1, c2**ce2]
    b = rnd.int2Plus maxN
    #return
    problem : "(#{a1*a2}/#{b}) / #{c1 * c2}"
    problemTeX : "\\frac{#{a1*a2}}{#{b}} : #{c1 * c2}"
    description : "Teile den Bruch durch die Natürliche Zahl."
    hint: "Wenn Du den Zähler nicht durch die Zahl teilen \
      kannst, multiplizierst Du stattdessen den Nenner mit \
      dieser Zahl."

  bruchDurchBruch : (level = 1) ->
    maxN = switch level
      when 1 then 9
      when 2 then 20
      else 40
    [a, b, c, d] = rnd.uniqueInts2Plus(maxN)
    #return
    problem : "(#{a}/#{b}) / (#{c}/#{d})"
    problemTeX : "\\frac{#{a}}{#{b}} : \\frac{#{c}}{#{d}}"
    form : re.fraction
    description : "Löse die Bruchrechenaufgabe:"
    hint : "Multipliziere mit dem Kehrwert."
