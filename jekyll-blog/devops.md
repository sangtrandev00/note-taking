---
layout: default
title: DevOps
parent: Technical
nav_order: 10
has_children: false
---

# DevOps
{: .fs-8 }

DevOps practices, CI/CD, automation, and deployment strategies.
{: .fs-6 .fw-300 }

---

## Recent DevOps Posts

{% assign devops_posts = site.posts | where_exp: "post", "post.categories contains 'devops' or post.tags contains 'devops' or post.tags contains 'docker' or post.tags contains 'ci-cd' or post.tags contains 'deployment' or post.title contains 'DevOps' or post.title contains 'CI/CD' or post.title contains 'Docker' or post.title contains 'deployment'" %}
{% for post in devops_posts limit: 15 %}

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

## Browse by Technology

### Docker & Containerization
{% assign docker_posts = site.posts | where_exp: "post", "post.title contains 'Docker' or post.title contains 'Container' or post.tags contains 'docker'" %}
{% for post in docker_posts limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

### CI/CD & Automation
{% assign cicd_posts = site.posts | where_exp: "post", "post.title contains 'CI/CD' or post.title contains 'automation' or post.title contains 'testing'" %}
{% for post in cicd_posts limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

### Cloud & Infrastructure
{% assign cloud_posts = site.posts | where_exp: "post", "post.title contains 'AWS' or post.title contains 'Cloud' or post.title contains 'Infrastructure'" %}
{% for post in cloud_posts limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

### Monitoring & Operations
{% assign monitoring_posts = site.posts | where_exp: "post", "post.title contains 'Monitor' or post.title contains 'Logging' or post.title contains 'Performance'" %}
{% for post in monitoring_posts limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

