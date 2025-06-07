---
layout: default
title: Design Pattern
parent: Technical
nav_order: 2
has_children: false
---

# Design Pattern
{: .fs-8 }

Software design patterns and architectural principles.
{: .fs-6 .fw-300 }

---

## Recent Design Pattern Posts

{% assign pattern_posts = site.posts | where_exp: "post", "post.categories contains 'design-pattern' or post.tags contains 'pattern' or post.title contains 'Pattern' or post.title contains 'SOLID' or post.title contains 'Design'" %}
{% for post in pattern_posts limit: 15 %}

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

## Browse by Category

### SOLID Principles
{% assign solid_posts = site.posts | where_exp: "post", "post.title contains 'SOLID'" %}
{% for post in solid_posts limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

### Common Patterns
{% assign common_pattern_posts = site.posts | where_exp: "post", "post.title contains 'Pattern' or post.title contains 'Singleton' or post.title contains 'Factory' or post.title contains 'Observer'" %}
{% for post in common_pattern_posts limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

### Architectural Patterns
{% assign arch_posts = site.posts | where_exp: "post", "post.title contains 'Architecture' or post.title contains 'Microservice' or post.title contains 'MVC'" %}
{% for post in arch_posts limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

