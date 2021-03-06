uwsgi:
  pkg.installed:
    - name: uwsgi
  service.running:
    - enable: True
    - require:
      - pkg: uwsgi
      - file: /etc/uwsgi/apps-enabled/vup.ini
      - file: /var/log/uwsgi/vup.log
uwsgi-plugin-python:
  pkg.installed:
    - require:
      - pkg: uwsgi
/etc/uwsgi/apps-enabled/vup.ini:
  file.managed:
    - source: salt://uwsgi.ini
    - require:
      - pkg: uwsgi
    - watch_in:
      - service: uwsgi
/var/log/uwsgi/vup.log:
  file.managed:
    - contents: ""
    - replace: false
    - owner: www-data
    - group: www-data
    - watch_in:
      - service: uwsgi
/var/log/vup-debug.log:
  file.managed:
    - contents: ""
    - replace: false
    - owner: www-data
    - group: www-data
    - watch_in:
      - service: uwsgi
api_deps:
  pip.installed:
    - require_in: 
      - service: uwsgi
    - require:
      - pkg: python-pip
    - requirements: /usr/local/vup/api/requirements.txt
