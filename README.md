# Bookstore Api
### Development

Want to contribute? Great!
The application requires Ruby on Rails to run.

Install the dependencies.

```sh
$ cd bookstore-api
$ bundle install
```

Create, migrate, seed database and start the server.

```sh
$ rails db:create db:migrate db:seed
$ rails s -b 0.0.0.0 -p 3000
```

### Github Integration

To integrate this application with github follow the steps below:

##### Generate a personal access token in Github:
Access [Github PAT] page.
Click in Generate new token button.
Check the repo, and admin:repo_hook permissions.
Click in Generate token button.
Create the GITHUB_PERSONAL_ACCESS_TOKEN env with your token.
Ex:
```sh
export GITHUB_PERSONAL_ACCESS_TOKEN="gvdaisdvbakjsbvdkajhb"
```

##### Download ngrok and expose your 3000 port.

Download ngrok in this link [ngrok].
Expose the port 3000 executing the following command: 
```sh
./ngrok http 3000
```
Copy the generated url.  
```sh
Forwarding http://2db927ba.ngrok.io -> http://localhost:3000
```

Concatenate the copied url with '/github_webhooks' and create the GITHUB_CALLBACK_URL env var.
Ex:
```sh
export GITHUB_CALLBACK_URL="http://2db927ba.ngrok.io/github_webhooks"
```

##### Create a GITHUB_REPO env with your issue's repository

Create a new empty repository and point you env to it 
ex:
```sh
export GITHUB_REPO="jotacervan/test-authors-bio".
```
*obs: It needs to be a repository that you have admin permissions*

##### Generate a secret to make your integration secure

Generate the secret with rails
```sh
rails secret
>> khsdbflajhsbdfkjahblakdbfnal
```
and put it in the GITHUB_WEBHOOK_SECRET env var.
```sh
export GITHUB_WEBHOOK_SECRET="khsdbflajhsbdfkjahblakdbfnal"
```

Execute the Github integration task:

```sh
rails github:integration
```
### Required environment variable's table

| ENV VARS | Description  |
| ------- | --- |
| GITHUB_PERSONAL_ACCESS_TOKEN | Personal access token from github |
| GITHUB_WEBHOOK_SECRET | You can generate a secret with rails secret |
| GITHUB_CALLBACK_URL | Url generated by the ngrok |
| GITHUB_REPO | Repository to manage authors and bios |

### Todos

 - Write Tests.
 - Create user authentication.
 - Create page to manage books.
 - Dockerize the application.
 - Implement a bulk import script.
 - Implement Redis and Sidekiq to proccess import scripts.
 - Add real time and email notifications.

License
----

MIT

**Free Software, Hell Yeah!**

   [ngrok]: <https://ngrok.com/download>
   [Github PAT]: <https://github.com/settings/tokens>
   
