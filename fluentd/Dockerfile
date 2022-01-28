# Copyright (c) 2019-2022 Crave.io Inc. All rights reserved
FROM fluent/fluentd:v1.8-1
USER root
RUN apk add --no-cach --update --virtual .build-deps \
        sudo build-base ruby-dev \
 && sudo gem install \
        fluent-plugin-elasticsearch \
 && sudo gem sources --clear-all \
 && apk del .build-deps \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem
USER fluent
