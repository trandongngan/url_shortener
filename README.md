# README

## Ruby version
  3.0.4

## ENV
  ```command
  $ cp .env_example .env
  ```
  - Make sure that the values are correctly

## Bundle
  ```command
  $ bundle install
  ```
## Setup Databases
  - Make sure `env` values that it's correctly
  ```command
  $ bin/rails db:create
  $ bin/rails db:migrate
  ```

  - Setup user first
  **The user_first task returns the token to use api (you can run multi times for getting token. It's only return user token first)**

  ```command
  $ rake once_time:user_first
  ```

## How to get the token to access api

  #### By rake:

  ```command
  $ rake once_time:user_first
  ```

   #### By rails console
  ```console
  Oauth::GenerateTokenCommand.call(user_id: User.first.id)
  ```
  **Make sure that the user first is exist**

## Check rubocop
```command
$ bundle exec rubocop
```

## RSpec
```command
$ bundle exec rspec
```

## Check coveralls
  - Need to setup on https://coveralls.io/ (But not now)

## Check rspec code coverage
  - Make sure `Run` your full test
  - Open coverage page [#{Rails.root}/coverage/index.html](#{Rails.root}/coverage/index.html)

## Swagger API Document (for development)
  - Get json result from [http://domain.xxx/api/v1/api_docs](your domain) OR [https://url-shortener-app.herokuapp.com/api/v1/api_docs](heroku demo app)
  - Paste it into this [link](https://editor.swagger.io/)

## How to use api
  #### How to get api key
    - you can generate api key (access token) in your system (`Just use token on your system`)
    - In this time, if you use the test server on heroku. you can use this token `eLiMawjUDpSWoYXtlcYMzeoi6Zu0WUCnDb6ZQaBTiZc`
  #### How to call api
  - you can use postmain or culr or [swagger io](https://editor.swagger.io/) or any tool support this. Call api by curl under
  - encode api
  ```command
      curl --location --request POST 'https://url-shortener-app.herokuapp.com/api/v1/encode' \
    --header 'Content-Type: application/json' \
    --header 'Authorization: Bearer eLiMawjUDpSWoYXtlcYMzeoi6Zu0WUCnDb6ZQaBTiZc' \
    --data-raw '{"url": "https://codesubmit.io/library/react"}'
  ```

  - decode api
  ```command
      curl --location --request POST 'https://url-shortener-app.herokuapp.com/api/v1/decode' \
    --header 'Authorization: Bearer eLiMawjUDpSWoYXtlcYMzeoi6Zu0WUCnDb6ZQaBTiZc' \
    --header 'Content-Type: application/json' \
    --data-raw '{
        "short_url": "boykuA"
    }'
  ```
  **short_url also support full path `https://url-shortener-app.herokuapp.com/boykuA`**


## Discussion
  #### For scaling up
  - In future, If we want to scale up, what's issue that we needed focuss about:
    + **Structure:** -> It's okie, The project's cloned by rails framework. It's very popular & accepted by community. we also extended more thing without difficulty (add new coding folders, lib, config, gem ...)
    + **Coding:** It's clearly now (hanlde errors, manage api versions, extra lib (base62 ...), command pattern, about fat models & controllers (it's small now. in future if it's complex we can put the logic to command, service... we can apply solid coding principle that it's okie too).
    + **Testing:** we have rspec to handle bugs. it's make sure that we have enough confident to deploy application (Of course that we need make sure coverage all issues)
    + **Features:** We have implemented authentication. of course we need improve some thing to complete this feature (add login feature, manage appliction if we want to provide to third party ...). we can expend more features. In once of that is the tracking user click....
    + **Documents:** Currently we have apply open api 3.0 (swagger). It's very simple to description (Or brief) how to use the api endpoint. It's very detail about input & output in all cases. So It's no only for who is used it, also usefull for developer. we just define new file yml in swagger folders when we wanted add new document
    + **Performance:** We need to make clearly that we need to scale up OR scale out in each stage. How to serve many requests (millons, hundreds millons, even billons)
      -> If only scale up that's enough then we need focus about optimize, increase hardware performance. For example: That's we need to optimize coding, queries. Or relevent harware that we inscrease CPU number cores (4 -> 8 -> 24 ..), RAM (8 -> 16 -> 32). we also use caches to improve it

      -> If the stage need to scale out to adapt big data then we can think inscrease number servers, load balancer, mysql replication, mysql partition
      -> Nosql's also a solution worth thinking about
    + **Sercurity:**
      -> Currently we already care about issue related with redirecting. We delete `HTTP_X_FORWARDED_HOST` in request (ref: https://github.com/trandongngan/url_shortener/blob/main/lib/rack/strip_x_forwarded_host.rb ). Of course it's no enough. We need to care about it following this document https://github.com/OWASP/CheatSheetSeries. 

      -> DDOS attack: Currently We have authenticate the user and we have limit 100 times to short link for each key (user) in once day. It may not good a solution. But we can discuss to improve it later 
    + **Infrastructure:** -> we need to implement ci/cd, deployment, docker ..

    



