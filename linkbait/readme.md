LinkBait
========

LinkBait is a place to store/save your links.

How it works
------------
LinkBait works in two ways, the casual user and the programmer way.

*Casual Users*
1. Bookmark [this page](/incubator/linkbait/?/add) and then fill out the form.

2. The first time you add a link an email is sent to your address. This email contains a "validation" link. Click it. Until you click the validation link
your link doesn't appear. When you do, it magically shows up on our front-page (unless you said "make private").

3. Visit that link again to add more links, or just add the API-KEY that appears in that email to the API-KEY section on [this page](/incubator/linkbait/?/add).

*Programmers*

1. Create a JSON object that resembles the following. All items marked with a * are mandatory.
    - *email: yourmeailaddress@whatever.you.want
    - apikey: It was emailed to you. Leave it blank if its your first time.
    - *text: [what you're trying to post]
    - *type: one of [video,image,snippet]
    - *rating: one of [SWF,NSFW]
    - tags: up to 5 tags passed like this [tag1,tag2,tag3,tag4,tag5]
    - category: one of [uncategorized,funny,news]
2.  POST that object to /links/[md5-of-your-object]
3.  Profit

<small>For more information, read the [API](/incubator/linkbait/?/api)</small>

Terms of Use
------------
You own your own stuff. If someone has a problem with it, they take it up with you. There's also a three strike policy regarding the following:

- Posting illegal material
- Harassing users

There is also a two strike policy on the following, just incase you were drunk the first time:

- being a douchebag

Violation of either policy means an IP ban, not just an email address. If you think you were unfairly banned, send an email to us. Bans only affect
adding new links, not visiting the website.

Features
------------
- Save your links "in the cloud"
- Public sharable links
- API built on those little things we call OPEN STANDARDS


What you pay for
------------
- Erm.. I haven't figured this part out yet. Just hit the donate button and lets hope it doesn't come to this.