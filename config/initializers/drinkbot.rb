require "securerandom"

# This is a queue of dispense requests. They will be processed one at a time.
DrinkQueue = []
CurrentDrink = {
  token: "",
  beverage_ids: []
}
DrinkbotMessages = []

# This initializer will create a thread that will just sit there, running in the background, watching redis for messages indicating that there are new motors.
# create a thread that will just sit there, processing the queue
Thread.new do
  while true
    sleep 1
    # Listen for new motors.
    begin
      Subscriber.subscribe("drinkbot") do |on|
        on.message do |channel, message|
          # Check to see if it is a "name" message.
          payload = JSON.parse(message)
          if payload["command"].nil? && !payload["name"].empty?
            motor = Motor.new(uuid: payload["name"])
            # When we instrument this with New Relic, write an event here.
            STDERR.puts "saving #{motor.inspect}"
            motor.save!
          elsif payload["command"].downcase == "find"
            # Skip this one
          else
            DrinkbotMessages << payload
            STDERR.puts DrinkbotMessages.inspect
          end
        end
      end
    rescue Exception => e
      puts e
    end
  end
end
