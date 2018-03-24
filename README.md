Symfony examples
================

Creating development environment:
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

Installing Symfony
```
composer create-project symfony/skeleton akademija2018
```

Testing Symfony (use `127.0.0.1` instead of `0.0.0.0` if outside of docker)
```
cd akademija2018
php -S 0.0.0.0:8000 -t public
```

Test on host (your normal) machine:

[http://127.0.0.1:8000/](http://127.0.0.1:8000/)

Versioning
----------

```bash
echo ".idea/" > ~/.gitignore
git config --global core.excludesfile ~/.gitignore
```

Bonus
-----

[Auto complete](https://github.com/bamarni/symfony-console-autocomplete)
```
composer global require bamarni/symfony-console-autocomplete
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
