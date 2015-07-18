Meteor.methods
  saveFreshdeskCredential: secure (stepId, domain, username, password) ->
    binding = new Bindings.FreshdeskCredentialTester
      credential:
        details:
          domain: domain
          username: username
          password: password

    try
      future = new Future()
      binding.getUsers()
      .spread (response, body) -> future.return(body)
      .catch (error) -> future.throw(error)
      response = future.wait()
    catch error
      error

    if error or response.require_login
      now = new Date()
      #      error = createError(error or new Error("Invalid Freshdesk Account Data"))
      error = createError(new Error("Invalid Freshdesk Account Data"))
      Issues.insert(_.extend(error,
          stepId: stepId
          userId: @userId
          createdAt: now
          updatedAt: now)
      )
      throw new Meteor.Error(error.message)

    avatarValues =
      api: "Freshdesk"
      uid: "#{domain} (#{username})"
      name: "#{domain} (#{username})"
      userId: @userId
    credentialValues =
      api: "Freshdesk"
      scopes: ["*"]
      details:
        domain: domain
        username: username
        password: password
      updatedAt: new Date()
      userId: @userId

    avatarId = Foreach.saveCredential(avatarValues, credentialValues)
    Issues.remove({stepId: stepId, userId: @userId})
    avatarId

