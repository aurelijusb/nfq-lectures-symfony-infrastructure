Symfony examples
================

Creating from zero
------------------

### Creating development environment
```
docker build . -t php
docker run -v $PWD:/code -p127.0.0.1:8000:8000 -it php
```

```
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"
```

### Installing Symfony
```
composer create-project symfony/skeleton akademija2018
```

### Testing Symfony
 
(use `127.0.0.1` instead of `0.0.0.0` if outside of docker)
```
cd akademija2018
php -S 0.0.0.0:8000 -t public
```

Test on host (your normal) machine:

[http://127.0.0.1:8000/](http://127.0.0.1:8000/)

### Adding MySql instance

```
docker run --name mysql.symfony -e MYSQL_ROOT_PASSWORD=p9iijKcfgENjBWDYgSH7 -v$PWD/mysql-data/:/var/lib/mysql -p172.17.0.1:3306:3306 -d mysql:5.7.21
```

To test:
```
echo "CREATE DATABASE IF NOT EXISTS symfony; CREATE DATABASE IF NOT EXISTS symfony_test; SHOW DATABASES" | mysql -uroot -p -h172.17.0.1 --port=3306
```

Versioning
----------

```bash
echo ".idea/" > ~/.gitignore
git config --global core.excludesfile ~/.gitignore
```

Reusing examples (dev environment)
----------------------------------

```
sudo su -c 'echo "127.0.0.1 symfony.local" >> /etc/hosts'
git clone git@github.com:aurelijusb/nfq-lectures-symfony-code.git akademija2018
docker build php/ -t php 
docker-compose up
```

Open [symfony.local](http://symfony.local) 

Reusing examples (prod environment)
----------------------------------

```
sudo su -c 'echo "127.0.0.1 symfony.prod" >> /etc/hosts'
git clone git@github.com:aurelijusb/nfq-lectures-symfony-code.git akademija2018
docker build php/ -t php
docker-compose up
```

Open [symfony.prod](http://symfony.prod) 

Bonus
-----

[Auto complete](https://github.com/bamarni/symfony-console-autocomplete)
```
composer global require bamarni/symfony-console-autocomplete
```
```
export PATH="$PATH:~/.composer/vendor/bin/"
eval "$(symfony-autocomplete ./bin/console --shell=bash)"
eval "$(symfony-autocomplete composer --shell=bash)"
```

References
----------

* https://symfony.com/
* https://docs.docker.com/engine/reference/builder/

Author
======

Aurelijus Banelis
