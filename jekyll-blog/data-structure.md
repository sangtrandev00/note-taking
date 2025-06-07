---
layout: default
title: Data Structure
parent: Technical
nav_order: 1
has_children: false
---

# Data Structure
{: .fs-8 }

Data structures, algorithms, and problem-solving techniques.
{: .fs-6 .fw-300 }

---

## Recent Data Structure Posts

{% assign ds_posts = site.posts | where_exp: "post", "post.categories contains 'data-structure' or post.tags contains 'algorithm' or post.tags contains 'data-structure' or post.title contains 'LinkedList' or post.title contains 'HashMap' or post.title contains 'Queue' or post.title contains 'Stack' or post.title contains 'Tree' or post.title contains 'Graph'" %}
{% for post in ds_posts limit: 15 %}

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

### Arrays & Lists
{% assign array_posts = site.posts | where_exp: "post", "post.title contains 'Array' or post.title contains 'LinkedList' or post.title contains 'List'" %}
{% for post in array_posts limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

### Trees & Graphs
{% assign tree_posts = site.posts | where_exp: "post", "post.title contains 'Tree' or post.title contains 'Graph' or post.title contains 'BFS' or post.title contains 'DFS'" %}
{% for post in tree_posts limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

### Hash Tables & Maps
{% assign hash_posts = site.posts | where_exp: "post", "post.title contains 'Hash' or post.title contains 'Map' or post.title contains 'Set'" %}
{% for post in hash_posts limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

### Stacks & Queues
{% assign stack_posts = site.posts | where_exp: "post", "post.title contains 'Stack' or post.title contains 'Queue'" %}
{% for post in stack_posts limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

