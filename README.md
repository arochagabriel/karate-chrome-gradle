# karate-chrome-gradle
A docker image with gradle and native chrome to execute karate-ui tests

```docker build -t karate-gradle-chrome .  ```

```docker run --name karate-gradle-chrome --rm -p 9222:9222 -p 5900:5900 -e KARATE_SOCAT_START=true -e KARATE_CHROME_PORT=9223 -e KARATE_WIDTH=1920 -e KARATE_HEIGHT=1080 -t karate-gradle-chrome```
