ptMoment = angular.module "ptMoment", []

moment.lang "ru"

ptMoment.filter "momentFromNow", ->
  (dateString) ->
    date = moment(dateString)
    if date.isBefore new Date(), "week"
      if date.isBefore new Date(), "year"
        format = "D MMMM YYYY в h:mm"
      else
        format = "D MMMM в h:mm"
      date.format format
    else
      date.calendar()

ptMoment.filter "momentFormat", ->
  (date, dateString) ->
    moment(date).format dateString if date and dateString
