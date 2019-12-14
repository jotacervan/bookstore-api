class GithubWebhooksController < ActionController::Base
  include GithubWebhook::Processor

  # Handle push event
  def github_push(payload)
    puts '****************************************************'
    puts '****************************************************'
    puts '****************************************************'
    puts payload
  end

  # Handle create event
  def github_create(payload)
    puts '****************************************************'
    puts '****************************************************'
    puts '****************************************************'
    puts payload
  end

  private

  def webhook_secret(payload)
    ENV['GITHUB_WEBHOOK_SECRET']
  end
end