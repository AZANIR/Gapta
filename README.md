# GAPTA — gapta.com.ua

Статичний сайт-портфоліо на Astro + Tailwind CSS.

## Домени

| Домен | Роль |
|-------|------|
| **gapta.com.ua** | Основний домен |
| gapta.rivne.ua | Редирект → gapta.com.ua |
| gapta.rv.ua | Редирект → gapta.com.ua |

## Стек

- [Astro v5](https://astro.build/) — static site generator
- [Tailwind CSS v4](https://tailwindcss.com/) — utility-first CSS
- [DaisyUI v5](https://daisyui.com/) — component library
- [TypeScript](https://www.typescriptlang.org/)

## Хостинг

- **Сервер:** Hetzner (ubuntu-16gb-hel1-1, IP: 89.167.79.114)
- **Reverse proxy:** Caddy (Docker)
- **Контейнер:** Caddy serving static (multi-stage Docker build)
- **SSL:** автоматично через Caddy
- **CI/CD:** GitHub Actions → SSH → git pull → docker compose build/up

## Локальна розробка

```bash
npm install
npm run dev        # http://localhost:4321
npm run build      # збірка в dist/
npm run preview    # превью збірки
```

## Деплой

Автоматичний при push в `master` через GitHub Actions.

Пайплайн: CI будує Docker-образ → пушить в GHCR → SSH на сервер → pull + restart контейнера.
Сервер не потребує доступу до GitHub — образ приходить з GHCR через CI.

### GitHub Secrets (Settings → Secrets → Actions):

| Secret | Значення |
|--------|----------|
| `SERVER_HOST` | `89.167.79.114` |
| `SERVER_USER` | `root` |
| `SERVER_SSH_KEY` | Приватний SSH-ключ (для входу на сервер) |

## Налаштування на сервері (one-time)

### 1. Переконатися що Docker встановлено

```bash
docker --version
docker compose version
```

### 2. Створити мережу `web` (якщо не існує)

```bash
docker network create web 2>/dev/null || true
```

### 3. Додати домени в Caddyfile

В `/opt/docker/caddy/Caddyfile` додати:

```
gapta.com.ua, www.gapta.com.ua {
    reverse_proxy blog-gapta:80
}

gapta.rivne.ua, www.gapta.rivne.ua,
gapta.rv.ua, www.gapta.rv.ua {
    redir https://gapta.com.ua{uri} permanent
}
```

### 4. Перезавантажити Caddy

```bash
docker exec caddy caddy reload --config /etc/caddy/Caddyfile
```

### Примітка

Контейнер `blog-gapta` управляється безпосередньо через `docker run` (не через docker-compose),
тому `git clone` репозиторію на сервері більше не потрібен.

## Структура проєкту

```
gapta/
├── .github/workflows/deploy.yml   # CI/CD
├── public/                         # Статичні файли
│   ├── favicon.svg
│   └── robots.txt
├── src/
│   ├── assets/                     # Зображення, шрифти
│   ├── components/                 # Astro компоненти
│   ├── layouts/
│   │   └── BaseLayout.astro
│   ├── pages/
│   │   ├── index.astro             # Головна (заглушка)
│   │   └── 404.astro               # 404
│   └── styles/                     # Глобальні стилі
├── Caddyfile                       # Caddy конфіг для контейнера
├── Dockerfile                      # Multi-stage build
├── astro.config.mjs
├── package.json
└── tsconfig.json
```
