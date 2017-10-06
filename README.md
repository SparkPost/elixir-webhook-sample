# Using SparkPost Webhooks To Report On Recipient OS Preferences

This project accepts SparkPost webhooks event batches and maintains a report of recipient OS preferences based on the user_agent field from click events.

## Prerequisites
 - Elixir (1.4 used)
 - Phoenix (1.3 used)
 - Node.js/NPM for client side assets (Node 6.11, NPM 3.10 used)

## Usage

To start your Phoenix server:

  * Grab the code with `git clone github.com/SparkPost/elixir-webhook-sample`
  * Install dependencies with `mix deps.get`
  * Configure your database in `config/dev.exs`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Sending Test Data To Your Service

### Using SparkPost
Register your service as a webhook endpoint on your SparkPost account. [You can do that here.](https://app.sparkpost.com/account/webhooks). SparkPost includes a webhook test facility - just click on the "TEST" link beside your webhook to send a test batch.

### Using a Local Test Event Batch
This repo contains 2 sample webhook event batches which you can use to show your service working. You can send a test event batch to your service like this:

```
curl -XPOST -H "Content-type: application/json" -d @batch.json http://localhost:4000/webhook
```
