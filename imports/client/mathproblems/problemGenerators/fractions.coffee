{ Rnd } = require "../randomGenerators.coffee"
rnd = new Rnd()

{ Check } = require "../checks.coffee"

nerdamer = require "/imports/modules/nerdamer/nerdamer.core.js"
require "/imports/modules/nerdamer/Solve.js"

defaultFractionChecks = [
  Check.equivalent
  Check.isSingleFraction
  Check.noReducableFractionsOptional
]

mustReduce = [
  Check.equivalent
  Check.isSingleFraction
  Check.noReducableFractionsRequired
]

exactFit = [
  Check.equivalent
  Check.exactFit
]

exports.fractionGenerator = fractionGenerator =
  kuerzen : (level = 1) ->
    switch level
      when 1
        maxAB = 9
        maxC = 9
      when 2
        maxAB = 20
        maxC = 9
      else
        maxAB = 20
        maxC = 20
    [a, b] = rnd.uniqueInts2Plus maxAB
    c = rnd.int maxC
    #return
    problem : "#{a*c}/#{b*c}"
    checks : mustReduce
    description : "Kürze den Bruch soweit wie möglich."

  erweitern : (level = 1) ->
    switch level
      when 1
        maxAB = 9
        maxC = 9
      when 2
        maxAB = 20
        maxC = 9
      else
        maxAB = 20
        maxC = 20
    [a, b] = rnd.uniqueInts2Plus maxAB
    c = rnd.int2Plus maxC
    #return
    problem : "#{a}/#{b}"
    checks : exactFit
    solution : "#{a*c}/#{b*c}"
    description : "Erweitere den Bruch mit der Zahl #{c}."

  erweitern2 : (level = 1) ->
    switch level
      when 1
        maxAB = 9
        maxN = 9
      when 2
        maxAB = 20
        maxN = 9
      else
        maxAB = 20
        maxN = 20
    [a, b] = rnd.uniqueInts2Plus maxAB
    n = rnd.int2Plus maxN
    c = a * n
    solution = b * n
    d = "\\square"
    [bool1, bool2] = rnd.bools()
    if bool1 then [a, b, c, d] = [c, d, a, b]
    if bool2 then [a, b, c, d] = [b, a, d, c]
    #return
    problem : "not used"
    problemTeX : "\\frac{#{a}}{#{b}}=\\frac{#{c}}{#{d}}"
    solution : "#{solution}"
    description : "Gibt die fehlende Zahl an."

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
    checks : if level > 1 then mustReduce else defaultFractionChecks
    description : "#{opStr} die Brüche:"
    hint : "Die Brüche sind schon gleichnamig."

  strichUngleichnamig : (level = 1) ->
    switch level
      when 1
        [a, b, c, d] = rnd.uniqueInts2Plus 9
      when 2
        [a, b] = rnd.uniqueIntsPlus 15
        [c, d] = rnd.uniqueInts2Plus 9
      else
        [a, b] = rnd.uniqueIntsPlus 20
        [c, d] = rnd.uniqueInts2Plus 20
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
    checks : if level > 1 then mustReduce else defaultFractionChecks
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
    checks : if level > 1 then mustReduce else defaultFractionChecks
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
    checks : if level > 1 then mustReduce else defaultFractionChecks
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
          maxN1 = 9
          maxN2 = 20
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
    checks : mustReduce
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
    checks : mustReduce
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
    checks : if level > 1 then mustReduce else defaultFractionChecks
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
    checks : if level > 1 then mustReduce else defaultFractionChecks
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
    [a1, a2, c1, c2] = rnd.uniquePrimes maxP
    [ae1, ae2] = rnd.uniqueInts maxE
    [ce1, ce2] = rnd.uniqueInts maxE
    [a1, a2, c1, c2] = [a1**ae1, a2**ae2, c1**ce1, c2**ce2]
    b = rnd.int2Plus maxN
    #return
    problem : "(#{a1*a2}/#{b}) / #{c1 * c2}"
    problemTeX : "\\frac{#{a1*a2}}{#{b}} : #{c1 * c2}"
    checks : if level > 1 then mustReduce else defaultFractionChecks
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
    checks : if level > 1 then mustReduce else defaultFractionChecks
    description : "Löse die Bruchrechenaufgabe:"
    hint : "Multipliziere mit dem Kehrwert."

exports.fractions =
  bruch0 :
    title : "Bruchrechnen 0"
    description : "Kürzen und Erweitern von Brüchen"
    problems : [
      levels : [1..4]
      generator : fractionGenerator.kuerzen
    ,
      levels : [1..4]
      generator : fractionGenerator.erweitern
    ,
      levels : [2..4]
      levelOffset : -1
      generator : fractionGenerator.erweitern2
    ]
  bruch1 :
    title : "Bruchrechnen 1"
    description : "Addition und Subtraktion von Brüchen"
    problems : [
      levels : [1..2]
      generator : fractionGenerator.strichGleichnamig
    ,
      levels : [2..3]
      levelOffset : -1
      generator : fractionGenerator.strichUngleichnamig
    ]
  bruch2 :
    title : "Bruchrechnen 2"
    description : "Multiplikation von Brüchen"
    problems : [
      levels : [1]
      generator : fractionGenerator.malGanzeZahl
    ,
      levels : [1..3]
      generator : fractionGenerator.malBruchKuerzbar
    ,
      levels : [2..3]
      levelOffset : -1
      generator : fractionGenerator.malKreuzKuerzbar
    ]
  bruch3 :
    title : "Bruchrechnen 3"
    description : "Division mit Brüchen"
    problems : [
      levels : [1..2]
      generator : fractionGenerator.bruchDurchZahl
    ,
      levels : [2..3]
      levelOffset : -1
      generator : fractionGenerator.bruchDurchZahl2
    ,
      levels : [2..4]
      levelOffset : -1
      generator : fractionGenerator.bruchDurchBruch
  ]
  bruch4 :
    title : "Bruchrechnen"
    description : "Vermischte Aufgaben zur Bruchrechnung"
    problems : [
      levels : [1..2]
      generator : fractionGenerator.strichGleichnamig
    ,
      levels : [1..3]
      generator : fractionGenerator.strichUngleichnamig
    ,
      levels : [1..2]
      generator : fractionGenerator.malGanzeZahl
    ,
      levels : [1..3]
      generator : fractionGenerator.malBruch
    ,
      levels : [2..4]
      levelOffset : -1
      generator : fractionGenerator.bruchDurchBruch
    ,
      levels : [4..5]
      levelOffset : -3
      generator : fractionGenerator.zusammenGesetzt
    ]
