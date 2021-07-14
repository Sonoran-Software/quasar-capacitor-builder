FROM ubuntu:20.04
WORKDIR /app
COPY licenses /opt/android/licenses
RUN apt update && apt install -y npm && apt install -y android-sdk && apt install -y openjdk-14-jre-headless
RUN export JAVA_HOME=/usr/lib/jvm/java-14-openjdk-amd64
RUN export ANDROID_SDK_ROOT=/usr/lib/android-sdk/
RUN npm install -g @vue/cli && npm install -g @quasar/cli
