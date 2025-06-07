---
layout: default
title: OOP
parent: Technical
nav_order: 4
has_children: false
---

# Object-Oriented Programming
{: .fs-8 }

OOP concepts, principles, and best practices.
{: .fs-6 .fw-300 }

---

## Recent OOP Posts

{% assign oop_posts = site.posts | where_exp: "post", "post.categories contains 'OOP' or post.categories contains 'oop' or post.tags contains 'oop' or post.title contains 'OOP' or post.title contains 'constructor' or post.title contains 'overloading' or post.title contains 'overriding' or post.title contains 'inheritance' or post.title contains 'polymorphism'" %}
{% for post in oop_posts limit: 15 %}

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

## Browse by Concept

### Core Concepts
{% assign core_posts = site.posts | where_exp: "post", "post.title contains 'constructor' or post.title contains 'class' or post.title contains 'object'" %}
{% for post in core_posts limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

### Inheritance & Polymorphism
{% assign poly_posts = site.posts | where_exp: "post", "post.title contains 'overloading' or post.title contains 'overriding' or post.title contains 'inheritance' or post.title contains 'polymorphism'" %}
{% for post in poly_posts limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

### Design Principles
{% assign principle_posts = site.posts | where_exp: "post", "post.title contains 'SOLID' or post.title contains 'principle' or post.title contains 'encapsulation'" %}
{% for post in principle_posts limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

