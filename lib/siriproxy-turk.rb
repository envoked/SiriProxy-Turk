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

  listen_for /Can I pay my plumber on Friday/i do
    say "You owe your plumber $200.", spoken: "Yes you will have available funds by Friday." 
    say "Today you have a balance of $400."
    say "Your scheduled recievables are $100"
    say "Your pending payments are $200"
    say "By Friday, you'll have a balance of $300."
    response = ask "Would you like to schedule the payment"
    
    if(response =~ /yes/i)
        say "I've scheduled the payment of $200. You should have $100 left in your account on Friday." 
      else
        say "Ok I won't schedule the payment."
      end
    
    request_completed
  end

  listen_for /Have all my pending payments cleared/i do
    say 'No. One transaction in the amount of $200 did not come through.'
    response = ask "Do you want to reschedule the payment to your plumber to avoid any fees?"
    
    if(response =~ /yes/i)
        say "Ok. I've rescheduled the payment for Tuesday when you will have available funds." 
      else
        say "Ok I won't reschedule the payment."
      end
    
    request_completed
    
    
  end
  
  listen_for /Do you have tea/i,within_state: :adrian do
    say "Only English breakfast."
    request_completed
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
