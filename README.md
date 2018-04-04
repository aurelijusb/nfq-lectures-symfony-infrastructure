Symfony examples
================

Creating from zero
------------------

### Starting project for development

* [Install docker CE](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
* [Install docker-compose](https://docs.docker.com/compose/install/)
* Ensure nothing is running on `80` and `3306` port (e.g. local `apache`, `nginx`,`skype`, `mysql`)
* Prepare infrastructure:
  ```
  sudo su -c 'echo "127.0.0.1 symfony.local" >> /etc/hosts'
  docker build php/ -t php.symfony 
  docker build frontend/ -t frontend.symfony
  docker-compose up -d
  ```
  (If you are not changing infrastructure, next time you would only need to run `docker-compose up -d`)

* Start container with frontend tools (exec into container):
```
docker-compose run frontend.symfony
```
  * For first time – install JavaScript dependencies and libraries:
  ```
  npm install
  ```
  * During development (regenerate files):
  ```
  yarn run encore dev --watch
  ```

* Use container with PHP tools (exec into running container):
```
docker exec -it php.symfony bash
```
  * For the first time – install PHP dependencies and libraries:
  ```
  composer install
  ```
  * During development (regenerate files)
  ```
  ./bin/console --env=dev cache:clear
  ./bin/console --env=dev cache:warmup
  ./bin/console --env=dev assets:install
  ```

* Results should be visible via Browser at [symfony.local](http://symfony.local)


### Starting project for production-like environment

* [Install docker CE](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
* [Install docker-compose](https://docs.docker.com/compose/install/)
* Ensure nothing is running on `80` and `3306` port (e.g. local `apache`, `nginx`,`skype`, `mysql`)
* Prepare infrastructure:
  ```
  sudo su -c 'echo "127.0.0.1 symfony.prod" >> /etc/hosts'
  docker build php/ -t php.symfony
  docker build frontend/ -t frontend.symfony
  docker-compose up -d
  ```
  (If you are not changing infrastructure, next time you would only need to run `docker-compose up -d`)

* Start container with frontend tools (exec into container):
```
docker-compose run frontend.symfony
```
  * For the first time – install JavaScript dependencies and libraries:
  ```
  npm install
  ```
  * Generate optimized versions (or if changes are not visible):
  ```
  yarn run encore production
  ```

* Use container with PHP tools (exec into running container):
```
docker exec -it php.symfony bash
```
  * For the first time – install PHP dependencies and libraries:
  ```
  composer install
  ```
  * Generate optimized versions (or if changes are not visible):
  ```
  ./bin/console --env=prod cache:clear
  ./bin/console --env=prod cache:warmup
  ./bin/console --env=prod assets:install
  ```

* Results should be visible via Browser at [symfony.prod](http://symfony.prod)

P.S. you can also open alongside `symfony.local` – which is development version the same code.


FAQ
---

* **I have `apache` installed and do not want to stop/uninstall it**

You can change `127.0.0.1:80:80` in [docker-compose.yml] to something like `127.0.0.1:8080:80`.
So your urls will be [http://symfony.local:8080]


* **What is MySQL user and passord and how to change it?**

There is `MYSQL_ROOT_PASSWORD=` in [docker-compose.yml] for `root` user.
Database with this password is created when you first launch your instance.
It is use in:

 * `PHP` container near `DATABASE_URL=` in [docker-compose.yml]
 * Nginx configuration near `DATABASE_URL` in [nginx/site.conf]
 * Symfony project development environment near `DATABASE_URL` in `.env` file


* **I messed up something. How to refresh everything?**

Remove all running containers and start them again:
```
docker rm -f $(docker ps -aq)
docker-compose up -d
```


* **I messed up database. How to refresh database?**

Remove running containers (or at least MySql): `docker rm -f $(docker ps -aq)`
Remove `mysql-data` folder.
Start containers again (empty MySql will be created): `docker-compose up -d`


* **How to connect to MySql instance?**

```
mysql -uroot -h127.0.0.1 --port=3306 -p
```

Use password: `p9iijKcfgENjBWDYgSH7` (same as in [docker-compose.yml] `MYSQL_ROOT_PASSWORD=`)

Versioning
----------

It is good practice to ignore IDE config files from going into Version control.

```bash
echo ".idea/" > ~/.gitignore
git config --global core.excludesfile ~/.gitignore
```

Bonus
-----

[Auto complete](https://github.com/bamarni/symfony-console-autocomplete)
```
composer global require bamarni/symfony-console-autocomplete
```
```
export PATH="$PATH:~/.composer/vendor/bin/"
eval "$(APP_ENV=dev symfony-autocomplete ./bin/console --shell=bash)"
eval "$(symfony-autocomplete composer --shell=bash)"
```

References
----------

* https://symfony.com/
* https://docs.docker.com/engine/reference/builder/
* https://docs.docker.com/engine/reference/builder
* https://docs.docker.com/compose/compose-file/compose-file-v2/

Author
======

Aurelijus Banelis
