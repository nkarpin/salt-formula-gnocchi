gnocchi:
  server:
    enabled: true
    version: pike
    bind:
      address: 127.0.0.1
      port: 8041
    api:
      auth_mode: keystone
      workers: 5
    identity:
      engine: keystone
      region: RegionOne
      protocol: http
      host: 127.0.0.1
      port: 35357
      user: gnocchi
      password: workshop
      tenant: service
    database:
      engine: mysql
      host: 127.0.0.1
      name: gnocchi
      password: passw0rd
      user: gnocchi
      ssl:
        enabled: True
    cache:
      engine: memcached
      members:
      - host: 127.0.0.1
        port: 11211
    metricd:
      workers: 5