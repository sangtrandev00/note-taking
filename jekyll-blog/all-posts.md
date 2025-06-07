---
layout: default
title: All Posts
nav_order: 4
has_children: false
---

# All Posts
{: .fs-9 }

Complete list of all notes and articles ({{ site.posts.size }} total).
{: .fs-6 .fw-300 }

---

## Search Posts

Use the search box above to find specific topics, or browse by category below.

---

## Posts by Category

### 🔧 Technical Notes
{% assign technical_posts = site.posts | where_exp: "post", "post.categories contains 'technical'" %}
{% for post in technical_posts limit: 15 %}
- [{{ post.title }}]({{ post.url }}) 
  *{{ post.date | date: "%b %d, %Y" }} • {% for tag in post.tags limit: 3 %}{{ tag }}{% unless forloop.last %}, {% endunless %}{% endfor %}*
{% endfor %}
{% if technical_posts.size > 15 %}
*... and {{ technical_posts.size | minus: 15 }} more technical posts*
{% endif %}

### 💼 Interview & Career
{% assign interview_posts = site.posts | where_exp: "post", "post.categories contains 'interview' or post.categories contains 'fullteron' or post.categories contains 'unitysport' or post.categories contains 'behavior'" %}
{% for post in interview_posts limit: 15 %}
- [{{ post.title }}]({{ post.url }}) 
  *{{ post.date | date: "%b %d, %Y" }} • {% for tag in post.tags limit: 3 %}{{ tag }}{% unless forloop.last %}, {% endunless %}{% endfor %}*
{% endfor %}
{% if interview_posts.size > 15 %}
*... and {{ interview_posts.size | minus: 15 }} more interview posts*
{% endif %}

### 📚 English & TOEIC
{% assign english_posts = site.posts | where_exp: "post", "post.categories contains 'english' or post.tags contains 'toeic' or post.tags contains 'english'" %}
{% for post in english_posts limit: 15 %}
- [{{ post.title }}]({{ post.url }}) 
  *{{ post.date | date: "%b %d, %Y" }} • {% for tag in post.tags limit: 3 %}{{ tag }}{% unless forloop.last %}, {% endunless %}{% endfor %}*
{% endfor %}
{% if english_posts.size > 15 %}
*... and {{ english_posts.size | minus: 15 }} more English posts*
{% endif %}

### 🎓 University Notes
{% assign university_posts = site.posts | where_exp: "post", "post.categories contains 'university' or post.categories contains 'semester01'" %}
{% for post in university_posts limit: 15 %}
- [{{ post.title }}]({{ post.url }}) 
  *{{ post.date | date: "%b %d, %Y" }} • {% for tag in post.tags limit: 3 %}{{ tag }}{% unless forloop.last %}, {% endunless %}{% endfor %}*
{% endfor %}
{% if university_posts.size > 15 %}
*... and {{ university_posts.size | minus: 15 }} more university posts*
{% endif %}

---

## Recent Posts (All Categories)

{% for post in site.posts limit: 30 %}
{{ forloop.index }}. [{{ post.title }}]({{ post.url }}) 
   *{{ post.date | date: "%B %d, %Y" }} • {{ post.categories | join: " → " }}*
{% endfor %}

---

**Total Posts:** {{ site.posts.size }}  
**Last Updated:** {{ site.time | date: "%B %d, %Y at %I:%M %p" }}

