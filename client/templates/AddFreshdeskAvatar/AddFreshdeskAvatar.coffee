Template.AddFreshdeskAvatar.helpers
#  helper: ->
  options: ->
#    if AvatarSubscriptionIsInitialized.equals(@api, true)
    Avatars.find({api: @api})

Template.AddFreshdeskAvatar.onRendered ->
  step = @data
  @$("input").first().focus()
  @$("form").formValidation
    framework: 'bootstrap'
    live: "disabled"
    fields:
      domain:
        validators:
          notEmpty:
            message: "Please enter you #{step.api} Domain"
      username:
        validators:
          notEmpty:
            message: "Please enter your #{step.api} API key"
      password:
        validators:
          notEmpty:
            message: "Please enter your #{step.api} API secret"
  .on "success.form.fv", grab encapsulate (event) ->
    $button = $(event.currentTarget)
    $button.find(".ready").hide()
    $button.find(".loading").show()

    $form = $(event.currentTarget).closest("form")
    values = {}
    for field in $form.serializeArray()
      values[field.name] = field.value

    Meteor.call "saveFreshdeskCredential", step._id, values.domain, values.username, values.password, (error, avatarId) ->
      $button.find(".ready").show()
      $button.find(".loading").hide()

      step.execute({avatarId: avatarId}) unless error


Template.AddFreshdeskAvatar.events
#  "click .selector": (event, template) ->
