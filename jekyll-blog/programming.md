---
layout: default
title: Programming
parent: Technical
nav_order: 7
has_children: false
---

# Programming
{: .fs-8 }

Programming languages, concepts, and best practices.
{: .fs-6 .fw-300 }

---

## Recent Programming Posts

{% assign programming_posts = site.posts | where_exp: "post", "post.categories contains 'programming' or post.tags contains 'javascript' or post.tags contains 'typescript' or post.tags contains 'nodejs'" %}
{% for post in programming_posts limit: 15 %}

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

## Browse by Language

### JavaScript
{% assign js_posts = site.posts | where_exp: "post", "post.tags contains 'javascript'" %}
{% for post in js_posts limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

### TypeScript
{% assign ts_posts = site.posts | where_exp: "post", "post.tags contains 'typescript'" %}
{% for post in ts_posts limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

### NodeJS
{% assign node_posts = site.posts | where_exp: "post", "post.tags contains 'nodejs'" %}
{% for post in node_posts limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

