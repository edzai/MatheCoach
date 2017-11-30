<template lang="jade">
.spin-container(v-if="!$subReady.userStatistics")
  Spin(size="large" fix)
svg(v-else width="100%" height="100%" v-bind:viewBox="chartData.viewBox" preserveAspectRatio="none")
  g(v-bind:transform="chartData.coordinateTransform")
    g
      rect.nothing(
        x=-10
        y=-1000
        v-bind:width="daysCharted*dayWidth+20"
        v-bind:height="silverAnswers*answerHeight+1000"
      )
      rect.bronze(
        x=-10
        v-bind:y="bronzeAnswers*answerHeight"
        v-bind:width="daysCharted*dayWidth+20"
        v-bind:height="(silverAnswers-bronzeAnswers)*answerHeight"
      )
      rect.silver(
        x=-10
        v-bind:y="silverAnswers*answerHeight"
        v-bind:width="daysCharted*dayWidth+20"
        v-bind:height="(goldAnswers-silverAnswers)*answerHeight"
      )
      rect.gold(
        x=-10
        v-bind:y="goldAnswers*answerHeight"
        v-bind:width="daysCharted*dayWidth+20"
        v-bind:height="(goldAnswers+1000)*answerHeight"
      )
    g(v-for="bar in chartData.bars")
      line.bar.success.stroke(
        v-bind:x1="bar.x"
        y1=0
        v-bind:x2="bar.x"
        v-bind:y2="bar.y1Red"
      )
      line.bar.error.stroke(
        v-bind:x1="bar.x"
        v-bind:y1="bar.y1Red"
        v-bind:x2="bar.x"
        v-bind:y2="bar.y2Red"
      )
      //- text(x=0 y=0 font-family="mono" font-size=10 fill="black" transform="scale(0 -1) translate(10 -10)") Test
</template>

<script lang="coffee">
import { UserStatistics } from "/imports/api/userStatistics.coffee"
import _ from "lodash"
return
  data : ->
    daysCharted : 7
    dayWidth : 10
    dayGap : 1
    answerHeight : 10
    bronzeAnswers : 10
    silverAnswers : 50
    goldAnswers : 100
    userStatistics : {}
  computed :
    chartData : ->
      labelFormat="D-M-Y"
      submissions = @userStatistics.submissions
      dayData = [@daysCharted-1..0].map (daysAgo) ->
        date =
          moment()
          .subtract daysAgo, "days"
          .startOf("day")
          .format(labelFormat)
        thatDay = submissions?.byDate?[date]
        correctCount = thatDay?.correct or 0
        falseCount = thatDay?.incorrect or 0
        totalCount = thatDay?.total or 0
        {date, daysAgo, correctCount, falseCount, totalCount}
      #dayData = @mockDayData
      maxDayTotal = (_.maxBy dayData, "totalCount").totalCount
      contentWidth = @daysCharted * @dayWidth
      contentHeight = maxDayTotal * @answerHeight
      bottomMargin = contentHeight * @dayGap / contentWidth
      viewBox = "#{-.5*@dayGap} #{-bottomMargin} #{contentWidth+@dayGap} #{contentHeight+2*bottomMargin}"
      coordinateTransform = "translate(0 #{maxDayTotal * 10}) scale(1 -1)"
      bars = dayData.map (day, index) =>
        x : @dayWidth * (index + .5)
        y1Red : @answerHeight * day.correctCount
        y2Red : @answerHeight * (day.correctCount + day.falseCount)
      return {viewBox, coordinateTransform, bars}
  meteor :
    $subscribe :
      userStatistics : -> [userId : @user?._id]
    userStatistics :
      params : -> userId : @user._id
      update : ({userId}) -> UserStatistics.findOne(userId)
  props :
    user :
      type : Object
      required : true
</script>

<style scoped lang="sass">
.bar
  transition: all 1s
  stroke-width: 9
.nothing
  fill: DimGray
.bronze
  fill: burlywood
.silver
  fill: gainsboro
.gold
  fill: #ec0
</style>
