namespace :github do
  desc "Create author issues"
  task integration: :environment do
    # // MARK: Create existing authors in the github issues
    client = Octokit::Client.new(access_token: ENV['GITHUB_PERSONAL_ACCESS_TOKEN'])
    progress = 0
    authors = Author.where(from_github: false)
    count = authors.count
    authors.each_with_index do |author, i|
      print_percentage(authors, i, count)
      issue = client.create_issue(ENV['GITHUB_REPO'], author.name, author.biography)
      author.update(github_id: issue.id, from_github: true)
    end
    
    # // MARK: Create github webhook
    if client.hooks(ENV['GITHUB_REPO']).find_all{|h| h.config.url == ENV['GITHUB_CALLBACK_URL'] }.blank?
      puts 'Creating webhook'
      client.subscribe "https://github.com/#{ENV['GITHUB_REPO']}/events/issues.json", ENV['GITHUB_CALLBACK_URL'], ENV['GITHUB_WEBHOOK_SECRET']
    else
      puts 'Webhook to this url already exists'
    end
  end
end

# Print the progress of the issues creation in github
def print_percentage(authors, i, count)
  progress = (100*(i+1))/count
  print "| #{i+1} of #{count} | "
  print "#{progress}% Completed "
  total = (progress/5).to_i
  print '['
  total.times {|a| print '#' }
  (20-total).times {|a| print ' ' }
  print ']'
  print "\r"
end
