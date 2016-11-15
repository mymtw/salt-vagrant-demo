install python pip:
  pkg.installed:
    - names:
      - python-dev
      - build-essential
      - python-pip
      - python-virtualenv

install virtualenvwrapper:
  pip.installed:
    - name: virtualenvwrapper
    - require:
      - pkg: python-pip

install project:
  file.recurse:
    - name: {{ pillar['app_dir'] }}
    - source: salt://webapp2_tests

copy project settings_local:
  file.managed:
    - name: {{ pillar['app_dir'] }}/settings_local.py
    - source: salt://configs/backend/settings_local.py
    - context:
      mongodblogin: {{ pillar['mongodblogin'] }}
      mypostgreslogin: {{ pillar['mypostgreslogin'] }}
    - template: jinja

create virtualenv:
  virtualenv.managed:
    - name: {{ pillar['env_path'] }}
    - user: ubuntu
    - system_site_packages: False
    - requirements: {{ pillar['app_dir'] }}/requirements.txt

remove nginx default config file:
  file.absent:
    - name: /etc/nginx/sites-available/default

create nginx config file:
  file.managed:
    - name: /etc/nginx/sites-available/backend.conf
    - source: salt://configs/backend/nginx_backend.conf
    - makedirs: True

make symlink for backend conf:
  file.symlink:
    - name: /etc/nginx/sites-enabled/backend.conf
    - target: /etc/nginx/sites-available/backend.conf

make sure the nginx service installed and is running:
  pkg.installed:
    - names: 
      - nginx
      - nginx-extras
  service.running:
    - name: nginx
    - enable: True
    - reload: True
    - watch:
      - file: /etc/nginx/sites-enabled/backend.conf

create supervisor config file:
  file.managed:
    - name: /etc/supervisor/conf.d/backend.conf
    - source: salt://configs/backend/supervisor_backend.conf
    - context: 
      app_dir: {{ pillar['app_dir'] }}
      gunicorn: {{ pillar['env_path'] }}/bin/gunicorn
    - makedirs: True
    - template: jinja

make sure the supervisor service installed and running:
  pkg.installed:
    - name: supervisor
  service.running:
    - name: supervisor
    - enable: True
    - reload: True
    - watch:
      - file: /etc/supervisor/conf.d/backend.conf

