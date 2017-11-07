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
  kuerzen : (level = 1, language="de") ->
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
    description : switch language
      when "de" then "Kürze den Bruch soweit wie möglich:"
      else "Reduce the fraction:"

  erweitern : (level = 1, language="de") ->
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
    description : switch language
      when "de" then "Erweitere den Bruch mit der Zahl #{c}."
      else "Expand the Fraction by #{c}."
  erweitern2 : (level = 1, language="de") ->
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
    description : switch language
      when "de" then "Gibt die fehlende Zahl an."
      else "What is the missing value?"

  strichGleichnamig : (level = 1, language="de") ->
    [a, b, c] = if level is 1
      rnd.ints2Plus(9)
    else
      rnd.ints2Plus(20)
    op = rnd.opStrich()
    if op is "+"
      opStr = switch language
        when "de" then "Addiere"
        else "Add"
    else
      opStr = switch language
        when "de" then "Subtrahiere"
        else "Subtract"
      if b > a then [a, b] = [b, a]
    #return:
    problem : "#{a}/#{c} #{op} (#{b}/#{c})"
    checks : if level > 1 then mustReduce else defaultFractionChecks
    description : switch language
      when "de" then "#{opStr} die Brüche:"
      else "#{opStr} the fractions:"
    hint : switch language
      when "de" then "Die Brüche sind schon gleichnamig."
      else "The denominators already are the same."

  strichUngleichnamig : (level = 1, language="de") ->
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
      switch language
        when "de"
          opStr = "Addiere"
          opStr2 = "addierst"
        else
          opStr = "Add"
          opStr2 = "add"
    else
      switch language
        when "de"
          opStr = "Subtrahiere"
          opStr2 = "subtrahierts"
        else
          opStr = "Subtract"
          opStr2 = "subtract"
      if a/c < b/c
        [a, b, c, d] = [b, a, d, c]
    #return:
    problem : "#{a}/#{c} #{op} (#{b}/#{d})"
    checks : if level > 1 then mustReduce else defaultFractionChecks
    description : switch language
      when "de" then "#{opStr} die Brüche:"
      else "#{{opStr}} the Fractions:"
    hint : switch language
      when "de" then "Mache die Brüche gleichnamig ehe du sie #{opStr2}."
      else "Find the common denominator before you #{opStr2} them."

  malGanzeZahl : (level = 1, language="de") ->
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
    description : switch language
      when "de" then "Multipliziere den Bruch mit der Zahl:"
      else "Multiply the fraction with the integer:"

  malBruch : (level = 1, language="de") ->
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
    description : switch language
      when "de" then "Multipliziere die Brüche:"
      else "Multiply the Fractions:"

  malBruchKuerzbar : (level = 1, language="de") ->
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
    description : switch language
      when "de" then "Multipliziere die Brüche:"
      else "Multiply the Fractions"
    hint :
      switch language
        when "de"
          "Du kannst auf jeden Fall mindestens einen der beiden Brüche \
          kürzen ehe Du die Brüche multiplizierst."
        else
          "You can reduce at least one of the fractions before you multiply."

  malKreuzKuerzbar : (level = 1, language="de") ->
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
    description : switch language
      when "de" then "Multipliziere die Brüche:"
      else "Multiply the fractions:"
    hint :
      switch language
        when "de"
          "Du kannst auf jeden Fall mindestens einmal überkreuz \
          kürzen ehe Du die Brüche multiplizierst. Überkreuz kürzen \
          geht nur bei Mal. Nicht bei Plus oder Minus!"
        else "You can reduce the Fractions crosswise at least once. \
          You can only reduce crosswise with products of fractions. \
          This does NOT work for sums or differences!"

  zusammenGesetzt : (level = 1, language="de") ->
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
    switch language
      when "de"
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
      else
        switch op1
          when "+"
            opStr1 = "a sum"
            opStr2 = "add"
          when "-"
            opStr1 = "a difference"
            opStr2 = "subtract"
          when "*"
            opStr1 = "a product"
            opStr2 = "multiply"
          when "/"
            opStr1 = "a quotient"
            opStr2 = "divide"
        opStr3 = switch op2
          when "+" then "the sum"
          when "-" then "the difference"
          when "*" then "the product"
    #return
    problem :
      if head
        "(#{a}/#{b}) #{op1} ((#{c}/#{d}) #{op2} (#{e}/#{f}))"
      else
        "((#{a}/#{b}) #{op2} (#{c}/#{d})) #{op1} (#{e}/#{f})"
    checks : if level > 1 then mustReduce else defaultFractionChecks
    description : switch language
      when "de" then "Löse die Bruchrechenaufgabe:"
      else "Solve the fractions problem:"
    hint :
      switch language
        when "de"
          "Nebenbei: Der Term ist #{opStr1}, weil man einen Bruch \
          und #{opStr3} von zwei Brüchen #{opStr2}."
        else
          "By the way: The expression is a #{opStr1} because you #{opStr2} \
          a fraction and the #{opStr3} of two fractions."

  bruchDurchZahl : (level = 1, language="de") ->
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
    description : switch language
      when "de" then "Teile den Bruch durch die Natürliche Zahl."
      else "Divide the fraction by the natural number"
    hint: switch language
      when "de" then "#{a*n} Äpfel durch #{n} sind..."
      else "#{a*n} apples divided by #{n} are..."

  bruchDurchZahl2 : (level = 1, language="de") ->
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
    description : switch language
      when "de" then "Teile den Bruch durch die Natürliche Zahl."
      else "Divide the fraction by the natural number"
    hint: switch language
      when "de"
        "Wenn Du den Zähler nicht durch die Zahl teilen \
        kannst, multiplizierst Du stattdessen den Nenner mit \
        dieser Zahl."
      else
        "If you cant divide the enumerator by the number then multiply the \
        denominator instead."

  bruchDurchBruch : (level = 1, language="de") ->
    maxN = switch level
      when 1 then 9
      when 2 then 20
      else 40
    [a, b, c, d] = rnd.uniqueInts2Plus(maxN)
    #return
    problem : "(#{a}/#{b}) / (#{c}/#{d})"
    problemTeX : "\\frac{#{a}}{#{b}} : \\frac{#{c}}{#{d}}"
    checks : if level > 1 then mustReduce else defaultFractionChecks
    description : switch language
      when "de" then "Dividiere die Brüche:"
      else "Do the division:"
    hint : switch language
      when "de" then "Multipliziere mit dem Kehrwert."
      else "Multiply with the reciprocal."

exports.fractions =
  bruch0 :
    title :
      de : "Bruchrechnen 0"
      en : "Fractions 0"
    description :
      de : "Kürzen und Erweitern von Brüchen"
      en : "Reducing and expanding Fractions"
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
    title :
      de : "Bruchrechnen 1"
      en : "Fractions 1"
    description :
      de : "Addition und Subtraktion von Brüchen"
      en : "Sums and Differences of Fractions"
    problems : [
      levels : [1..2]
      generator : fractionGenerator.strichGleichnamig
    ,
      levels : [2..3]
      levelOffset : -1
      generator : fractionGenerator.strichUngleichnamig
    ]
  bruch2 :
    title :
      de : "Bruchrechnen 2"
      en : "Fractions 2"
    description :
      de : "Multiplikation von Brüchen"
      en : "Multiplying Fractions"
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
    title :
      de : "Bruchrechnen 3"
      en : "Fractions 3"
    description :
      de : "Division mit Brüchen"
      en : "Dividing Fractions"
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
    title :
      de : "Bruchrechnen"
      en : "Fractions"
    description :
      de : "Vermischte Aufgaben zur Bruchrechnung"
      en : "Putting it all together."
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
