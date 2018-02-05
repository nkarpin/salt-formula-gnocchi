{%- from "gnocchi/map.jinja" import statsd,cfg with context %}
{%- if statsd.get('enabled', False) %}

include:
  - gnocchi._common

gnocchi_statsd_packages:
  pkg.installed:
  - names: {{ statsd.pkgs }}

gnocchi_statsd_conf:
  file.managed:
  - name: /etc/gnocchi/gnocchi.conf
  - source: salt://gnocchi/files/{{ cfg.version }}/gnocchi.conf
  - template: jinja
  - require:
    - pkg: gnocchi_statsd_packages

gnocchi_statsd_services:
  service.running:
  - enable: true
  - names: {{ statsd.services }}
  {%- if grains.get('noservices') %}
  - onlyif: /bin/false
  {%- endif %}
  - watch:
    - file: /etc/gnocchi/gnocchi.conf

{%- endif %}
