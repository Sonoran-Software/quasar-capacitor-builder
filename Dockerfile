FROM beevelop/ionic:nightly
COPY licenses /opt/android/licenses
RUN npm install -g @vue/cli && npm install -g @quasar/cli
