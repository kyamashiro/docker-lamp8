# docker-lamp8

Apache + MySQL8 + PHP8 + Composer + Mailhog

## Install Compose V2

https://docs.docker.com/compose/cli-command/#install-on-linux

## Run

```
make build
make start
make stop
make remove
make bash
make mysql/bash
```

## SSL

Install [mkcert](https://github.com/FiloSottile/mkcert), then

```sh
$ mkcert --install
$ mkcert localhost
```

add `localhost.pem` and `localhost-key.pem` file to `php-apache/apache2/ssl`.

## xhprof

add `example-app/public/index.php`

```php
<?php

use Illuminate\Contracts\Http\Kernel;
use Illuminate\Http\Request;
tideways_xhprof_enable(); // add enable
define('LARAVEL_START', microtime(true));

/*
|--------------------------------------------------------------------------
| Check If The Application Is Under Maintenance
|--------------------------------------------------------------------------
|
| If the application is in maintenance / demo mode via the "down" command
| we will load this file so that any pre-rendered content can be shown
| instead of starting the framework, which could cause an exception.
|
*/

if (file_exists($maintenance = __DIR__.'/../storage/framework/maintenance.php')) {
    require $maintenance;
}

/*
|--------------------------------------------------------------------------
| Register The Auto Loader
|--------------------------------------------------------------------------
|
| Composer provides a convenient, automatically generated class loader for
| this application. We just need to utilize it! We'll simply require it
| into the script here so we don't need to manually load our classes.
|
*/

require __DIR__.'/../vendor/autoload.php';

/*
|--------------------------------------------------------------------------
| Run The Application
|--------------------------------------------------------------------------
|
| Once we have the application, we can handle the incoming request using
| the application's HTTP kernel. Then, we will send the response back
| to this client's browser, allowing them to enjoy our application.
|
*/

$app = require_once __DIR__.'/../bootstrap/app.php';

$kernel = $app->make(Kernel::class);

$response = $kernel->handle(
    $request = Request::capture()
)->send();

$kernel->terminate($request, $response);

// add xhprof gui view
$xhprof_data = tideways_xhprof_disable();
include_once "/var/www/html/xhprof/xhprof_lib/utils/xhprof_lib.php";
include_once "/var/www/html/xhprof/xhprof_lib/utils/xhprof_runs.php";

$xhprof_runs = new XHProfRuns_Default();
$run_id = $xhprof_runs->save_run($xhprof_data, "xhprof_testing");

echo "http://localhost/xhprof/xhprof_html/index.php?run={$run_id}&source=xhprof_testing\n";
```