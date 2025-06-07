---
layout: default
title: English Posts
parent: English & TOEIC
nav_order: 1
---

# English & TOEIC Posts
{: .fs-9 }

All English learning and TOEIC preparation materials.
{: .fs-6 .fw-300 }

---

## Recent English Posts

{% assign english_posts = site.posts | where_exp: "post", "post.categories contains 'english' or post.tags contains 'toeic' or post.tags contains 'english'" %}
{% for post in english_posts limit: 20 %}

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

### TOEIC Grammar
{% assign grammar_posts = site.posts | where_exp: "post", "post.title contains 'grammar' or post.categories contains 'grammar'" %}
{% for post in grammar_posts limit: 10 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

### TOEIC Tests & Practice
{% assign test_posts = site.posts | where_exp: "post", "post.title contains 'Test' or post.title contains 'ETS'" %}
{% for post in test_posts limit: 15 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

### Vocabulary
{% assign vocab_posts = site.posts | where_exp: "post", "post.title contains 'vocab' or post.categories contains 'vocab'" %}
{% for post in vocab_posts limit: 10 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

### Test Experiences
{% assign exp_posts = site.posts | where_exp: "post", "post.title contains 'experience' or post.title contains 'thi TOEIC'" %}
{% for post in exp_posts limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

