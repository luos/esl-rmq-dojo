## Declare a DIRECT exchange with your name, for example robert-exchange-1

:ok = Exchange.declare(my_channel, "lajos-exchange-1", :direct)

## Declare a queue with your name, for example robert-queue-1

{:ok, _queue_info} = Queue.declare(my_channel, "lajos-queue-1", durable: true)

## Bind the queue to the exchange, using today's date as the ROUTING KEY, for example 2020-02-28

:ok = Queue.bind(my_channel, "lajos-queue-1", "lajos-exchange-1", routing_key: "28th of February")

## Publish a persistent message to the queue through the exchange

:ok = Basic.publish(my_channel, "lajos-exchange-1", "28th of February", "hello world", persistent: true)

## Consume the message from the queue, for this we have to subscribe to the message stream

{:ok, _tag} = Basic.consume(my_channel, "lajos-queue-1")


Basic.ack(my_channel, delivery_tag)