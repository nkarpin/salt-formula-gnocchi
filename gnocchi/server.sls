{%- from "gnocchi/map.jinja" import server,cfg with context %}
{%- if server.get('enabled', False) %}

include:
  - apache
  - gnocchi._common

gnocchi_server_packages:
  pkg.installed:
  - names: {{ server.pkgs }}

gnocchi_server_conf:
  file.managed:
  - name: /etc/gnocchi/gnocchi.conf
  - source: salt://gnocchi/files/{{ cfg.version }}/gnocchi.conf
  - template: jinja
  - require:
    - pkg: gnocchi_server_packages

gnocchi_upgrade:
  cmd.run:
  - name: gnocchi-upgrade
  {%- if grains.get('noservices') %}
  - onlyif: /bin/false
  {%- endif %}
  - runas: gnocchi
  - onchanges:
    - file: /etc/gnocchi/gnocchi.conf

apache_enable_gnocchi_wsgi:
  apache_site.enabled:
  - name: wsgi_gnocchi
  {%- if grains.get('noservices') %}
  - onlyif: /bin/false
  {%- endif %}
  - require:
    - cmd: gnocchi_upgrade

gnocchi_apache_restart:
  service.running:
  - name: apache2
  - enable: true
  {%- if grains.get('noservices') %}
  - onlyif: /bin/false
  {%- endif %}
  - watch:
    - apache_site: apache_enable_gnocchi_wsgi

gnocchi_server_services:
  service.running:
  - enable: true
  - names: {{ server.services }}
  {%- if grains.get('noservices') %}
  - onlyif: /bin/false
  {%- endif %}
  - require:
    - cmd: gnocchi_upgrade
  - watch:
    - file: /etc/gnocchi/gnocchi.conf

{%- endif %}
