---
  layout: article
  title: "ServiceNow logging performance and best practices."
  shortDescription: "Learn how to log like a pro in ServiceNow. Increase performance and resolve issues quicker."
  seoTitle: "Learn how to log like a pro in ServiceNow. Increase performance and resolve issues quicker."
  seoImage: "/open-graph-images/logging-graph.jpg"
  slug: "logging-performance-and-practices"
  isPublished: true
  createdOn: 2022-01-14
  updatedOn: 2022-01-14
---

## Performance Considerations
One of the **biggest performance mistakes** a developer can make is equating a ```gs.log()``` statement to a ```console.log()``` statement.

This is understandable as most of us are primarily javascript developers and the use of console.log() is a long established pattern that allows for quick debugging with little impact to your application. ```gs.log()``` is similar in syntax so it's typically used in the same way when developing ServiceNow applications.

The crux of this issue is that this ```gs.log()``` _does_ have considerable performance implications.

Understanding the implementation of ```gs.log()``` provided encouraged me to approach logging with greater intention.

Under the hood ```gs.log("Hello World")```'s implementation can be visualized as:

```javascript
	function log(message) {
		var logGR = new GlideRecord("sys_log")
		logGR.newRecord();
		logGR.setValue("message", message)
		logGR.setValue("level", "Info")
		logGR.insert();
	}
```

This means that any ```gs.log()```, ```gs.warning()```, ```gs.error()```, ```gs.debug()``` is a database transaction on the sys_log table.

When optimizing a script or performing code review, we as developers are hyper sensitive to the over usage of GlideRecord to ensure our production code is as quick and performant as possible. In contradiction to that mindset, we often we leave a number ```gs.log()```'s or ```gs.info()```'s in that same script, negating some or all of our optimization work in the process.

Mostly, we do this in good faith to increase the observability of our applications. Other times the logs are left as a relic of our debugging efforts we made as we developed our applications. They were never meant to be in production.

Let's dive into some best practices we can use that actually have a positive impact on our ability to monitor and observe while minimizing the impact to the performance of ServiceNow and our applications.

## Toggle your logs.

This is probably the quickest and easiest way to reduce the volume of logs being written in production without impacting your ability to leverage those logs _when needed_.

Consider the following script. We'll update it over the course of this article to showcase different approaches.

```javascript
try {
  var request = new sn_ws.RESTMessageV2();
  request.setEndpoint("https://api.twitter.com/2/tweets");
  request.setHttpMethod("POST");
  request.setRequestBody({
    text: "I'm tweeting from ServiceNow!"
  })


  var response = request.execute();
  var responseBody = JSON.parse(response.getBody());
  var httpStatus = response.getStatusCode();

  gs.info("httpStatus" + httpStatus)
  gs.info("responseBody" + responseBody)

  return responseBody;
} catch (ex) {
  gs.error(ex.message())
}
```

This fictional example sends a REST message to twitters API to post a tweet. It has a logging pattern that I see quite often when review integration code.

While implementing a new feature, the dev uses a couple of ```gs.info()```'s to help them debug their script.

The developer also includes an ```gs.error()``` to capture if something goes wrong with the request.

After the developer finishes the feature of allowing users to tweet from ServiceNow, they forget to strip their informational/debugging log statements.

The user's of the feature end up loving the developers handy work and on the first day of release they cumulatively post 1,000 tweets using ServiceNow.

Without knowing it, this developer introduced **2,000** new database transactions on average per day to the instance.

Now imagine this situation takes place over multiple developers in multiple applications over a number of years in the lifetime of your instance. You can see how this can get out of hand fast if we don't have a strategy for our logs.

I have seen logs like the one above generate as many as 300,000+ logs/db transactions per day for a single new feature.

Let's explore the toggle architecture to reduce these two logs from constantly running in the background.

It is highly likely it's only useful to view the httpStatus and responseBody variables when something may not be working correctly. If all is going well, informational logs only end up muddying up our logs and reduce their ability to convey meaningful information.

We can create a system property for our Twitter application that when turned on will add additional logs to the system for our application. When turned off the logs will not be captured.

In your application create a system property of type true/false. I typically name them something like ```twitter_spoke.raised_logging_enabled```.

Then in our code we can wrap our logs in an ```if``` statement that returns whether or not or "heightened logs" are turned on.

```javascript
  //properties only store strings so we have to check against the string value "true"

  if(gs.getProperty("twitter_spoke.raised_logging_enabled") === "true"){
  	gs.info("httpStatus" + httpStatus)
  	gs.info("responseBody" + responseBody)
  }
```

This method keeps these log messages at bay until the moment we need them! And since it's configurable system property, we don't need to modify code to make the toggle.

## Let's get verbose.

Setting logging verbosity is a similar architecture that can reduce the amount of logs until you need them. By default scoped applications have the ability to set a system property called ```scope_name.logging.verbosity``` . This property tells the system what log levels to write to the database.

The logging levels in order of priority are.

