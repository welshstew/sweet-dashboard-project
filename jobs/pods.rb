require 'net/http'
require 'uri'
require 'json'

#server = "https://10.1.2.2"
server = "https://kubernetes.default.svc"
namespace = "origin-metrics"
tokenFilename = "/var/run/secrets/kubernetes.io/serviceaccount/token"
token = "QZ9lcQNU8fjcbnCHSJ1UfPucBdPqT2j4fC469SqfZi4"

log = Logger.new(STDOUT)
log.level = Logger::INFO

#get the token for kubernetes access in the pod..!
if File.exists?(tokenFilename){
	token = IO.read(tokenFilename)
}

SCHEDULER.every '30s' do

  url = URI.parse("#{server}/api/v1/namespaces/#{namespace}/pods")
  http = Net::HTTP.new(url.host, 8443)
  http.use_ssl = (url.scheme == 'https')
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE

  response = http.request(Net::HTTP::Get.new(url.request_uri, {'Authorization' => "Bearer #{token}"}))

  # Convert to JSON
  j = JSON[response.body]

	hrows = [
	  { cols: [ {value: 'PodName'}, {value: 'Status'}, {value: 'RestartCount'} ] }
	]

  pods = []

  j["items"].each do | item |
	#podname, phase, restarts
    thispod = { cols: [ {value: item["metadata"]["name"]}, {value: item["status"]["phase"]}, {value: item["status"]["containerStatuses"][0]["restartCount"].to_s}]}
    pods.push(thispod)
  end

  send_event('pods', { hrows: hrows, rows: pods } )
end

