---
layout: default
title: Technical Interview
parent: Technical
nav_order: 9
has_children: false
---

# Technical Interview
{: .fs-8 }

Technical interview preparation and coding challenges.
{: .fs-6 .fw-300 }

---

## Recent Technical Interview Posts

{% assign tech_interview_posts = site.posts | where_exp: "post", "post.categories contains 'interview' or post.tags contains 'interview' or post.title contains 'interview' or post.title contains 'coding' or post.title contains 'algorithm' or post.title contains 'leetcode' or post.title contains 'grind'" %}
{% for post in tech_interview_posts limit: 15 %}

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

### Coding Challenges
{% assign coding_posts = site.posts | where_exp: "post", "post.title contains 'leetcode' or post.title contains 'grind' or post.title contains 'coding'" %}
{% for post in coding_posts limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

### Algorithm Practice
{% assign algo_posts = site.posts | where_exp: "post", "post.title contains 'algorithm' or post.title contains 'BigO' or post.title contains 'complexity'" %}
{% for post in algo_posts limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

### Problem Solving
{% assign problem_posts = site.posts | where_exp: "post", "post.title contains 'problem' or post.title contains 'solving' or post.title contains 'approach'" %}
{% for post in problem_posts limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

### Technical Questions
{% assign tech_q_posts = site.posts | where_exp: "post", "post.title contains 'question' or post.title contains 'phong van' or post.title contains 'fresher'" %}
{% for post in tech_q_posts limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

