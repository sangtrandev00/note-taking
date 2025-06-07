---
layout: default
title: Backend
parent: Technical
nav_order: 8
has_children: false
---

# Backend Development
{: .fs-8 }

Server-side development, APIs, frameworks, and backend architecture.
{: .fs-6 .fw-300 }

---

## Recent Backend Posts

{% assign backend_posts = site.posts | where_exp: "post", "post.categories contains 'backend' or post.tags contains 'nestjs' or post.tags contains 'nodejs' or post.tags contains 'api'" %}
{% for post in backend_posts limit: 15 %}

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

## Browse by Framework

### NestJS
{% assign nestjs_posts = site.posts | where_exp: "post", "post.tags contains 'nestjs'" %}
{% for post in nestjs_posts limit: 10 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

### NodeJS Core
{% assign nodejs_posts = site.posts | where_exp: "post", "post.tags contains 'nodejs' and post.title contains 'NodeJS'" %}
{% for post in nodejs_posts limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

### APIs & Microservices
{% assign api_posts = site.posts | where_exp: "post", "post.tags contains 'api' or post.title contains 'microservices' or post.title contains 'API'" %}
{% for post in api_posts limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

