testStr = "sin(32) + abc + cos(xyzabc)"

class AMString
  constructor : (@str) ->
  value : -> @str

  removeWhitespace : ->
    re = /\s/g
    @str = @str.replace re, ""
    this

  markReserved : ->
    re = ///
      sqrt|sin|cos|tan|
      expand|divide|diff|
      alpha|beta|gamma|delta|epsilon|pi
    ///gi
    @str = @str.replace re, "$&@@@"
    this

  unmarkReserved : ->
    @str = @str.replace /@@@/g, ""
    this

  sortUnmarked : ->
    re = /(?![a-z]*@@@)[a-z]{2,}/g
    @str = @str.replace re, (match) ->
      match.split("").sort().join("")
    this

  productify : ->
    @sortUnmarked()
    re = /(?![a-z]*@@@)([a-z])([a-z])/g
    doRecursion = (str) ->
      result = str.replace re, "$1*$2"
      if result is str then result else doRecursion result
    @str = doRecursion @str
    this

  unproductify : ->
    re = /(\w)\*([a-z\(])/g
    doRecursion = (str) ->
      result = str.replace re, "$1$2"
      if result is str then result else doRecursion result
    @str = doRecursion @str
    this

  greekify : ->
    re = /alpha|beta|gamma|delta|epsilon|pi/g
    @str = @str.replace re, "\$&"
    this

exports.AMString = AMString

# formula = new AMString testStr
# console.log formula.value()
#
# result =
#   formula
#     .markReserved()
#     .removeWhitespace()
#     .productify()
#     .unmarkReserved()
#     .value()
# console.log result
#
# console.log formula.unproductify().value()
