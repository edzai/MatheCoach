<template lang="jade">
.content-box
  h1.heading Lass dich kostenlos als Benutzer registrieren
  p.text MatheCoach kann die Ergebnisse deiner Arbeit für dich abspeichern. So kannst Du jederzeit sehen, was Du geleistet hast.
  p.text Dazu musst du dich nur
    router-link(v-bind:to="{name : 'loginPage'}").link  als Benutzer registrieren
    span . Wenn Du bereits auf einem anderen Gerät als Benutzer für MatheCoach registriert bist, kannst Du dich mit dem gleichen Benutzernamen und Passwort auch hier wieder
    router-link(v-bind:to="{name : 'loginPage', params : {signingIn : true}}").link  einloggen
    span .
  a.link(href="")
</template>

<script lang="coffee">
return
  data : -> {}
</script>

<style scoped lang="sass">
</style>
