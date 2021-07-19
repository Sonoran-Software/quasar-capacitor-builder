FROM ubuntu:20.04
WORKDIR /app
ENV TZ=America/Chicago
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update && apt install -y npm && apt install -y android-sdk && apt install -y openjdk-14-jre-headless
RUN echo export JAVA_HOME=/usr/lib/jvm/java-14-openjdk-amd64 >> ~/.profile
RUN echo export ANDROID_SDK_ROOT=/usr/lib/android-sdk/ >> ~/.profile
COPY licenses /opt/android/licenses
COPY licenses /usr/lib/android-sdk/licenses
RUN npm install -g @vue/cli && npm install -g @quasar/cli
