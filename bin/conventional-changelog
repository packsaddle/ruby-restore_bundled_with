#!/usr/bin/env node

var fs = require('fs');
var execSync = require('child_process').execSync;
var conventionalChangelog = require('conventional-changelog');

var repo = 'https://github.com/packsaddle/ruby-restore_bundled_with'
var version = "" + execSync('bundle exec exe/restore-bundled-with version --digit');

conventionalChangelog({
  repository: repo,
  version: version,
  file: 'CHANGELOG.md'
}, function(err, log) {
  fs.writeFile('CHANGELOG.md', log, function(err){
    console.log(err);
  });
  console.log('Here is your changelog!', log);
});
