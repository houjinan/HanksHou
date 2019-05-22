echo "start bundle install now ..."
bundle install --path vendor/bundle
#RAILS_ENV=production bundle exec rake assets:precompile
RAILS_ENV=production bundle exec rake db:migrate
echo "start rails now ..."
RAILS_ENV=production bundle exec rails s -p 3202 -b 0.0.0.0
echo "start rails success ..."
