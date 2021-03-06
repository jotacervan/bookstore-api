class GithubWebhooksController < ActionController::Base
  skip_before_action :verify_authenticity_token
  include GithubWebhook::Processor

  # receive only IssuesEvent from github
  def github_issues(payload)
    case payload[:action]
    when 'deleted'
      destroy_author(payload[:issue])
    when 'closed'
      inactivate_author(payload[:issue])
    when 'reopened'
      activate_author(payload[:issue])
    else
      handle_issue(payload[:issue])
    end
  end

  # Inactivate author when closing issue
  def inactivate_author(issue)
    author = Author.find_by(github_id: issue[:id])
    if author.present?
      author.update(active: false )
    end
  end

  # Activate author when reopen issue
  def activate_author(issue)
    author = Author.find_by(github_id: issue[:id])
    if author.present?
      author.update(active: true )
    end
  end

  # Handle create, and update event
  def handle_issue(issue)
    author = Author.find_by(github_id: issue[:id])
    if author.present?
      author.update(name: issue[:title], biography: issue[:body] )
    else
      author = Author.create(name: issue[:title], github_id: issue[:id], from_github: true, biography: issue[:body])
      author.books.create(title: Faker::Book.title, publisher: author, price: 24.20)
    end
    author
  end

  # handle destroy event
  def destroy_author(issue)
    author = Author.find_by(github_id: issue[:id])
    author.destroy if author.present?
  end

  private
  def webhook_secret(payload)
    ENV['GITHUB_WEBHOOK_SECRET']
  end
end