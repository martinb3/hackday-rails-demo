# demo rails app for hackday

Built using the official tutorial(s) at:
  http://guides.rubyonrails.org/getting_started.html

## steps to reproduce

1. create Gemfile with 'rails' and source of rubygems
1. `bundle exec rails new blog`
1. Follow the tutorial above
1. Set `$DATABASE_URL` or use default sqlite
1. `bin/rails db:migrate`


Check in `config/database.yml` to setup a more complex database, e.g.:
```
development:
  adapter: mysql2
  encoding: utf8
  database: blog_development
  pool: 5
  username: root
  password:
  socket: /tmp/mysql.sock
```
