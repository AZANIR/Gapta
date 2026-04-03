# GAPTA — контекст проєкту

## Огляд

**GAPTA** ([gapta.com.ua](https://gapta.com.ua)) — сайт українською мовою про **комп’ютеризовану вишивку**: машинна вишивка, digitizing, обладнання, нитки та полотно, програмне забезпечення та практичні поради. **Ціль** — повноцінний блог і розділи сайту на Astro; контент і UI — **українською** (`lang="uk"` у розмітці).

**Власник:** Leonid Maievskyi ([@AZANIR](https://github.com/AZANIR)).

**Репозиторій:** <https://github.com/AZANIR/Gapta>

### Поточний стан репозиторію

- Мінімальний статичний сайт (заглушка на головній): `src/pages/index.astro`, `404.astro`, [BaseLayout.astro](src/layouts/BaseLayout.astro).
- У `package.json` **немає** поки MDX, React, Pagefind — вони з’являться, коли блог буде додано в код.

### Планується (блог)

- Колекції контенту Astro (статті в `src/content/…`), маршрути `/articles/…`, опційно пошук (наприклад Pagefind), RSS/sitemap за потреби.
- Доки ці папки **не** створені в репо, шляхи нижче в розділі «Цільова схема контенту» — **орієнтир для майбутньої імплементації**, не фактична структура файлів.

## Технології

| Шар        | Зараз у репо                          |
| ---------- | ------------------------------------- |
| Framework  | Astro 5 (SSG, `output: 'static'`)    |
| Стилі      | Tailwind CSS 4, DaisyUI 5             |
| Типізація  | TypeScript, `astro check` у `build`   |
| Пакети     | npm (Node; CI — Node 22)              |
| Деплой     | GitHub Actions → rsync `dist/` на Hetzner |

**Можливо пізніше (блог):** MDX, React для інтерактивів, `@astrojs/sitemap` / RSS, статичний пошук — додавати в `package.json` за фактом.

## Структура проєкту (факт)

Як у [README.md](README.md):

```
gapta/
├── .github/workflows/deploy.yml
├── public/
├── server/                 # nginx, setup.sh
├── src/
│   ├── layouts/BaseLayout.astro
│   ├── pages/index.astro, 404.astro
│   ├── styles/             # за наявності
│   └── assets/             # за наявності
├── astro.config.mjs
├── package.json
└── tsconfig.json
```

**Після появи блогу** типово додадуться: `src/content/articles/`, `src/content.config.ts`, маршрути під статті, `src/components/` тощо.

## Цільова схема контенту (майбутній блог)

Орієнтир для Astro Content Collections (коли з’явиться `src/content.config.ts`). Поля й валідація можуть відрізнятися — узгодити з фактичною схемою в коді.

### Статті (`src/content/articles/{slug}/index.mdx` — планується)

Приклад frontmatter:

```yaml
draft: true
title: "До 80 символів українською"
description: "До ~180 символів, українською"
cover: "./imgs/cover.avif"
coverAlt: "Опис обкладинки"
category: obladnannya              # id категорії з колекції
author: leonid-m                   # або масив авторів — за схемою
publishedTime: "2026-04-03T00:00:00.000Z"
```

### Приклади категорій (ніша — вишивка)

Підлаштувати під реальну навігацію: наприклад `obladnannya`, `nythky-polotno`, `digitizing`, `oglyady`, `porady`, `prohramne-zabezpechennya` (slug’и латинкою, назви в контенті — українською).

### Автори та категорії

Окремі колекції `authors/`, `categories/` — за аналогією з типовим Astro-блогом; деталі після додавання в репозиторій.

### Зображення

- Папка статті: `src/content/articles/{slug}/imgs/`
- Бажано AVIF/WebP; шлях у frontmatter відносний до `index.mdx`

## Збірка та деплой

### Локально

```bash
npm install
npm run dev          # http://localhost:4321
npm run build        # astro check && astro build → dist/
npm run preview
```

### CI/CD

Push у гілку **`master`** → [`.github/workflows/deploy.yml`](.github/workflows/deploy.yml): SSH на сервер, `git pull origin master` у репо блогу, `docker compose build` / `up`. Секрети: `SERVER_HOST`, `SERVER_USER`, `SERVER_SSH_KEY` — у [README.md](README.md).

Хостинг: Hetzner, Caddy/Docker (опис у README).

## Git workflow

**Не комітити напряму в `master`.** Робота в feature-гілках.

### Імена гілок

| Тип        | Шаблон              | Приклад                          |
| ---------- | ------------------- | -------------------------------- |
| Стаття     | `article/{slug}`    | `article/vybor-nythky-polotna`   |
| Фіча       | `feat/...`          | `feat/add-articles-route`        |
| Виправлення| `fix/...`           | `fix/og-image`                   |
| Стилі/UI   | `style/...`         | `style/hero-spacing`             |
| Доки       | `docs/...`          | `docs/update-agents`             |
| Рефакторинг| `refactor/...`      | `refactor/layout-props`          |
| CI         | `ci/...`            | `ci/cache-npm`                   |

### Conventional Commits

Формат: `<type>(<scope>): <description>` — [Conventional Commits 1.0.0](https://www.conventionalcommits.org/en/v1.0.0/).

**Типи:** `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `ci`, `chore`, `content`

**Скоупи (приклади):** `article`, `ui`, `layout`, `seo`, `config`, `deps`, `skill`, `rule`

Скил `.cursor/skills/conventional-commits` — для гілок і повідомлень комітів; PR у репозиторій **AZANIR/Gapta**, база **`master`** (як у CI).

## Контент-пайплайн (6 етапів)

AI-асистована робота зі скілами в `.cursor/skills/`:

| Етап | Назва              | Скіли / інструменти                                      |
| ---- | ------------------ | -------------------------------------------------------- |
| 1    | Текст              | `content-creation`, `writing`, `frontend-design`         |
| 2    | Рев’ю              | `code-reviewer`, `seo-geo`, `web-design-guidelines`      |
| 3    | Зображення         | `nano-banana-pro`, Cursor GenerateImage                  |
| 4    | Збірка + перевірка | `npm run build`, `playwright-cli`, Context7 MCP          |
| 5    | Затвердження       | GitHub MCP → PR → рев’ю людиною                          |
| 6    | Публікація         | Merge у `master` → GitHub Actions → SSH + Docker на сервері |

### Коли що використовувати

- **Стаття для gapta.com.ua:** структура SEO та людний тон — `content-creation`, `writing`; інтерактив — `frontend-design`; формат MDX і frontmatter — скіл **`gapta-article-writer`** (після додавання блогу в код).
- **Код/UI:** `code-reviewer`, `web-design-guidelines`.
- **SEO:** `seo-geo`.
- **Зображення:** `nano-banana-pro` (`GEMINI_API_KEY`, за потреби `uv`).
- **Перед деплоєм:** `npm run build`, за потреби `playwright-cli`.
- **Коміти/PR:** `conventional-commits`; PR у **Gapta**, база **`master`**.

## MCP сервери

У Cursor налаштовуються через `.cursor/mcp.json` (локально; **не** комітити секрети — див. [.cursor/README-MCP.md](.cursor/README-MCP.md) та [.cursor/mcp.example.json](.cursor/mcp.example.json)).

- **sequential-thinking** — структуроване міркування
- **context7** — актуальна документація (Astro, Tailwind тощо); ключ API — лише в локальному конфігу / оточенні
- **github** — PR, issues; потребує `GITHUB_PERSONAL_ACCESS_TOKEN` у оточенні
- **exa** — веб-дослідження; `EXA_API_KEY` у оточенні

## Узгодження коду

- Зараз: компоненти **Astro** (`.astro`), стилі Tailwind + DaisyUI.
- **Після додавання блогу:** MDX, за потреби React (`.tsx`) з `client:load` / `client:visible`.
- Імпорти: аліас `@/` → `src/` ([tsconfig.json](tsconfig.json)).

## Змінні оточення

| Змінна                         | Для чого                    |
| ------------------------------ | --------------------------- |
| `GITHUB_PERSONAL_ACCESS_TOKEN` | GitHub MCP                  |
| `EXA_API_KEY`                  | Exa MCP                     |
| `GEMINI_API_KEY`               | `nano-banana-pro` (зображення) |
| Ключ Context7                  | Context7 MCP (див. приклад конфігу) |

Не комітити значення секретів у репозиторій.

## Система project memory

У репозиторії ведеться **інституційна пам’ять** у [`docs/project_notes/`](docs/project_notes/):

| Файл | Призначення |
|------|-------------|
| [`bugs.md`](docs/project_notes/bugs.md) | Баги: симптом, причина, рішення, запобігання |
| [`decisions.md`](docs/project_notes/decisions.md) | ADR — контекст, рішення, альтернативи, наслідки |
| [`key_facts.md`](docs/project_notes/key_facts.md) | Домени, гілки CI, порти, стек (**без** секретів) |
| [`issues.md`](docs/project_notes/issues.md) | Короткий журнал робіт і PR/issue |

**Протоколи для агентів**

- Перед зміною архітектури — переглянути `decisions.md`.
- При помилках — шукати в `bugs.md`; нові випадки документувати після вирішення.
- Конфігурацію (гілка деплою, URL) брати з `key_facts.md` / `README.md`, не вигадувати.
- Після завершення задачі — оновити `issues.md`; за потреби `bugs.md`, `decisions.md`, `key_facts.md`.
- Стиль: маркерні списки, дати `YYYY-MM-DD`, посилання на PR.

Для **Claude Code** ті самі правила дубльовані в [`CLAUDE.md`](CLAUDE.md).
