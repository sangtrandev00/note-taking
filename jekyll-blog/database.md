---
layout: default
title: Database
parent: Technical
nav_order: 6
has_children: false
---

# Database
{: .fs-8 }

Database design, optimization, queries, and database management.
{: .fs-6 .fw-300 }

---

## Recent Database Posts

{% assign db_posts = site.posts | where_exp: "post", "post.categories contains 'database' or post.tags contains 'database' or post.tags contains 'mongodb' or post.tags contains 'mysql' or post.tags contains 'sql' or post.title contains 'Database' or post.title contains 'MongoDB' or post.title contains 'SQL' or post.title contains 'Index'" %}
{% for post in db_posts limit: 15 %}

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

## Browse by Database Type

### MongoDB
{% assign mongo_posts = site.posts | where_exp: "post", "post.title contains 'MongoDB' or post.title contains 'Mongoose' or post.tags contains 'mongodb'" %}
{% for post in mongo_posts limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

### SQL & MySQL
{% assign sql_posts = site.posts | where_exp: "post", "post.title contains 'SQL' or post.title contains 'MySQL' or post.tags contains 'sql' or post.tags contains 'mysql'" %}
{% for post in sql_posts limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

### Database Design
{% assign design_posts = site.posts | where_exp: "post", "post.title contains 'Index' or post.title contains 'Design' or post.title contains 'Optimization' or post.title contains 'Performance'" %}
{% for post in design_posts limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

### Transactions & ACID
{% assign transaction_posts = site.posts | where_exp: "post", "post.title contains 'Transaction' or post.title contains 'ACID' or post.title contains 'Lock'" %}
{% for post in transaction_posts limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

