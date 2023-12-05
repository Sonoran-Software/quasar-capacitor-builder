FROM ubuntu:20.04
WORKDIR /app
ENV TZ=America/Chicago
ENV NODE_MAJOR=20
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update && apt install -y ca-certificates curl gnupg
RUN mkdir -p /etc/apt/keyrings
RUN curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
RUN echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list
RUN apt update --yes && apt install -y nodejs && apt install -y openjdk-17-jdk && apt install -y android-sdk && apt install -y build-essential
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV ANDROID_SDK_ROOT=/usr/lib/android-sdk/
ENV ANDROID_HOME=/usr/lib/android-sdk/
ENV BUNDLE_SILENCE_ROOT_WARNING=true
COPY licenses /opt/android/licenses
COPY licenses /usr/lib/android-sdk/licenses

# Additional tools for npm and fixing line endings
RUN apt update --yes && apt install -y git dos2unix

# Ruby and Bundler for Fastlane Support
RUN apt update --yes && apt install -y ruby ruby-dev
COPY Gemfile .
RUN gem install json && gem install bundler
RUN bundle install

RUN npm install -g @vue/cli && npm install -g @quasar/cli
