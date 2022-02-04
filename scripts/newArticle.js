/*
   scripts/newPost.js

   A script for scaffolding markdown posts:

   - Prompts for required metadata (title, tags, etc..)
   - Generates a file name based on title
   - Opens in fav. editor
   Add script to package.json:

   ```
   "scripts": {
     "post:new": "node scripts/newPost.js"
   }
   ```
*/
import slugify from 'slugify'
import readline from 'readline-promise'
import fs from 'fs'
import child_process from 'child_process'


// prompt to collect title and tags
async function prompt() {
  const rl = readline.default.createInterface({
    input: process.stdin,
    output: process.stdout
  })

  const title = await rl.questionAsync('title: ')
  const shortDescription = await rl.questionAsync('Short Description: ')

  rl.close()

  return { title, shortDescription }
}

// generate the markdown file with frontmatter
async function generate(path, { title, date, shortDescription, permalink }) {
  const template = `---
layout: article
title: ${title}
createdOn: ${date}
updatedOn: ${date}
author: John Skender
isPublished: true
shortDescription: ${shortDescription}
seoTitle: ${shortDescription}
slug: ${permalink}
seoImage: "/open-graph-images/${permalink}.jpg"
---
## Heading
content here`

  await fs.promises.writeFile(path, template)
}

// open the file in your favorite editor
function openEditor(path) {
  const editor = "code"

  child_process.spawn(editor, [path], {
    stdio: 'inherit'
  })
}

// prompt for title and tags
const { title, shortDescription } = await prompt()
// generate a permalink version of the title
const permalink = slugify(title, { lower: true })
// turn permalink into file path
const path = `src/routes/articles/${permalink}.svx`
// default date to today
const date = new Date().toISOString().split('T')[0]

// write the template to the file system
await generate(path, { title, shortDescription, date, permalink })

console.log(`+ created: ${path}`)

// open it up and start editing!
openEditor(path)