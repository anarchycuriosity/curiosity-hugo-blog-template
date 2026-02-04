---
title: 让归档按月划分同时显示tag
date: 2026-02-03
categories:
  - 博客配置

---



## 修改配置文件

**找到hugo根目录下的这个文件**

> layouts\default\archives.html

修改如下,只是对demon的同一文件进行修改

```html
{{ define "body-class" }}template-archives{{ end }}
{{ define "main" }}
    <header>
        {{/* 保留 Categories 分类显示逻辑 */}}
        {{- $taxonomy := $.Site.GetPage "taxonomyTerm" "categories" -}}
        {{- $terms := $taxonomy.Pages -}}
        {{ if $terms }}
        <h2 class="section-title">{{ T "widget.categoriesCloud.title" }}</h2>
        <div class="subsection-list">
            <div class="article-list--tile">
                {{ range $terms }}
                    {{ partial "article-list/tile" (dict "context" . "size" "250x150" "Type" "taxonomy") }}
                {{ end }}
            </div>
        </div>
        {{ end }}
    </header>

    
    {{ $pages := where .Site.RegularPages "Type" "in" .Site.Params.mainSections }}
    {{ $filtered := where $pages "Params.hidden" "!=" true }}

    {{/* 将 "2006" 改为 "2006-01" 实现按月划分 */}}
    {{ range $filtered.GroupByDate "2006-01" }}
    {{ $id := lower (replace .Key " " "-") }}
    <div class="archives-group" id="{{ $id }}">
 
        <h2 class="archives-date section-title">
            <a href="{{ $.RelPermalink }}#{{ $id }}">{{ .Key }}</a>
        </h2>
        <div class="article-list--compact">
            {{ range .Pages }}
                {{ partial "article-list/compact" . }}
            {{ end }}
        </div>
    </div>
    {{ end }}

    {{ partialCached "footer/footer" . }}
{{ end }}
```

