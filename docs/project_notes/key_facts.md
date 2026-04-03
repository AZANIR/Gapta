# Ключові факти проєкту (Gapta)

Лише **нечутливі** дані. Паролі, ключі API, токени — у `.env`, GitHub Secrets, менеджері секретів, не тут.

## Сайт і репозиторій

- Прод-домен: https://gapta.com.ua
- Репозиторій: https://github.com/AZANIR/Gapta
- Мова контенту/UI: українська (`lang="uk"`)
- Тематика (ціль блогу): комп’ютеризована вишивка

## Гілки та CI

- Деплой GitHub Actions: push у гілку **`master`** (див. `.github/workflows/deploy.yml`).
- На сервері (за workflow): `git pull origin master` у `/opt/docker/blog-gapta/repo`, далі `docker compose` у `/opt/docker`.
- У README може згадуватись `main` — перевіряти фактичний `deploy.yml`.

## GitHub Secrets (назви, без значень)

- `SERVER_HOST`, `SERVER_USER`, `SERVER_SSH_KEY` — для SSH-деплою

## Локальна розробка

- Порт dev: `http://localhost:4321` (`npm run dev`)
- Збірка: `npm run build` → каталог `dist/`
- Менеджер пакетів: **npm**

## Стек (факт)

- Astro 5, TypeScript, Tailwind v4 (`@tailwindcss/vite`), DaisyUI 5

## Документація для агентів

- Контекст репозиторію: `AGENTS.md`
- Інституційна пам’ять: ця папка `docs/project_notes/`
