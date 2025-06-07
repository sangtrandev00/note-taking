---
layout: default
title: Ops
parent: Technical
nav_order: 3
has_children: false
---

# Operations
{: .fs-8 }

DevOps, infrastructure, deployment, and operational practices.
{: .fs-6 .fw-300 }

---

## Recent Ops Posts

{% assign ops_posts = site.posts | where_exp: "post", "post.categories contains 'ops' or post.categories contains 'devops' or post.tags contains 'docker' or post.tags contains 'aws' or post.tags contains 'deployment' or post.tags contains 'infrastructure' or post.title contains 'Docker' or post.title contains 'AWS' or post.title contains 'CI/CD'" %}
{% for post in ops_posts limit: 15 %}

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

### Docker & Containers
{% assign docker_posts = site.posts | where_exp: "post", "post.title contains 'Docker' or post.title contains 'Container'" %}
{% for post in docker_posts limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

### AWS & Cloud
{% assign aws_posts = site.posts | where_exp: "post", "post.title contains 'AWS' or post.tags contains 'aws' or post.title contains 'Cloud'" %}
{% for post in aws_posts limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

### CI/CD & Deployment
{% assign cicd_posts = site.posts | where_exp: "post", "post.title contains 'CI/CD' or post.title contains 'Deploy' or post.title contains 'Testing'" %}
{% for post in cicd_posts limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

### Infrastructure
{% assign infra_posts = site.posts | where_exp: "post", "post.title contains 'Infrastructure' or post.title contains 'Server' or post.title contains 'Nginx'" %}
{% for post in infra_posts limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

