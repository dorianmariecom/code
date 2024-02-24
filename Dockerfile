FROM debian:bullseye-slim as base
ENV BUNDLER_VERSION="2.5.5" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development" \
    NODE_VERSION="20.11.0" \
    NPM_VERSION="10.4.0" \
    RAILS_ENV="production" \
    RUBY_INSTALL_VERSION="0.9.3" \
    RUBY_VERSION="3.3.0" \
    YARN_VERSION="1.22.19"

ENV PATH="/opt/rubies/ruby-${RUBY_VERSION}/bin:/usr/local/node/bin:${PATH}"

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

RUN wget "https://github.com/postmodern/ruby-install/releases/download/v${RUBY_INSTALL_VERSION}/ruby-install-${RUBY_INSTALL_VERSION}.tar.gz" \
  && tar -xzvf "ruby-install-${RUBY_INSTALL_VERSION}.tar.gz" \
  && cd "ruby-install-${RUBY_INSTALL_VERSION}" \
  && make install

RUN ruby-install -p https://github.com/ruby/ruby/pull/9371.diff ruby "${RUBY_VERSION}"

WORKDIR /rails

FROM base as build

RUN curl -sL https://github.com/nodenv/node-build/archive/master.tar.gz | tar xz -C /tmp/ && \
    /tmp/node-build-master/bin/node-build "${NODE_VERSION}" /usr/local/node && \
    npm install -g "yarn@${YARN_VERSION}" && \
    rm -rf /tmp/node-build-master

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

FROM base

COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp
USER rails:rails

ENTRYPOINT ["/rails/bin/docker-entrypoint"]

EXPOSE 3000
CMD ["./bin/rails", "server"]
