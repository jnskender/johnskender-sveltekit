---
  layout: article
  title: "Use moment.js in ServiceNow"
  seoTitle: "Learn how to use one of the most popular third party libraries,
  moment.js, in ServiceNow. You'll be able to utilize handy date utilities in
  client scripts, business rules, and script includes after this guide."
  isPublished: true
  seoImage: "/open-graph-images/moment-open-graph.webp"
  slug: "moment-servicenow"
  createdOn: 2020-09-22
  updatedOn: 2020-09-22
---

<script>

</script>

As most developers know, working with dates, time, and timezones can be one of the most frustrating aspects of any program. ServiceNow includes some decent out of box [API's for working with GlideDateTime objects](https://developer.servicenow.com/dev.do#!/reference/api/orlando/server_legacy/c_GlideDateTimeAPI?navFilter=glidedatetime), but often you'll find that they aren't quite as robust as you'd like.

When GlideDateTime methods don't quite cut it, we can rely on the world's most popular library for parsing, validating, and manipulating dates and time in javascript: [Moment.js](https://momentjs.com/)


It's fairly quick to get started using moment.js in both client and server side code. We'll walk through the process of getting it installed and briefly show how you can create a moment object from a GlideDateTime field and vice versa.

UI scripts will make the library available in the client (UI policies, UI actions, Client Scripts, etc) and Script Includes will make it available in Server code (Other Script Includes, Business Rules, Fix Scripts, etc).

## Using Moment Client Side

### UI Script Setup

Navigate to https://momentjs.com/downloads/moment.min.js and copy the entirety of the minified library.

Create a new [UI Script](https://docs.servicenow.com/bundle/orlando-application-development/page/script/client-scripts/concept/c_UIScripts.html) in your instance and paste the contents of the script into the script field.

Setup your UI Script with the following options:

* Global = false ```//Only use global UI scripts when you are willing to accept the performance implications of loading the UI script on every page for every user```
* UI Type = Desktop ```//This will make it available everywhere but mobile and Service Portal```
* Active = true
* Name = moment.js

### Usage

When this ```sys_ui_script``` record is inserted into ServiceNow, ServiceNow performs a little bit of undocumented magic.

It hosts the code directly on the instance and appends the ```.jsdbx``` to it.

So in my test instance I can view the source code I uploaded by navigating to
```https://myinstance.service-now.com/moment.js.jsdbx```

To access moment in a client script via this UI action we're going to leverage an out of the box global API: [ScriptLoader](https://docs.servicenow.com/bundle/rome-application-development/page/app-store/dev_portal/API_reference/ScriptLoader/concept/c_ScriptLoaderAPI.html#c_ScriptLoaderAPI).

```ScriptLoader.getScripts()``` is an [async function](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/async_function) that takes two parameters

1. An array of scripts or a single string of the script you want to load.
2. A callback function that runs when the function is finished loading your script.

**Note**: You need to add the extension .jsdbx to the name of your UI script for Script loader to find it. This is undocumented and is a large source of confusion for most users of the API.

To test this, open the [javascript executor](https://community.servicenow.com/community?id=community_blog&sys_id=5f2de6e5dbd0dbc01dcaf3231f961936)

* For Mac press `Ctrl+Shift+j`
* For Windows press `Alt+Ctrl+Shift+j`

In the [executor](https://community.servicenow.com/community?id=community_blog&sys_id=5f2de6e5dbd0dbc01dcaf3231f961936) window type

```js
ScriptLoader.getScripts('moment.js.jsdbx', function () {
  console.log("Today's date: " + moment().format())
});
```


then click "Run my code"

If everything was installed successfully you should see the below output in your browser's console.

`Todays date: 2020-08-29T12:36:02-05:00`

## Server Side

Navigate to https://raw.githubusercontent.com/jnskender/Moment-ServiceNow/master/moment.min.js and copy the entirety of the minified library.

Create a new [Script Include](https://docs.servicenow.com/bundle/paris-application-development/page/script/server-scripting/concept/c_ScriptIncludes.html)   (sys_script_include) and name it "moment.min.js".

Delete all auto generated code from the new script include.

Paste the contents of the minified library to the script include.


To test that we've correctly made this available on the server open a [background script](https://developer.servicenow.com/blog.do?p=/post/training-scriptsbg/) window or an [xplore window](https://developer.servicenow.com/connect.do#!/share/contents/9650888_xplore_developer_toolkit?t=PRODUCT_DETAILS).

```js
gs.include("moment.min.js");//makes the code available to our script

gs.print(moment().format()); //prints todays date in standard format
```

You should see similar output to below if the script include was successfully configured.

`2020-08-29T10:57:07-07:00`

## Basic Usage

To show you how you can get started using moment in relation to ServiceNow, we'll go through a brief example of creating a moment instance from a GlideDateTime field, modify the instance using some common moment functions, and update that field with the modified time.

To get started open a [background script](https://developer.servicenow.com/blog.do?p=/post/training-scriptsbg/) window or an [xplore window](https://developer.servicenow.com/connect.do#!/share/contents/9650888_xplore_developer_toolkit?t=PRODUCT_DETAILS).

First we need to grab a record from the system that has at least one column of type Date/Time. Change Request has one out of the box called Planned Start Date (start_date). Lets grab a change that has that value populated.

```js
var changeGR = new GlideRecord("change_request");
//make sure we get a change that has a populated start_date
changeGR.addNotNullQuery("start_date");
//we only need one so let's use best practice to limit our query to 1 to increase performance
changeGR.addLimit(1);
changeGR.query();
if (changeGR.next()) {
  gs.print(changeGR.getValue("number"));
}
```

In this case we're just printing out the number to make sure we have a record that meets that condition. If you don't, please create a change and fill out that field to meet the above conditions.

Inside of your `if` statement we'll then need to create a moment instance by passing in the raw value of start date. Because ServiceNow stores date times as UTC internally, we will need to specify to moment that we are parsing a UTC value.

```javascript
var startDate = moment.utc(changeGR.getDisplayValue());
```

The moment library is smart enough to understand the format of GlideDateTimes display value so we don't need to explicitly set it.

Printing the value `startDate.format()` should return the moment formatted string:

`2020-10-20T07:30:00-07:00`

Now that we have a moment instance we can easily adjust the time to our liking using moments built in manipulation methods such as add and subtract.

To show how we can manipulate time, we'll add 1 day and subtract 2 hours.

```javascript
startDate.add("1", "d").subtract("2", "h");
gs.print(startDate.format())//2020-10-21T05:30:00-07:007
```

Now if we want to actually save that new value to the change record we need to format the value so that ServiceNow can recognize it. ServiceNow stores raw date values as UTC in the following format `"YYYY-MM-DD HH:mm:ss"`

We can use moments `format()` method with this format to ensure we are passing the correctly formatted value. Updating the change record would look like:

```javascript
changeGR.setValue("start_date", startDate.format("YYYY-MM-DD HH:mm:ss"));
changeGR.update();
```

If we run this script in the background we should see the UI show that Planned start has had 1 day added and 2 hours subtracted.


The final script should look similar to this:

```javascript
gs.include("Moment");

var changeGR = new GlideRecord("change_request");
//make sure we get a change that has a populated start_date
changeGR.addNotNullQuery("start_date");
//we only need one so let's use best practice to limit our query to 1 to increase performance
changeGR.addLimit(1);
changeGR.query();
if (changeGR.next()) {

  //populate a moment object from the change records start time
  var startDate = moment.utc(changeGR.getValue("start_date"));

  //use moment to manipulate the day, hour, etc to our use case
  startDate.add("1", "d").subtract("2", "h");

  //updat the value of our change requests start date to our manipulated moment time
  changeGR.setValue("start_date", startDate.format("YYYY-MM-DD HH:mm:ss"));

  changeGR.update();
}
```

You can learn more about how to format and manipulate time using moment from [their own documentation](https://momentjs.com/).

**Note**
The maintainers of moment have declared the [project will no longer be receiving major updates.](https://momentjs.com/docs/#/-project-status/) This is mainly due to the fact that the new [Intl](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Intl) is now available and provides similiar functionality.

ServiceNow is still stuck on es5 javascript runtime so I still believe that moment is the current best option for time manipulation and formatting in ServiceNow.

These principles should apply to any 3rd party libraries such as lodash or Underscore.js