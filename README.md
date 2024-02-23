# docker-lamp8

Apache + MySQL8 + PHP8 + Composer + Mailpit

## Install Compose V2

https://docs.docker.com/compose/cli-command/#install-on-linux

## Run

```
make build
```

See Makefile.

## SSL

Install [mkcert](https://github.com/FiloSottile/mkcert), then

```sh
$ mkcert --install
$ mkcert localhost
```

Add `localhost.pem` and `localhost-key.pem` file to `php-apache/apache2/ssl`.

# extension check

```sh
php -m | egrep -i -v 'bcmath|ctype|fileinfo|json|mbstring|openssl|pdo|tokenizer|xml'
php -r 'phpinfo();'
```

# mail check

```sh
php -r 'mail("to@example.com", "Subject", "Message", "From: from@example.com");'
```
