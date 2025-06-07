---
layout: default
title: Technical Posts
parent: Technical
nav_order: 1
---

# Technical Posts
{: .fs-9 }

All technical notes and documentation organized by topic.
{: .fs-6 .fw-300 }

---

## Recent Technical Posts

{% assign technical_posts = site.posts | where_exp: "post", "post.categories contains 'technical'" %}
{% for post in technical_posts limit: 20 %}

### [{{ post.title }}]({{ post.url }})
{: .fs-6 }

**Categories:** {{ post.categories | join: " → " }}
{: .fs-3 .text-grey-dk-000 }

**Tags:** {% for tag in post.tags %}{{ tag }}{% unless forloop.last %}, {% endunless %}{% endfor %}
{: .fs-3 .text-grey-dk-000 }

**Date:** {{ post.date | date: "%B %d, %Y" }}
{: .fs-3 .text-grey-dk-000 }

{{ post.excerpt | strip_html | truncatewords: 30 }}

[Read more →]({{ post.url }}){: .btn .btn-outline }

---

{% endfor %}

## Browse by Topic

### Backend Development
{% assign backend_posts = site.posts | where_exp: "post", "post.categories contains 'backend' or post.tags contains 'nodejs' or post.tags contains 'nestjs'" %}
{% for post in backend_posts limit: 10 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

### Database
{% assign db_posts = site.posts | where_exp: "post", "post.categories contains 'database' or post.tags contains 'mongodb' or post.tags contains 'mysql'" %}
{% for post in db_posts limit: 10 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

### Algorithms & Data Structures
{% assign algo_posts = site.posts | where_exp: "post", "post.categories contains 'algorithm' or post.tags contains 'algorithm'" %}
{% for post in algo_posts limit: 10 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

### Programming Concepts
{% assign prog_posts = site.posts | where_exp: "post", "post.categories contains 'programming' or post.tags contains 'typescript' or post.tags contains 'javascript'" %}
{% for post in prog_posts limit: 10 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

