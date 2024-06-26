ARG BUNDLER_VERSION="2.5.7" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development" \
    NODE_VERSION="21.7.2" \
    NPM_VERSION="10.5.1" \
    PATH="/usr/local/node/bin:${PATH}" \
    RAILS_ENV="production" \
    RUBY_INSTALL_VERSION="0.9.3" \
    RUBY_VERSION="3.3.1" \
    YARN_VERSION="1.22.19"

FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

RUN apt-get update && \
    apt-get install -y \
        autoconf \
        build-essential \
        curl \
        fish \
        git \
        libpq-dev \
        libvips \
        pandoc \
        pkg-config \
        postgresql-client \
        vim \
        wget

WORKDIR /rails

RUN curl -sL https://github.com/nodenv/node-build/archive/master.tar.gz | tar xz -C /tmp/
RUN /tmp/node-build-master/bin/node-build "${NODE_VERSION}" /usr/local/node
RUN npm install -g "yarn@${YARN_VERSION}"

COPY Gemfile Gemfile.lock ./

RUN gem install bundler -v "${BUNDLER_VERSION}"
RUN bundle install

COPY package.json yarn.lock ./

RUN yarn install --frozen-lockfile

COPY . .

RUN HOST=example.com \
    BASE_URL=https://example.com \
    RAILS_MASTER_KEY_DUMMY=1 \
    SECRET_KEY_BASE_DUMMY=1 \
    ./bin/rails assets:precompile

ENTRYPOINT ["/rails/bin/docker-entrypoint"]

EXPOSE 3000
CMD ["./bin/rails", "server"]
LABEL service="code"
