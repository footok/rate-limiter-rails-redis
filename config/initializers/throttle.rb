require 'redis'

THROTTLE_TIME_WINDOW = 60 * 60
THROTTLE_MAX_REQUESTS = 100

redis_conf = YAML.load(File.join(Rails.root, 'config', 'redis.yml'))
REDIS = Redis.new(:host => redis_conf['host'], :port => redis_conf['port'])
