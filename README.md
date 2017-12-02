# MatheCoach

[![Join the chat at https://gitter.im/MatheCoach/Lobby](https://badges.gitter.im/MatheCoach/Lobby.svg)](https://gitter.im/MatheCoach/Lobby?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

## Eine Web-app zum Matheüben

MatheCoach ist eine Webseite, die dabei hilft, die wichtigsten Arbeitsschritte in der Mathematik zu trainieren und zu wiederholen.

MatheCoach befindet sich in der Entwicklung und ist noch weit davon entfernt, fertig zu sein. Über Anregungen und Fehlermeldungen würde ich mich sehr freuen.

Die Web-app kann unter http://mathe-coach-janmp.herokuapp.com getestet werden.

## Aufgabengeneratoren
MatheCoach enthält nicht einfach eine Sammlung von Aufgaben, sondern generiert die Aufgaben selbst. Für jeden Aufgabentyp gibt es eigene Aufgabengeneratoren. Das sind Java-Script (bzw. CoffeeScript) Funktionen, welche die Aufgaben aus Zufallsdaten zusammensetzen.

Die Aufgabengeneratoren und Moduldefinitionen finden sich im Unterverzeichnis /imports/client/mathproblems/problemGenerators

Ein einfaches Beispiel in CoffeeScript:

```
grundrechenarten = (level, language) ->
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

Der Parameter `level` der Funktion bestimmt den Schwierigkeitsgrad. `level` ist eine Natürliche Zahl. Die Funktion gibt ein Javascriptobjekt zurück. In unserem Beispiel werden zwei Zufallszahlen `a` und `b` generiert und je nach Schwierigkeitsgrad mit `+`, `-`, `*` oder `/` verknüpft.

Der Zweite Parameter `language : String` enthält den Sprachcode nach ISO 639-1 und kann benutzt werden um die Aufgabe in unterschiedlichen Sprachen auszugeben. Bisher sind alle Aufgabengeneratoren lediglich einsprachig. Eine mehrsprachige Version unseres einfachen Beispiels könnte so aussehen:

```
grundrechenarten = (level, language) ->
  [a, b] = rnd.ints()
  op = switch level
    when 1 then "+"
    when 2 then "-"
    when 3 then "*"
    else "/"
  #returns
  problem : "#{a}#{op}#{b}"
  description : switch language
    when "de"
      "Dieser Text kommt vor dem Mathematischen Ausdruck der Aufgabe"
    when "fr"
      "Ce texte vient avant l'expression mathématique de la tâche"
    else
      "This text is displayed above the mathematical expression of the problem"
  hint : switch language
    when "de"
      "Dieser Text kommt nach der Aufgabe"
    when "fr"
      "Ce texte vient après la tâche"
    else
      "This text is diplayed at the end of the problem"
```
Das Erzeugte Objekt kann folgende Elemente enthalten:

#### problem : String
String mit dem Mathematischen Ausdruck der Aufgabe. Das Herzstück fast aller Aufgaben, das Benutzt wird, um die meisten anderen Elemente automatisch zu generieren, wenn diese nicht definiert wurden. Wenn `problemTeX` und `solution` definiert sind, kann `problem` einen bedeutungslosen Platzhalter Text (z.B. "nicht Verwendet") enthalten, sollte aber immer definiert werden.

#### problemTeX : String
Der Mathematische Ausdruck der Aufgabe im LaTeX Format. Dieses Format wird benutzt, um die Darstellung Mathematischer Terme mit Brüchen etc. zu ermöglichen. Wenn `problemTeX` nicht definiert wird, wird es aus `problem` generiert.

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

#### score : Number
Der Punktwert für die richtig gelöste Aufgabe. Optional. Wenn `score` nicht definiert ist, wird der Wert 1 verwendet.

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

#### answerPreprocessor : (String) -> String
Eine Funktion, die die Zeichenkette mit dem Ergebnis des Schülers bearbeitet, ehe sie Checks durchläuft. Optional. Wenn nicht definiert, wird eine Funktion aufgerufen, die "abc" in "a * b * c" verwandelt, aber einige Ausdrücke wie "sin", "cos", "sqrt", "alpha", "beta" etc. erhält (die Liste mit Wörtern, die erhalten bleiben muss noch deutlich ausgebaut werden).

#### laTeXPostProcessor : (String) -> String
Eine Funktion, die auf problemTeX und solutionTeX angewendet wird (nachdem eventuell die Defaultwerte eingesetzt werden). Optional. Wenn nicht definiert, wird eine Funktion aufgerufen, die "\cdot" zwischen Ziffern und Nicht-Ziffern entfernt.

#### geometryDrawData : [Object]
Optional. Ein Array mit Objekten, die eine geometrische Skizze beschreiben.

#### functionPlotData : Object
Optional. Ein Objekt, das die Beschreibung eines Funktionsgrafen enthält.

#### skipExpression : Boolean
Optional. Wenn True wird problemTeX nicht angezeigt.

#### textBook : String
Optional. Enthält HTML mit beliebigen zusätzlichen Informationen zur Aufgabe.

## Module
Aufgabengeneratoren werden in Modulen zusammengefasst. Ein Modul ist ein einfaches Java-Script Objekt. Beispiel in CoffeeScript:
```
beispielModul =
  title :
    de : "Das ist der Titel des Moduls"
    en : "This is the module title"
  description :
    de : "Eine kurze Beschreibung, die nach dem Titel kommt"
    en : "A short description following the module title"
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

MatheCoach basiert auf Meteor. Das Front-End ist Blaze (Bestandteil von Meteor) mit Viewmodel. Anstelle von Java-Script und Html verwenden wir CoffeeScript und Jade/Pug.

  * Meteor https://www.meteor.com
  * Viewmodel https://viewmodel.org
  * CoffeeScript http://coffeescript.org
  * Jade/Pug https://pugjs.org/api/getting-started.html (Jade für Meteor/Blaze weicht in einigen Punkten von Pug ab)

MatheCoach nutzt u.A. folgende Funktionsbibliotheken:

  * Nerdamer https://github.com/jiggzson/nerdamer
  * Math.js http://mathjs.org/index.html
  * Chartist.js https://gionkunz.github.io/chartist-js/
  * lodash https://lodash.com

## Benötigte Software

Zur Entwicklung weiterer Aufgabengeneratoren benötigt man folgende Softwarepakete:

  * Nodejs https://nodejs.org/en/
  * Meteor https://www.meteor.com
  * git oder GitHub Desktop https://desktop.github.com
  * Einen Programmcode Editor wie z.B. Atom https://atom.io

Java-Script wurde ursprünglich als Scriptsprache für Web-Browser entwickelt. Mit Nodejs wird Java-Script auch für die Programmierung des Web-Servers verfügbar. Meteor setzt auf Nodejs auf und ist die Entwicklungsumgebung für MatheCoach. Meteor führt die Programmierung von Web-Browser, Web-Server und Datenbank zusammen. Mithilfe von GitHub wird der Programmcode von MatheCoach verwaltet.

Um mit der Entwicklung von Aufgabengeneratoren beginnen zu können, sollte man sich soweit in Meteor und GitHub eingearbeitet haben, dass man in der Lage ist ein Meteorprojekt von GitHub auf dem eigenen Rechner zu starten, im Texteditor Änderungen vorzunehmen und einen Pullrequest abzuschicken (damit die Änderungen in den Programmcode auf GitHub übernommen werden können).

Es ist nicht notwendig, sich mit der Server-, Datenbank- oder Web-Programmierung unter Meteor auseinanderzusetzen, um Aufgabengeneratoren zu Programmieren. Grundlegende Programmierkentnisse sollten ausreichen, um sich schnell soweit in CoffeeScript einzuarbeiten, dass man mit der Programmierung einfacher Generatoren beginnen kann. Brauchbare Einführungen in CoffeeScript finden sich unter http://coffeescript.org/

Copyright (c) 2016, Jan Pilgenröder
