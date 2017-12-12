<template lang="jade">
Form(
  key="signingIn"
  ref="form"
  v-bind:model="formData"
  v-bind:rules="formRules"
)
  FormItem(prop="username")
    Input(
      v-model="formData.username"
      v-bind:placeholder="$t('benutzerName')"
    )
      Icon(type="person" slot="prepend")
  FormItem(prop="password")
    Input(type="password" v-model="formData.password" v-bind:placeholder="$t('passwort')"
  )
      Icon(type="locked" slot="prepend")
  FormItem
    Button(type="primary" icon="log-in" @click="submit") {{$t('anmelden')}}
</template>

<script lang="coffee">
return
  data : ->
    formData :
      username : ""
      password : ""
  methods :
    submit : ->
      @$refs.form.validate (valid) =>
        if valid
          @$store.dispatch "loginUser", @formData
          .then null, (reason) => @$Message.error reason
  computed :
    formRules : ->
      username : [
        required : true
        message : @$t('benutzerNameInvalid')
        trigger : "blur"
      ]
      password : [
        required : true
        message : @$t('passwortInvalid1')
        trigger : "blur"
      ,
        type : "string"
        min : 6
        message : @$t('passwortInvalid2')
        trigger : "blur"
      ]
</script>

<style scoped lang="sass">
</style>
