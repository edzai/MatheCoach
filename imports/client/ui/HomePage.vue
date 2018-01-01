<template lang="jade">
.content-box.large
  h1.heading Chatroom auf Gitter
  h2.heading.sub 2. Dezember 2017
  p.text Ich habe einen Chatroom für Mathecoach auf gitter.im eingerichtet (Gitter bietet Chatrooms/Foren mit Zusatzfeatures speziell für die Kommunikation mit Programmierern). Wenn Ihr Fehler findet oder Fragen habt oder Ideen oder Wünsche loswerden wollt, dann könnt ihr das hier: <a class="link" href="https://gitter.im/MatheCoach/Lobby?utm_source=share-link&utm_medium=link&utm_campaign=share-link"> gitter.im/MatheCoach</a>
  h1.heading.old-news MatheCoach Version 2
  h2.heading.sub 30. November 2017
  h1.heading.small Keine Panik. Es sieht zwar alles anders aus, aber ihr könnt euch immer noch mit eurem alten Account einloggen.
  p.text Ich habe begonnen, eine iPhone/Android app für MatheCoach zu entwickeln. Bei dieser Mobilapp musste ich eine andere Javascriptbibliothek für die Programmierung der Benutzeroberfläche verwenden (Vue.js) und es hat sich gezeigt, dass diese Bibliothek gegenüber der Alten einige Vorteile bietet. Der Programmcode ist besser strukturiert, übersichtlicher und lässt sich langfristig wesentlich besser warten.
  p.text Ich habe daher im Lauf der letzten 2-3 Wochen die Benutzeroberfläche der Web-Version komplett neu geschrieben. Das hat u.A. auch den Vorteil, dass ich mehr Programmcode sowohl in der Webapp als auch in den Handyapps wiederverwenden kann und nicht alles doppelt programmieren muss. Das Programm ist dadurch ausserdem etwas schlanker geworden.
  ul
    li.text Den Lehrer/Schüler Chat habe ich gestrichen.
    li.text Das Bildschirmeingabefeld für Mobilgeräte entfällt (das ist in der Handyapp wesentlich schöner und besser zu bedienen).
    li.text Die Punkte für die Aufgaben werden (momentan) nicht angezeigt. Sie werden aber weiterhin in der Datenbank abgespeichert wenn ihr Aufgaben richtig löst.
    li.text Soundeffekte habe ich auch noch nicht wieder eingebaut. Ich bin immer noch auf der Suche nach passenden Sounddateien.
    li.text Für die Darstellung Mathematischer Formeln wird jetzt ausschließlich KaTeX verwendet. Technische Probleme mit den Mathematischen Formeln waren einer der Gründe dafür, dass ich mir die Arbeit mit der neuen Version gemacht habe.
    li.text Die Grafiken für die Benutzerstatistiken und die Funktionsgrafen kommen jetzt ohne zusätzliche Funktionsbibliotheken aus und sollten auf Mobilgeräten wesentlich besser aussehen (Die Funktionsgrafen waren vorher echt hässlich und auch nicht sonderlich gut abzulesen).
    li.text Jeder Benutzer hat jetzt automatisch ein Avatarbild. Wenn Ihr ein eigenes Bild verwenden wollt, dann tragt euch mit eurer Email bei Gravatar.com ein. Dort könnt ihr dann einen eigen Avatar hochladen.
    li.text Die Benutzeroberfläche und die Aufgabengeneratoren sind jetzt für unterschiedliche Sprachversionen vorbereitet. Man kann jetzt schon zwischen Deutsch und English umschalten und weitere Sprachversionen lassen sich recht einfach einbauen.
    li.text Ich habe die Synchronisation der Datenbank mit der Webapp anders Organisiert. Die Daten werden jetzt erst ausgetauscht, wenn sie tatsächlich benötigt werden. Besonders für fleißige Rechner und deren Lehrer sollten  die Wartezeiten beim Programmstart nun etwas kürzer ausfallen.
  p.text Ich bitte weiterhin um Anregungen. Bitte meldet euch so schnell wie möglich, wenn ihr einen Fehler entdeckt.
</template>

<script lang="coffee">
return
  data : -> {}
</script>

<style scoped lang="sass">
.old-news
  margin-top: 16px
.text
  font-size: 120%
.heading
  font-size: 150%
.sub
  font-size: 130%
.small
  font-size: 120%
p
  margin-top: 8px
ul
  list-style: circle outside none !important
  margin: 10px 30px 0px 30px
li
  margin-bottom: 4px
</style>
