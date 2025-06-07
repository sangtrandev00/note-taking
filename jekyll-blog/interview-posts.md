---
layout: default
title: Interview Posts
parent: Interview Preparation
nav_order: 1
---

# Interview Preparation Posts
{: .fs-9 }

All interview-related content and real experiences.
{: .fs-6 .fw-300 }

---

## Recent Interview Posts

{% assign interview_posts = site.posts | where_exp: "post", "post.categories contains 'interview' or post.categories contains 'fullteron' or post.categories contains 'unitysport'" %}
{% for post in interview_posts limit: 15 %}

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

### Technical Interview Questions
{% assign tech_interview = site.posts | where_exp: "post", "post.title contains 'technical' or post.title contains 'Technical' or post.tags contains 'interview'" %}
{% for post in tech_interview limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

### Real Company Experiences
{% assign company_exp = site.posts | where_exp: "post", "post.title contains 'Fullerton' or post.title contains 'Unity' or post.title contains 'NAB'" %}
{% for post in company_exp limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

### Salary Negotiation & Strategy
{% assign strategy_posts = site.posts | where_exp: "post", "post.title contains 'strategy' or post.title contains 'negotiation' or post.title contains 'salary'" %}
{% for post in strategy_posts limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

### Templates & Resources
{% assign template_posts = site.posts | where_exp: "post", "post.title contains 'template' or post.title contains 'Template'" %}
{% for post in template_posts limit: 8 %}
- [{{ post.title }}]({{ post.url }}) *{{ post.date | date: "%b %d" }}*
{% endfor %}

