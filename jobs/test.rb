
# require 'json'
# require 'logger'

# log = Logger.new(STDOUT)
# log.level = Logger::INFO

# file = File.read('response.json')
# j = JSON.parse(file)

# j["items"].each do | item |
# 	#podname, phase, restarts
# 	log.info(item["metadata"]["name"] + " " + item["status"]["phase"] + " " + item["status"]["containerStatuses"][0]["restartCount"].to_s )
# end	