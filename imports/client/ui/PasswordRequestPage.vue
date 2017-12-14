<template lang="jade">
.content-box(v-if="!emailSent")
  h1.heading {{$t('passwordRequestTitle')}}
  p.text.separated {{$t('passwordRequestDescription')}}
  Form(
    ref="emailForm"
    v-bind:model="formData"
    v-bind:rules="formDataRules"
  )
    FormItem(prop="email")
      Input(
        v-model="formData.email"
        v-bind:placeholder="$t('email')"
      )
    FormItem
      Button(type="primary" icon="ios-paperplane" @click="submit") {{$t('abschicken')}}
.content-box(v-else)
  h1.heading {{$t('passwordRequestEmailSentTitle')}}
  p.text {{$t('passwordRequestEmailSentDescription')}}
</template>

<script lang="coffee">
return
  data : ->
    emailSent : false
    error : ""
    formData :
      email : ""
  computed :
    formDataRules : ->
      email : [
        required : true
        message : @$t "emailRequired"
        trigger : "blur"
      ]
  methods :
    submit : ->
      @$refs.emailForm.validate (valid) =>
        if valid
          Meteor.call "sendResetPasswordEmail",
            email : @formData.email,
            (error,result) =>
              unless error
                @emailSent = result is "email-sent"
              else
                if error.error is "no-user-with-email"
                  @$Modal.error
                    title : @$t "noUserWithEmailErrorTitle"
                    content : @$t "noUserWithEmailErrorDescription"
                    okText : @$t "Ok"
                else
                  @$Modal.error
                    title : @$t "unexpectedErrorTitle"
                    content : @$t "unexpectedErrorDescription"
                    okText : @$t "OK"
</script>

<style scoped lang="sass">
</style>
