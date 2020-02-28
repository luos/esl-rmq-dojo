require Logger
alias AMQP.{Connection, Channel, Queue, Basic, Exchange}

rabbitmq_host = "rabbitmq.gerecs.hu"

rabbitmq_user = "guest"

rabbitmq_password = "guest"

your_name = "##PUT YOUR NAME HERE%%"


{:ok, my_connection} = Connection.open(
    host: rabbitmq_host, 
    port: 5672, 
    heartbeat: 60, 
    name: "Connection of " <> your_name,
    username: username,
    password: password
  )

{:ok, my_channel} = Channel.open(my_connection)

Logger.info("")
Logger.info("")
Logger.info("")

## Declare a DIRECT exchange with your name, for example robert-exchange-1

# :ok = ...

## Declare a queue with your name, for example robert-queue-1

# {:ok, _queue_info} = ...

## Bind the queue to the exchange, using today's date as the ROUTING KEY, for example 2020-02-28

# :ok = ...

## Publish a persistent message to the queue through the exchange

# :ok = ...

## Consume the message from the queue, for this we have to subscribe to the message stream

# {:ok, _tag} = ...

receive do
  {:basic_consume_ok, _} -> 
    Logger.info("Successfully subscribed to our queue")
  after 5000 -> 
    Logger.info("Something went wrong")
    Kernel.exit(1)
end

receive do
  {:basic_deliver, payload, metadata} -> 
    Logger.info("Received message: ")
    Logger.info(inspect(payload))
    Logger.info(inspect(metadata))
    
    ## Acknowledge the message

    :timer.sleep(60000) # remove this line after acking the message

  after 5000 -> 
    Logger.info("Something went wrong")
    Kernel.exit(1)
end


Logger.info("Exiting...")
:ok = Channel.close(my_channel)
:ok = Connection.close(my_connection)
