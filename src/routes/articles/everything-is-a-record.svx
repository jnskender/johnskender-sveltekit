---
  layout: article
  title: "Everything is a Record"
  seoTitle: "What is the most important thing a ServiceNow developer should know? Everything in ServiceNow is a record."
  isPublished: true
  seoImage: "/open-graph-images/everything-is-a-record.jpg"
  slug: "everything-is-a-record"
  createdOn: 2022-01-07
  updatedOn: 2022-01-07
---

If I had to instill one foundational understanding in a new ServiceNow developer, it would be that **_everything_ in ServiceNow is a Record**.

Why is it that I find this to be vital to a developers understanding of the ServiceNow platform? First let's take a step back and what I mean by "Record" and why this concept is, in my opinion, what led me to be a much more productive developer.

## What is a Record
When I refer to a Record, I simply mean a row in a table within a database. When you log in to Facebook, Instagram or Reddit, your account information is a record. That data is stored in a database that contains columns of information about you such as your username, your email address, or your password. Your account record is then associated with other records such as your posts, the post you like, and the people you follow. All of which are just more records on different tables.

## So what? That's how most web technologies store data?
It's true, almost everything you interact with on the web that persists in any way is stored as a record in a database. What makes ServiceNow so special? It takes the concept to the extreme.

With most major web app frameworks (Ruby on Rails, Next.js, Django), _information_ is stored in a database and _configurations_ as to how that application interacts with the user and the data, such as HTML, CSS, Javascript, API's, routing, etc, are stored in files on the file system of whatever server the application is hosted.

To add new features, developers would typically need to checkout a new branch in source control, create a series of files in a directory that deliver that feature, and push those files to the main branch.

This is where ServiceNow is foundationally different. Everything you write to build applications on ServiceNow is stored as a record and **not** a file.

In ServiceNow it is possible to build an entire full stack web application just by using a REST API.

## What all is stored as a record?
It would be much shorter to list the things that **aren't** stored as a record. But to belabor my point let's list a handful of things that are.

- Server side logic (Business Rules)
- Client side logic (Client Scripts)
- User Interface Elements
- System properties
- Outbound REST API calls
- Inbound REST API calls
- Security Policies (ACL's)
- Logs
- Notifications (emails, push messages)
- Mobile applications
- Credentials
- Tables are records
- Columns are records
- Angular Widgets
- A ServicePortal
- The CSS you write for a portal
- Workflows
- Workflow Activities
- Flow Designer actions
- Flow Designer flows

In essence, everything you need to build a full stack application.

## So what? Who cares how these things are stored?

The implications of this boils down to the limitless amount of freedom and possibility this gives you as a developer.

Another beneficial aspect of ServiceNow is that they give you an endless amount of ways to create and modify records.

If everything you need to build an application in ServiceNow is a record, and there is no limit to where and _how_ you can interact with a record, **you effectively have no limit to _what_ you can create**.


## Debugging and administration
This knowledge has also greatly increased my abilities to debug and resolve issues.

Let's take workflows for example. They seem to have a bit of magic to them. Well I must be no fun at parties because I'm about to spoil the trick for you.

 **Workflows aren't magic.**

 Those little lines you use to connect an activity to another one so your workflow can progress from and approval to a task? You guessed it.

 That line is a record.

 To be specific it's a column on a record but let's not get too hung up it.

Workflows are just a collection of records with columns that store what to do, when to do them, and what to do next when they're done.

Before I knew this, I figured a broken workflow was a lost cause. Might as well resubmit it. The magic is broken and the only way to restore it is to start the trick all over again. Wrong.

Because I now know everything is a record, I can identify where the workflow went wrong by looking at the correct record (wf_context), fix the issue underlying issue, the tell the workflow to try the activity (wf_history) again. No need to start from the beginning. I can use a surgeons knife where before I would use a sledgehammer.

## Takeaways
Once I understood this concept fundamentally it felt like I gained new superpowers.

- I could *build _anything_ on the platform*.
- I could *debug issues at light speed*.
