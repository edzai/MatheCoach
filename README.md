# MatheCoach

## Eine Web-app zum Matheüben

MatheCoach ist eine Webseite, die dabei hilft, die wichtigsten Arbeitsschritte in der Mathematik zu trainieren und zu wiederholen.

MatheCoch befindet sich in der Entwicklung und ist noch weit davon entfernt, fertig zu sein. Über Anregungen und Fehlermeldungen würde ich mich sehr freuen.

Die Web-app kann unter http://mathe-coach-janmp.herokuapp.com getestet werden.

## Aufgabengeneratoren
MatheCoach enthält nicht einfach eine Sammlung von Aufgaben, sondern generiert die Aufgaben selbst. Für jeden Aufgabentyp gibt es eigene Aufgabengeneratoren. Das sind Java-Script (bzw. Coffee-Script) funktionen, welche die Aufgaben aus Zufallsdaten zusammensetzen.

Die Aufgabengeneratoren und Moduldefinitionen finden sich im Unterverzeichnis /imports/client/mathproblems/problemGenerators

Ein einfaches Beispiel in Coffee-Script:

```
grundrechenarten = (level) ->
  [a, b] = rnd.ints()
  op = switch level
    when 1 then "+"
    when 2 then "-"
    when 3 then "*"
    else "/"
  #returns
  problem : "#{a}#{op}#{b}"
  description : "Dieser Text kommt vor dem Mathematischen Ausdruck der Aufgabe"
  hint : "Dieser Text kommt nach der Aufgabe"
```

Der Parameter `level` der Funktion bestimmt den Schwierigkeitsgrad. `level`ist eine Natürliche Zahl. Die Funktion gibt ein Javascriptobjekt zurück. In unserem Beispiel werden zwei Zafallszahlen `a` und `b` generiert und je nach Schwierigkeitsgrad mit `+`, `-`, `*` oder `/` verknüpft.

Das Erzeugte Objekt kann folgende Elemente enthalten:

#### problem : String
String mit dem Mathematischen Ausdruck der Aufgabe. Das Herzstück fast aller Aufgaben, das Benutzt wird, um die meisten anderen Elemente automatisch zu generieren, wenn diese nicht definiert wurden. Wenn `problemTeX` und `solution` definiert sind, kann `problem` einen bedeutungslosen Platzhalter Text (z.B. "nicht Verwendet") enthalten, sollte aber immer definiert werden.

#### problemTeX : String
Der Mathematische Ausdruck der Aufgabe im LaTeX Format. Dieses Format wird benutzt, um die Darstellung Mathematischer Terme mit Brüchen etc. zu ermöglichen. Wenn `problemTeX` nicht definiert wird, wird es aus `problem`generiert.

#### description : String
Der Text, der vor dem Mathematischen Ausdruck der Aufgabe erscheint. Sollte immer definiert werden.

#### hint : String
Optionaler Text nach dem Mathematischen Ausdruck der Aufgabe.

#### solution : String
Die Lösung der Aufgabe. Optional. Wenn `solution` nicht definiert ist, wird die Lösung automatisch aus `problem` generiert mit:
```
nerdamer(problem).text("fractions")
```
`solution` wird bei der Auswertung des Ergebnisses des Schülers benötigt.

#### solutionTeX : String
Die Lösung der Aufgabe im LaTeX Format. Optional. Wird aus `solution` generiert.

#### checks : [->]
Ein Array von Funktionen, die das Ergebnis auf Richtigkeit überprüfen und entweder das Ergebnis als Falsch bewerten oder auch nur Warnhinweise liefern. Wenn `checks` nicht definiert wird, wird auf Equivalenz des Ergebnisses mit `problem` getestet und ein Warnhinweise für nicht vollständig gekürzte Brüche gegeben:
```
[Check.equivalent, Check.noReducableFractionsOptional]
```

Die Checkfunktionen sind in /imports/client/mathproblems/checks.coffee definiert.

#### customTemplateName : String
Optional. Wenn definiert, dann wird anstelle des mathematischen Ausdrucks aus  `problemTeX` das entsprechende Blaze-Template, dargestellt.

#### customTemplateData : Object
Der Datenkontext für das Blaze-Template `customTemplateName` 

#### answerPreprocessor : ->
Eine Funktion, die die Zeichenkette mit dem Ergebnis des Schülers bearbeitet, ehe sie checks durchläuft. Optional. Wenn nicht definiert, wird eine Funktion aufgerufen, die "abc" in "a * b * c" verwandelt, aber einige Ausdrücke wie "sin", "cos", "sqrt", "alpha", "beta" etc. erhält (die Liste mit Wörtern, die erhalten bleiben muss noch deutlich ausgebaut werden).


## Module
Aufgabengeneratoren werden in Modulen zusammengefasst. Ein Modul ist ein einfaches Java-Script Objekt. Beispiel in Coffee-Script:
```
beispielModul =
  title : "Das ist der Titel des Moduls"
  description : "Eine kurze Beschreibung, die nach dem Titel kommt"
  problems : [
    levels : [1..4]
    generator : grundrechenarten #unsere Generatorfunktion von oben
  ,
    levels : [3..5]
    levelOffset : -2
    generator : einAndererGenerator
  ]
```

Dieses Beispielmodul enthält Aufgaben mit den Schwierigkeitsgraden 1 bis 5 (Achtung: es sollte keine Lücken geben). Bei Level 1 bis 2 kommen nur Aufgaben von unserem Beispielgenerator von oben. Auf Level 3 und 4 kommen Aufgaben von beiden Generatoren (der effektive Level von `einAndererGenerator` wird dabei um 2 vermindert). Und auf Level 5 stehen nur noch aufgaben von `einAndererGenerator` zur Verfügung.

Aufgabengeneratoren können natürlich mehrfach in unterschiedlichen Modulen kombiniert werden.

## Framework/Funktionsbibliotheken

MatheCoach basiert auf Meteor. Das Front-End ist Blaze (Bestandteil von Meteor) mit Viewmodel. Anstelle von Java-Script und Html verwenden wir Coffee-Script und Jade/Pug.

  * Meteor https://www.meteor.com
  * Viewmodel https://viewmodel.org
  * Coffee-Script http://coffeescript.org
  * Jade/Pug https://pugjs.org/api/getting-started.html (Jade für Meteor/Blaze weicht in einigen Punkten von Pug ab)

MatheCoach nutzt u.A. folgende Funktionsbibliotheken:

  * Nerdamer https://github.com/jiggzson/nerdamer
  * Math.js http://mathjs.org/index.html
  * Chartist.js https://gionkunz.github.io/chartist-js/
  * lodash https://lodash.com


Copyright (c) 2016, Jan Pilgenröder
