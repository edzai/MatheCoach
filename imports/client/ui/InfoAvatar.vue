<template lang="jade">
gravatar.gravatar.glow(
  v-bind:email="user.emails[0].address"
  v-bind:size="size"
  default-img="wavatar"
  v-bind:class="[glowClass]"
)
</template>

<script lang="coffee">
import Gravatar from "vue-gravatar"
return
  computed :
    lastActive : ->
      if @user.lastActive
        moment @user.lastActive
    glowClass : ->
      if @showActivity
        if @user.lastActive
          now = moment()
          lastActive = moment @user.lastActive
          switch
            when lastActive.isAfter now.subtract(moment.duration 2, "d")
              "success"
            when lastActive.isAfter now.subtract(moment.duration 7, "d")
              "warning"
            else "error"
        else
          "grey"

  props :
    user :
      type : Object
      required : true
    size :
      type : Number
      default : 36
    showActivity :
      type : Boolean
      default : true
  components : { Gravatar }
</script>

<style scoped lang="sass">
.gravatar
  border-radius: 50%
</style>