1. Error (Something went wrong)
2. Warning (Something may not be right)
3. Information (Matter's of fact)
4. Debug (Help find and resolve bugs)

By setting verbosity to one of those 4 choices, we can tell the system to only write logs of a certain  type(s). For example, if you choose "Warning", the system will write all `gs.warn()` and `gs.error()`.

If you choose "Debug", the system will write all `gs.debug()`, `gs.info()`, `gs.warning()`, `gs.error()`

In short, **the logging verbosity you choose will include that level and all higher priority logs above it**.

To refactor our code we could  set our applications verbosity to "error" and change our `gs.logs()` to `gs.debug()`

```javascript
try {
  var request = new sn_ws.RESTMessageV2();
  request.setEndpoint("https://api.twitter.com/2/tweets");
  request.setHttpMethod("POST");
  request.setRequestBody({
    text: "I'm tweeting from ServiceNow!"
  })

  var response = request.execute();
  var responseBody = JSON.parse(response.getBody());
  var httpStatus = response.getStatusCode();

  gs.debug("httpStatus" + httpStatus)
  gs.debug("responseBody" + responseBody)

  return responseBody;
} catch (ex) {
  gs.error(ex.message())
}
```

This way our warning and errors still get logged but our debugs will only begin capturing when we change the system property set start recording that level.

## Log sourcing

We've tackled the performance issue with logs so let's dive into some area's that will increase the effectiveness of our logs.

Having well constructed logs will make it easier for you to monitor and observe the status of your applications, find relevant log messages in the haystack that is the sys_log table, and ultimately resolve issues faster.

Log sourcing is simply the addition of a qualifier to your logs so that you can group similar log messages.

In my example I would add a source of "Twitter Spoke Rest Messages" as a second parameter to my log functions so that I can easily group all logs by that source.

```javascript
try {
  var request = new sn_ws.RESTMessageV2();
  request.setEndpoint("https://api.twitter.com/2/tweets");
  request.setHttpMethod("POST");
  request.setRequestBody({
    text: "I'm tweeting from ServiceNow!"
  })


  var response = request.execute();
  var responseBody = JSON.parse(response.getBody());
  var httpStatus = response.getStatusCode();

  gs.debug("httpStatus" + httpStatus, "Twitter Spoke Rest Messages")
  gs.debug("responseBody" + responseBody,  "Twitter Spoke Rest Messages")

  return responseBody;
} catch (ex) {
  gs.error(ex.message(), "Twitter Spoke Rest Messages")
}
```

## Make messages matter.

Something to consider when logging error or information is what you might do with that information once it's logged in production?

Is the purpose just to know something is running? Is it to better understand the state of an application? Is it to help you debug errors when something fails?

Knowing the purpose can help you craft a more effective message that future you will be grateful for when your debugging a production issue at 5am.

Let's consider a few situations for my Tweets features.

### I want to know if my code is even running.

In this case my message should read to answer this question

```javascript
try {
 if(gs.getProperty("twitter_spoke.raised_logging_enabled") === "true"){

  	gs.debug("Starting attempt to POST tweet to https://api.twitter.com/2/tweets", "Twitter Spoke Rest Messages" )

  }

  var request = new sn_ws.RESTMessageV2();
  request.setEndpoint("https://api.twitter.com/2/tweets");
  request.setHttpMethod("POST");
  request.setRequestBody({
    text: "I'm tweeting from ServiceNow!"
  })
 ...
```

### I want to know if my code is working correctly.

```javascript
try {
  var request = new sn_ws.RESTMessageV2();
  request.setEndpoint("https://api.twitter.com/2/tweets");
  request.setHttpMethod("POST");
  request.setRequestBody({
    text: "I'm tweeting from ServiceNow!"
  })


  var response = request.execute();
  var responseBody = JSON.parse(response.getBody());
  var httpStatus = response.getStatusCode();

  var debugMessage = JSON.stringify({
  	endpoint: "https://api.twitter.com/2/tweets"
  	whoIsTweeting: gs.getUser(),
	httpStatus: httpStatus,
	responseBody: responseBody
  })

  gs.debug(debugMessage, "Twitter Spoke Rest Messages")

  return responseBody;

 ...
```

This pattern of wrapping your debug message into a formatted JSON object helps us reduce the amount of logs written to the DB while telling a complete story about what happened in that particular REST Message.

Including additional information like who was trying to Tweet is helpful to our future selves as it can help determine any access related issues.

### I want to know if my code is not working.

This is the single most important time we want our log messages to be as descriptive as possible. We need vital information that will help us determine what the root cause of the issue is.

```javascript
try {
	...
} catch (ex) {
  var errorMessage = JSON.stringify({
    whoIsTweeting: gs.getUser(),
    endpoint: "https://api.twitter.com/2/tweets",
    httpMethod: request.getHttpMethod(),
    requestBody: request.getRequestBody(),
    httpStatus: httpStatus,
    responseBody: responseBody
    errorMessage: ex.message()
  })

  gs.error(errorMessage, Twitter Spoke Rest Messages")
}
```

This is where we throw the kitchen sink at the message so we can understand who sent the tweet, what the tweet consisted of, the http status, and the error message. We can get all this information in a *single* well formatted log.

A good error log message should give you the ability to fully understand the context of the code that produced it, so that you can recreate the issue to the best of your abilities in a safe environment.

High quality logging is as equal of an investment into your applications as having high code coverage. It is vital to the health and performance of both your application and the ServiceNow system.
