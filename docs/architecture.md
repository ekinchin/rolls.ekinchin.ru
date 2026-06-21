# Архитектура

Проект - статический сайт на Eleventy. Исходники лежат в `src`, результат сборки пишется в `dist`.

## Структура

- `.eleventy.js` - основной конфиг Eleventy.
- `src/index.md` - главная страница, использует layout `gallery.njk`.
- `src/rolls/<number>/index.md` - отдельные посты фотопленок.
- `src/rolls/<number>/photos/` - изображения поста: полноразмерные и `xs-*` превью.
- `src/layouts/` - Nunjucks layouts.
- `src/includes/` - header/footer.
- `src/styles/` - CSS, копируется в `dist` passthrough-ом.
- `src/scripts/` - клиентский JS, копируется в `dist` passthrough-ом.
- `src/data/meta.yml` - глобальные метаданные сайта.
- `new-roll/` - рабочая директория для подготовки следующего поста.
- `test/` - shell-тесты на ключевые контракты проекта.

## Eleventy

Конфигурация в `.eleventy.js`:

- `input: "src"`, `output: "dist"`.
- Шаблоны: `md`, `njk`.
- `src/styles`, `src/scripts` и `src/rolls/**/photos/*.jpg` копируются без обработки.
- YAML data extension подключен через `js-yaml`.
- Коллекция `pagedRolls` строится из тегов `roll` и разворачивается через `.reverse()`, чтобы новые посты шли первыми.
- Главная галерея использует pagination по 3 roll на страницу.

## Модель данных roll

Каждый roll - markdown-файл с front matter:

```yaml
---
layout: contacts.njk
number: 40
title: Название
filmed: осень 2025
date: 2026-02-16
location: Город
story: Описание
camera: Camera
lens: Lens
film: Film
developing: Process
tags:
  - roll
photos:
  - number: 1
    description:
---
```

Важные контракты:

- `number` должен совпадать с именем каталога `src/rolls/<number>`.
- Каждый элемент `photos` должен иметь соответствующие файлы `photos/<number>.jpg` и `photos/xs-<number>.jpg`.
- Тег `roll` обязателен для попадания поста в главную галерею.
- `date` используется Eleventy как дата публикации.

## Шаблоны

- `base.njk` задает общий HTML, CSS и подключает `/scripts/lightbox.js`.
- `gallery.njk` рисует главную горизонтальную ленту roll-колонок.
- `contacts.njk` рисует страницу конкретного roll и lightbox-разметку для просмотра фото.

Прямые ссылки на JPG сохраняются в HTML. Клиентский lightbox работает как progressive enhancement: если JS не загрузился, фото по-прежнему откроется напрямую в браузере.
