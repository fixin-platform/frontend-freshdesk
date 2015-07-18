class Bindings.FreshdeskCredentialTester extends Bindings.Freshdesk
  # override constructor to bypass Credential object requirement
  constructor: (options) ->
    _.extend(@, options)
