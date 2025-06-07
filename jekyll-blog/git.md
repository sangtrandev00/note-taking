---
layout: default
title: Git
parent: Technical
nav_order: 5
has_children: false
---

# Git & Version Control
{: .fs-8 }

Git commands, workflows, and version control best practices.
{: .fs-6 .fw-300 }

---

## Recent Git Posts

{% assign git_posts = site.posts | where_exp: "post", "post.categories contains 'git' or post.tags contains 'git' or post.title contains 'Git' or post.title contains 'GitHub' or post.title contains 'SSH' or post.title contains 'merge' or post.title contains 'reset'" %}
{% for post in git_posts limit: 15 %}

### [{{ post.title }}]({{ post.url }})
{: .fs-6 }

**Categories:** {{ post.categories | join: " → " }}
{: .fs-3 .text-grey-dk-000 }

**Tags:** {% for tag in post.tags %}{{ tag }}{% unless forloop.last %}, {% endunless %}{% endfor %}
{: .fs-3 .text-grey-dk-000 }

**Date:** {{ post.date | date: "%B %d, %Y" }}
{: .fs-3 .text-grey-dk-000 }

{{ post.excerpt | strip_html | truncatewords: 25 }}

[Read more →]({{ post.url }}){: .btn .btn-outline .btn-sm }

---

{% endfor %}

## Browse by Topic

### Git Basics
{% assign basic_posts = site.posts | where_exp: "post", "post.title contains 'Git'" %}
{% for post in basic_posts limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

### GitHub & Remote
{% assign github_posts = site.posts | where_exp: "post", "post.title contains 'GitHub' or post.title contains 'SSH' or post.title contains 'remote'" %}
{% for post in github_posts limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

### Advanced Git
{% assign advanced_posts = site.posts | where_exp: "post", "post.title contains 'Graph' or post.title contains 'workflow' or post.title contains 'branch'" %}
{% for post in advanced_posts limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

