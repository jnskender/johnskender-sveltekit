---
layout: article
title: GlideAggregate, GlideQuery or GlideRecord?
createdOn: 2022-02-04
updatedOn: 2022-02-04
author: John Skender
isPublished: true
shortDescription: How would you check if a single record exists in ServiceNow?
seoTitle: How would you check if a single record exists in ServiceNow?
seoImage: "open-graph-images/using-glidequery-to-check-if-a-single-record-exists.jpg"
slug: using-glidequery-to-check-if-a-single-record-exists
---

**Question:** How would you script an API that returns whether the current logged in user has *at least one* active incidents assigned to them?

This is an extremely common pattern to code against when building applications in ServiceNow.

Let's look a few approaches first then we'll look discuss advantages/disadvantages of those approaches.

## GlideAggregate
```javascript
function userHasActiveIncident() {
  var incidentGA = new GlideAggregate("incident");
  incidentGA.addQuery("assigned_to", gs.getUserID());
  incidentGA.addActiveQuery();
  incidentGA.addAggregate("COUNT");

  incidentGA.query();
  incidentGA.next();

  var count = parseInt(incidentGA.getAggregate("COUNT"));
  return count > 0;

}
```
## GlideRecord
```javascript
function userHasActiveIncident() {
  var incidentGR = new GlideRecord("incident");
  incidentGR.addQuery("assigned_to", gs.getUserID());
  incidentGR.addActiveQuery();
  incidentGR.setLimit(1);
  incidentGR.query()
  return incidentGR.hasNext();
}
```

## GlideQuery
```javascript
function userHasActiveIncident() {
  return new global.GlideQuery("incident")
    .where("assigned_to", gs.getUserID())
    .where("active", true)
    .count() > 0;
}
```

## Commonality
All 3 of these scripts have a few things in common.

1. They create a [declarative](https://ui.dev/imperative-vs-declarative-programming/) API for other developers to use that abstracts the implementation details away.
2. The all have very similar performance.
3. They use common ServiceNow APIs that all developers should be familiar with.

If at the end of the day these approaches all solve the goal with similar performance impact, why would you need to choose?

Let's go over some differences in these approaches that effect both the readability and maintainability of this API.

## Differences

### Lines of Code (LOC)
I'll admit, this is generally a silly metric to compare approaches. Having fewer lines of code only matters if those lines convey the functionality clearly to reading developer. **Clear is better than clever**.

In this case I think it's a valid metric because I believe the intent of all three approaches equally clear. The fact that GlideQuery is able to be clear **with** fewer LOC's makes it the winner in this case.

### Maintainability
The maintainability *appears* to be equal across all three approaches.

Consider the requirements changed to make sure this API only includes active incidents where the state is Open. It would be trivial for a developer to update the API to account for this.

For the three approaches you would add

GlideAggregate - ```incidentGA.addQuery("state", "10");```

GlideRecord - ```incidentGR.addQuery("state", "10");```

GlideQuery - ```.where("state", 10);```

So these all have the same maintainability?

Absolutely Not!

In this case the developer made a mistake and the value for state for open on incident is actually `1`.

Both ```GlideRecord``` an ```GlideAggregate``` approaches don't care if you give it a bad value for state. The API will always return false due to this error. The developer may just think it's return false because the user doesn't have any when in reality it was a coding mistake.

```GlideQuery``` to the rescue! It doesn't allow you query against invalid choice values. It returns a descriptive error.
~~~~
Invalid choice '10' for field 'state' (table 'incident').
Allowed values:
[
  "1",
  "2",
  "3",
  "6",
  "7",
  "8"
]
~~~~

This gives the developer immediate and actionable feedback.

```GlideQuery``` wins on maintainability too!

## Other things to note

### Return Types
```GlideAggregate``` returns it's count as a string which is non intuitive for developers.

To account for this we had to use ```parseInt``` to be able to get the integer value.

```var count = parseInt(incidentGA.getAggregate("COUNT"));```

This is just an added step that the ```GlideAggregate``` makes us perform.


```GlideQuery``` does a great job across it's API to return primitive javascript types which makes a developers life much easier and makes our code more predictable.

### Feature parity
```GlideQuery``` still doesn't have support for encoded queries and may not match ```GlideRecord``` and ```GlideAggregate``` in feature set quite yet. I still make it a point to use GlideQuery first and only switch to GR or GA when GQ does not satisfy a use case.

### Mutability
When possible you should [prefer immutable API's over their mutable counterparts](https://gomakethings.com/mutable-vs.-immutable-in-javascript/).

```GlideQuery``` wins out in the case as well as it's the only API for interacting with ServiceNow records that is immutable.

This gives the added advantage of being able to reuse your GlideQueries in the same script as well as a codebase that's is more resilient to unintended side effects.

## Wrap Up
In most situations you should be reaching for GlideQuery when interacting with the database as it has a huge list of benefits.

* Standard JavaScript Typing
* Single API to query data and perform aggregations.
* Immutable
* Clearer, modern, concise syntax
* Safer queries with clearer error handling
