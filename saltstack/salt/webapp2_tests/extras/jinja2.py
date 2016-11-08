#from __future__ import absolute_import
import importlib

_jinja2 = importlib.import_module("jinja2")
#import jinja2

print(_jinja2.__version__)

