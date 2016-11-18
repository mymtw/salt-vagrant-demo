MONGO_LOGIN = 'mlogin'
POSTGRES_LOGIN = 'plogin'

try:
    from settings_local import * 
except ImportError:
    pass

