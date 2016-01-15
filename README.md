CollectionSpace App
===

Consumes and presents data from a [CollectionSpace](http://www.collectionspace.org/) instance backend via the REST api or using CSV exports.

Development
---

To get started run a local instance of PostgreSQL:

```bash
docker run --name postgres -d \
  --net=host \
  -e POSTGRES_PASSWORD=654321 \
  -e DB_CSADMIN_PASSWORD=123456 \
  lyrasis/collectionspace:db
```

Then:

```bash
# install dependencies
bundle install

# drop existing database (optional: if wanting to start over)
bundle exec rake db:drop

# create the database
bundle exec rake db:create

# create the tables
bundle exec rake db:migrate

# load initial attribute mapping data
bundle exec rake db:seed

# load collectionobject and media relationship data
bundle exec rake batch:related_media:sync

# load collectionobject records
bundle exec rake batch:import:seed
```

When starting out (or after "drop") the other commands can be invoked with:

```bash
bundle exec rake app:setup
```

Other frequently required commands:

```bash
# access the console
bundle exec rails c

# start the development server
bundle exec rails s

# clear the cache
bundle exec rake tmp:cache:clear
```

Docker
---

```bash
docker-compose run -d db
docker-compose run app1 bundle exec rake db:setup
docker-compose run -d app1
docker exec -it collectionspaceapp_app1_run_2 bundle exec rake batch:related_media:sync
docker exec -it collectionspaceapp_app1_run_2 bundle exec rake batch:import:seed
```

Contributing
---

Bug reports and pull requests are welcome on GitHub at https://github.com/lyrasis/collectionspace-app.

License
---

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

---