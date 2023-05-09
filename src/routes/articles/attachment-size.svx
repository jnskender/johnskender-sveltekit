---
layout: snippet
title: Find Total Size of ServiceNow Attachments
createdOn: 2023-06-09
updatedOn: 2023-06-09
author: John Skender
isPublished: true
shortDescription: Understand storage size of your attachments for tables in ServiceNow
seoTitle: Find Total Size of ServiceNow Attachments
slug: attachment-size
seoImage: "open-graph-images/attachment-size.png"
---
```javascript
var bytes = new global.GlideQuery("sys_attachment")
                .where("table_name", "ZZ_YYZZ_YYsys_user")
                .sum("size_bytes")
                .orElse(0)

var bytesInt = parseInt(JSON.stringify(bytes));


return bytesToSize(bytesInt);

function bytesToSize(bytes) {
   var sizes = ['Bytes', 'KB', 'MB', 'GB', 'TB'];
   if (bytes == 0) return '0 Byte';
   var i = parseInt(Math.floor(Math.log(bytes) / Math.log(1024)));
   return Math.round(bytes / Math.pow(1024, i), 2) + ' ' + sizes[i];
}
```