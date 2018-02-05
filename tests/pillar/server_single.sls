gnocchi:
  common:
    version: pike
    database:
      engine: mysql
      host: 127.0.0.1
      name: gnocchi
      password: workshop
      user: gnocchi
    storage:
      aggregation_workers: 2
      driver: redis
      redis_url: redis://127.0.0.1/test
      incoming:
        driver: redis
        redis_url: redis://127.0.0.2/test_incoming
  server:
    enabled: true
    coordination_url: redis://127.0.0.1/test
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
    cache:
      engine: memcached
      members:
      - host: 127.0.0.1
        port: 11211
    metricd:
      workers: 5
  statsd:
    resource_id: 07f26121-5777-48ba-8a0b-d70468133dd9
    enabled: true
    bind:
      address: 127.0.0.1
      port: 8125
