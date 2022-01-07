FROM ubuntu:20.04
WORKDIR /app
ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update && apt install -y curl
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt update --yes && apt install -y nodejs && apt install -y openjdk-13-jdk && apt install -y android-sdk && apt install -y build-essential
ENV JAVA_HOME=/usr/lib/jvm/java-14-openjdk-amd64
ENV ANDROID_SDK_ROOT=/usr/lib/android-sdk/
ENV ANDROID_HOME=/usr/lib/android-sdk/
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
