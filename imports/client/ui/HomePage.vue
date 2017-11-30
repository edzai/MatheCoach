<template lang="jade">
.content-box
  h1.heading MatheCoach
  h2.heading.sub 30. November 2017
  h1.heading.small Keine Panik. Es sieht zwar alles anders aus, aber ihr könnt euch immer noch mit eurem alten Account einloggen.
  p.text Ich habe begonnen, eine iPhone/Android app für MatheCoach zu entwickeln. Bei dieser Mobilapp musste ich eine andere Javascriptbibliothek für die Programmierung der Benutzeroberfläche verwenden (Vue.js) und es hat sich gezeigt, dass diese Bibliothek gegenüber der alten einige Vorteile bietet. Der Programmcode ist besser strukturiert, übersichtlicher und lässt sich langfristig besser warten.
  p.text Ich habe daher im Lauf der letzten 2-3 Wochen die Benutzeroberfläche der Web-Version komplett neu geschrieben. Das hat u.A. auch den Vorteil, dass ich mehr Programmcode sowohl in der Webapp als auch in den Handyapps wiederverwenden kann und nicht alles doppelt programmieren muss.
  p.text Die Webapp ist dadurch ausserdem etwas schlanker geworden.
  p.text Den Lehrer/Schüler Chat habe ich gestrichen.
  p.text Das Bildschirmeingabefeld für Mobilgeräte entfällt (das ist in der Handyapp wesentlich schöner und besser zu bedienen).
  p.text Die Punkte für die Aufgaben werden (momentan) nicht angezeigt. Sie werden aber weiterhin in der Datenbank abgespeichert wenn ihr Aufgaben richtig löst.
  p.text Soundeffekte habe ich auch noch nicht wieder eingebaut.
  p.text Für die Darstellung Mathematischer Formeln wird jetzt ausschließlich KaTeX verwendet. Die technischen Probleme mit den Mathematischen Formeln waren einer der Gründe dafür, dass ich mir die Arbeit mit der neuen Version gemacht habe.
  p.text Die Grafiken für die Benutzerstatistiken und die Funktionsgrafen kommen jetzt ohne zusätzliche Funktionsbibliotheken aus und sollten auf Mobilgeräten wesentlich besser aussehen (Die Funktionsgrafen waren vorher echt hässlich und auch nicht sonderlich gut abzulesen). Gerade bei den Grafiken zur Benutzerstatistik ist aber noch eine Menge Arbeit nötig (die hat noch nicht mal eine Beschriftung).
  p.text Jeder Benutzer hat jetzt automatisch ein Avatarbild. Wenn Ihr ein eigenes Bild verwenden wollt, dann tragt euch mit eurer Email bei Gravatar.com ein. Dort könnt ihr dann einen eigen Avatar hochladen.
  p.text Die Benutzeroberfläche und die Aufgabengeneratoren sind jetzt für unterschiedliche Sprachversionen vorbereitet. Man kann jetzt schon zwischen Deutsch und English umschalten und weitere Sprachversionen lassen sich recht einfach einbauen.
  p.text Ich habe die Synchronisation der Datenbank mit der Webapp anders Organisiert. Die Daten werden jetzt erst ausgetauscht, wenn sie tatsächlich benötigt werden. Besonders für fleißige Rechner und deren Lehrer sollten  die Wartezeiten beim Programmstart nun etwas kürzer ausfallen.
  p.text Eine Vorschau auf die iPhone/Android App könnt ihr voraussichtlich ab nächster Woche sehen.
  p.text Ich bitte weiterhin um Anregungen. Bitte meldet euch so schnell wie möglich, wenn ihr einen Fehler entdeckt.
</template>

<script lang="coffee">
return
  data : -> {}
</script>

<style scoped lang="sass">
p
  margin-top: 8px
</style>
