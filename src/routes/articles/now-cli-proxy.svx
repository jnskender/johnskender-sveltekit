---
layout: article
title: How to use the ServiceNow CLI behind a proxy server
socialImage: /media/now-cli-proxy.png
isPublished: true
createdOn: 2021-05-08
updatedOn: 2021-05-08
slug: "now-cli-proxy"
seoTitle: "Learn how you can utilize this new tool in the high chance that your company tunnels all of their traffic through a proxy server. "
---

The ability to utilize modern tooling introduced by ServiceNow (UI Builder, Now Experience) relies on the ability to access another foundational tool, the ServiceNow CLI. This article details how to utilize the CLI if your connection relies on a proxy server.

## The Problem

I won't dive into detail on what the CLI is in this article. This article's main purpose is to fill a gap that the ServiceNow product team has introduced with the CLI. In it's current state as of writing this article (05-08-2021) the CLI does not allow you to connect to an instance if your web traffic is routed through a proxy server. This is both surprising and very frustrating as many ServiceNow customer's are in the corporate environment where this is basically standard practice.

Most modern tooling will utilize your local env variables of `http_proxy` and `https_proxy` to ensure that the traffic is routed through your desired proxy. The CLI will not honor these env variables when making connections to the instance. I have spoken with ServiceNow support and they have acknowledge they are aware of this limitation and also have no current plans to alleviate this issue for their customers.

This led me down a path to find a solution on my end so that myself and my development team have the opportunity to leverage these new tools to create new UI experiences for our consumers.

I'll outline the steps I've taken to provide temporary relief below and preface that it's not an ideal long term solution and may be a little cumbersome for some who may not be comfortable in their terminal. This solution is also purely dedicated to MacOS but hopefully the idea's can be easily replicable in other OS's.

## The Solution

Luckily we can make a few modifications to the NOW CLI source code to ensure that all of it's https connections are tunneled through your desired proxy.

Unluckily is you have to do this every-time you update the CLI and that it's possible this solution may break with future versions.

### Step 1 : Download the SNC CLI

You can follow ServiceNow's documentation for getting the SNC CLI downloaded to your machine. If you've found this article you will most likely already have it downloaded.

### Step 2 : Try logging into your instance

One of the first things you'll need to do to use the CLI is to make an initial connection to your desired instance using the command `snc configure profile set`. This will walk you through a few questions (instance url, username, password, etc) and then try to connect to your instance. If this is successful there's no need to continue these steps, this means your traffic is hitting the instance correctly and you don't need to worry about proxy configurations.

If this step times out with error

`connect ETIMEDOUT INSTANCEIPADDRESS:443`

This is most likely because your traffic needs to be routed through your proxy to be allowed to find it's way to your instance.

### Step  3: Get to the source

You'll need to have the ui-component extension installed to get access to the source. You can install the extension with

`snc extension add --name ui-component`

From here we'll need to open the source code that was stored on your root user folder as a result of the above command. The path on mac looks like

`/Users/username/.snc`

.snc is a configuration folder known as a "[dotfile](https://wiki.archlinux.org/title/Dotfiles)". Because of this your finder/explorer will not show it by default. To show dotfiles in Mac's Finder window you can use the shorcut `command shift .`

Even easier, if you have visual studio code installed, is to run the following command to open the folder in VS code: `code ~/Users/username/.snc`. This will open the folder at that path in VS code.

### Step 4: Modify the source

In your editor we need to find one file in particular. The relative path to this file at the time of writing is

`.extensions/ui-component/node_modules/@servicenow/cli/src/index.js`

This file is basically the initializer for all of the code that runs as part of the CLI. From here the fix is relatively simple and I'll explain why it works after this section.

On line 24 of `index.js` you'll find a short snippet of code that basically initializes the CLI. It looks like this:

`const r=require("./runner");const{cli:n}=r;n.argv;`

We basically need to add a new line of code directly after this line. That line of code looks like this

`const { bootstrap } = require("global-agent"); bootstrap();`

You then just need to save that file.

### Step 5 : Set your proxy

The npm package above, [global-agent](https://github.com/gajus/global-agent), is a relatively simple package that overrides the agent option on requests that utilize http.request internally. You won't even need to install it because ServiceNow is already using this package elsewhere in the source.

ServiceNow is using a library, [got](https://github.com/sindresorhus/got), to make their http requests to the instance. This library is utilizing http.request under the hood which is why global-agent bootstrap works!

global-agent relies on an environment variable in your terminal to know which proxy server to use. You'll need to add this to your bash/zsh profile to have it persist or just type this command every session.

```export GLOBAL_AGENT_HTTP_PROXY=http://127.0.0.1:8080```

You'll obviouslly need to set this variable to your desired host.

### Step 6 : Test again
After doing the above, the global-agent package should now be ensuring all http traffic that is sent from the cli is routed through the proxy server you defined in ```GLOBAL_AGENT_HTTP_PROXY```. Go ahead and try to login to the instance with

```snc configure profile set```

again and it should be able to complete!


## Longterm

Obviously this is not a great developer experience and is hardly a long term solution. As I mentioned I have made the product team aware of this limitation but I hope that anyone who finds this useful will [upvote my feature request over on the ServiceNow idea portal](https://community.servicenow.com/community?id=view_idea&sysparm_idea_id=faa4c3b81b0430d0a17c62c4bd4bcbc5&sysparm_idea_table=x_snc_com_ideation_idea&sysparm_module_id=enhancement_requests).
