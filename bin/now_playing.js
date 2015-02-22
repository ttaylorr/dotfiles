#!/usr/bin/env node

var fs = require('fs'),
    http = require('http'),
    util = require('util');

function CurrentlyPlaying (opts) {
  var opts = util._extend({
    delay: 5000, // delay in milliseconds
    debug: false,
    path: '~/.current_song',
    template: "'%t' by %a on '%m'\n", // %t - track, %a - artist, %m album
    dry: process.argv[2] === '--dry' || process.argv[2] === '-d'
  }, (opts || {}));

  for (var prop in opts) {
    this[prop] = opts[prop];
  }
}

CurrentlyPlaying.prototype.startLoop = function () {
  var self = this;

  var update = function () {
    self._getTrack(function (track, err) {
      if (track) {
        self._saveFile(track);
      } else if (err) {
        return;
      }
    });
  }

  if (this.dry) return update.call();
  else return setInterval(update, this.delay);
}

CurrentlyPlaying.prototype._saveFile = function (track) {
  var self = this;

  fs.writeFile(this.path, this._makeFile(track), function (err) {
    if (self.debug) {
      console.log('File succesfully written to disk.');
    }
  });
}

CurrentlyPlaying.prototype._makeFile = function (track) {
  return this.template.replace('%t', track.title)
                      .replace('%a', track.artist)
                      .replace('%m', track.album);
}

CurrentlyPlaying.prototype._getTrack = function (callback) {
  callback = (callback || function () { /* noop */ });

  http.get(this._requestUrl(), function (req) {
    var body = '';
    req.on('readable', function (data) {
      body += (this.read() || '');
    });

    req.on('end', function () {
      var parsedBody = JSON.parse(body);

      if (parsedBody.recenttracks) {
        var track = parsedBody.recenttracks.track;

        callback({
          title:  track.name,
          artist: track.artist["#text"],
          album:  track.album["#text"]
        }, undefined);
      } else {
        callback(undefined, "no response given");
      }
    });
  });
}

CurrentlyPlaying.prototype._requestUrl = function () {
  return 'http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user=' +
          this.user + '&api_key=' + this.apiKey + '&format=json&limit=1';
}

new CurrentlyPlaying({
  user: 'ttayl0rr',
  apiKey: '357b77889dc17824a805d58bba4bb78c',
  path: '/Users/ttaylorr/.current_song',
}).startLoop();

