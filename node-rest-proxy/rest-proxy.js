/*******************************************************************************
 *Copyright (C) 2017 Eurotech.
 *All rights reserved. This program and the accompanying materials
 *are made available under the terms of the Eclipse Public License v1.0
 *which accompanies this distribution, and is available at
 *http://www.eclipse.org/legal/epl-v10.html
 *
 *Contributors:
 *    Eurotech - initial API and implementation
 ******************************************************************************/
var http = require('http'),
httpProxy = require('http-proxy');

const localPort = 1234
const target = 'http://localhost:80'

var proxy = httpProxy.createProxyServer({})

proxy.on('proxyRes', function(proxyRes, req, res, options) {
  delete proxyRes.headers['x-frame-options']
});

proxy.on('error', function (err, req, res) {
  res.writeHead(500, {
    'Content-Type': 'text/plain'
  });
  res.end('Something went wrong.');
  console.error(err);
})

var server = http.createServer(function(req, res) {
  proxy.web(req, res, {
    target: target
  });
});

console.log("listening on port " + localPort)
server.listen(localPort)
