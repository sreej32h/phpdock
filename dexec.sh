#!/usr/bin/env bash

if [ $# -gt 0 ]; then

    if [ "$1" == "start" ]; then
        docker-compose up -d

    elif [ "$1" == "stop" ]; then
        docker-compose down

    elif [ "$1" == "artisan" ] || [ "$1" == "art" ]; then
        shift 1
        docker-compose exec \
            app \
            php artisan "$@"

    elif [ "$1" == "composer" ] || [ "$1" == "comp" ]; then
        shift 1
        docker-compose exec \
            app \
            composer "$@"

    elif [ "$1" == "test" ]; then
        shift 1
        docker-compose exec \
            app \
            ./vendor/bin/phpunit "$@"

    elif [ "$1" == "npm" ]; then
        shift 1
        docker-compose run --rm \
            node \
            npm "$@"

    elif [ "$1" == "yarn" ]; then
        shift 1
        docker-compose run --rm \
            node \
            yarn "$@"

    elif [ "$1" == "gulp" ]; then
        shift 1
        docker-compose run --rm \
            node \
            ./node_modules/.bin/gulp "$@"
    elif [ "$1" == "ngreload" ]; then
        shift 1
        docker-compose exec \
            app \
            sh -c "cp /var/www/conf/nginx-app.conf /etc/nginx/sites-available/default && nginx -s reload"
    else
        docker-compose "$@"
    fi

else
    docker-compose ps
fi