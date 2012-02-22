require 'net/http'
require 'uri'
require 'cora'
require 'siri_objects'
require 'pp'

#######
# This is a "hello world" style plugin. It simply intercepts the phrase "test siri proxy" and responds
# with a message about the proxy being up and running (along with a couple other core features). This 
# is good base code for other plugins.
# 
# Remember to add other plugins to the "config.yml" file if you create them!
######

class SiriProxy::Plugin::Turk < SiriProxy::Plugin
  def initialize(config)
    #if you have custom configuration options, process them here!
  end

  #get the user's location and display it in the logs
  #filters are still in their early stages. Their interface may be modified
  filter "SetRequestOrigin", direction: :from_iphone do |object|
    puts "[Info - User Location] lat: #{object["properties"]["latitude"]}, long: #{object["properties"]["longitude"]}"
    
    #Note about returns from filters:
    # - Return false to stop the object from being forwarded
    # - Return a Hash to substitute or update the object
    # - Return nil (or anything not a Hash or false) to have the object forwarded (along with any 
    #    modifications made to it)
  end 

  listen_for /hello mate/i do
    say "Why hello there sir."
  end
  # listen_for /turk (.*)/i do |question|
  # 
  #   File.open("siri-question.txt", 'w+') {|f| f.write(question) }# write the question to a file
  #   sTime = Time.now # the time the request came in
  #   
  #   File.open('siri-response.txt', 'r') {|f|
  #     while true
  #       sleep(2)
  #       if f.ctime > sTime
  #         say f.read # say the contents of the file
  #         break
  #       end
  #     end
  #   }
  #   
  #   request_completed #always complete your request! Otherwise the phone will "spin" at the user!
  # end
  
  
end
