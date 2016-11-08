# -*- coding: utf-8 -*-
from __future__ import absolute_import, division, print_function, unicode_literals
import json
import webapp2
from settings import MONGO_LOGIN
from settings import POSTGRES_LOGIN


class HelloWebapp2(webapp2.RequestHandler):
    def get(self):
        self.response.headers['Access-Control-Allow-Origin'] = '*'
        self.response.headers['Content-Type'] = 'text/json'
    
        values = {
            'data': 'I m 1337 p@c@n',
            'mongo_login': MONGO_LOGIN,
            'postgres_login': POSTGRES_LOGIN,
        }
        self.response.out.write(json.dumps(values))


app = webapp2.WSGIApplication([
    ('/', HelloWebapp2),
], debug=True)


def main():
    from paste import httpserver
    httpserver.serve(app, host='127.0.0.1', port='8080')


if __name__ == '__main__':
    main()
