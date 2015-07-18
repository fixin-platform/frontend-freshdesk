class Bindings.Freshdesk extends Bindings.Basic
  request: (options) ->
    _.defaults(options,
      baseUrl: "https://#{@credential.details.domain}.freshdesk.com"
      json: true
    )
    super(options)

  getUsers: (params) ->
    @request(
      method: "GET"
      url: "/contacts.json"
      qs: params
    )
