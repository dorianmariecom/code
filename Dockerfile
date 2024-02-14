FROM debian:bullseye-slim as base
ENV RUBY_VERSION="3.3.0" \
    NODE_VERSION="20.11.0" \
    NPM_VERSION="10.4.0" \
    YARN_VERSION="1.22.19" \
    RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development" \
    PATH="/opt/rubies/ruby-${RUBY_VERSION}/bin:/usr/local/node/bin:${PATH}"

RUN apt-get update && \
    apt-get install -y \
        autoconf \
        build-essential \
        curl \
        fish \
        git \
        libpq-dev \
        libvips \
        pkg-config \
        vim \
        wget

RUN wget https://github.com/postmodern/ruby-install/releases/download/v0.9.3/ruby-install-0.9.3.tar.gz \
  && tar -xzvf ruby-install-0.9.3.tar.gz \
  && cd ruby-install-0.9.3/ \
  && make install

RUN ruby-install -p https://github.com/ruby/ruby/pull/9371.diff ruby "${RUBY_VERSION}"

WORKDIR /rails

FROM base as build

RUN curl -sL https://github.com/nodenv/node-build/archive/master.tar.gz | tar xz -C /tmp/ && \
    /tmp/node-build-master/bin/node-build "${NODE_VERSION}" /usr/local/node && \
    npm install -g "yarn@${YARN_VERSION}" && \
    rm -rf /tmp/node-build-master

COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

COPY . .

RUN bundle exec bootsnap precompile app/ lib/

RUN RAILS_MASTER_KEY_DUMMY=1 SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

FROM base

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libvips postgresql-client && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp
USER rails:rails

ENTRYPOINT ["/rails/bin/docker-entrypoint"]

EXPOSE 3000
CMD ["./bin/rails", "server"]
