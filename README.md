# Rate Limiter with Rails and Redis

## Overview
Use ruby on rails and redis to implement rate limiter into a controller.
User can request maximum 100 request per hour. Once it reaches its limit, it will return
status 429 with error message that shows when user can make next request with seconds.

## Getting started

### Prerequisites
Make sure you have redis installed in your machine.

On macOS with Homebrew:

```
brew install redis
```

Linux:

```
apt-get install redis
```

Ruby version used

```
ruby 2.1.2
```

### To check the app

Make sure you are running rails server and redis server before sending request with curl

Once you are running servers, run this command in your terminal to check rate limiter

```
~/ for i in {1..105}
curl -i http://localhost:3000/ >> log.txt

~/ less log.txt | grep "200 OK" | wc -l
- 100

~/ less log.txt | grep "429" | wc -l
- 5
```
