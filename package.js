var description = {
  summary: "Frontend Freshdesk",
  version: "1.0.0",
  name: "frontend-freshdesk"
};
Package.describe(description);

var path = Npm.require("path");
var fs = Npm.require("fs");
eval(fs.readFileSync("./packages/autopackage.js").toString());
Package.onUse(function(api) {
  addFiles(api, description.name, getDefaultProfiles());
  api.use(["frontend-core"]);
  api.export([
    "FreshdeskAdapter"
  ]);
});
