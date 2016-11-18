install project:
  file.recurse:
    - name: {{ pillar['app_dir'] }} 
    - source: salt://frontend

copy frontend config file:
  file.managed:
    - name: {{ pillar['app_dir'] }}/config.json
    - source: salt://configs/frontend/config_frontend.json
    - context:
      env_api_host: {{ pillar['env_api_host'] }}
    - template: jinja

install npm and requirements:
  pkg.installed:
    - name: npm
  npm.bootstrap:
    - name: {{ pillar['app_dir'] }}

install nodejs:
  pkg.installed:
    - name: nodejs-legacy

install grunt-cli via npm:
  npm.installed:
    - name: grunt-cli

run grunt ngconstant task:
  cmd.run:
    - name: grunt ngconstant
    - cwd: {{ pillar['app_dir'] }}

create nginx frontend config file:
  file.managed:
    - name: /etc/nginx/sites-available/frontend.conf
    - source: salt://configs/frontend/nginx_frontend.conf
    - makedirs: True
    - context: 
      app_dir: {{ pillar['app_dir'] }}
    - makedirs: True
    - template: jinja

make symlink for frontend config:
  file.symlink:
    - name: /etc/nginx/sites-enabled/frontend.conf
    - target: /etc/nginx/sites-available/frontend.conf
    - makedirs: True

make sure nginx service installed and running:
  pkg.installed:
    - names: 
      - nginx
      - nginx-extras
  service.running:
    - name: nginx
    - enable: True
    - reload: True
    - watch:
      - file: /etc/nginx/sites-available/frontend.conf
      - file: /etc/nginx/sites-available/default

remove nginx default config file:
  file.absent:
    - name: /etc/nginx/sites-available/default
