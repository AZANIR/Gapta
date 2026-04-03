# Gapta — агенти, скіли та контент-пайплайн

> Документ описує **GAPTA** ([gapta.com.ua](https://gapta.com.ua)): блог українською про **комп’ютеризовану вишивку**. У коді зараз може бути заглушка; пайплайн і скіли готують майбутні статті та зміни сайту.

---

## Проєкт

| | |
|---|---|
| **Сайт** | [gapta.com.ua](https://gapta.com.ua) — вишивка, обладнання, матеріали, digitizing |
| **Репозиторій** | [AZANIR/Gapta](https://github.com/AZANIR/Gapta) |
| **Стек (факт)** | Astro 5 + TypeScript + Tailwind CSS 4 + DaisyUI 5 + **npm** |
| **Стек (план, блог)** | MDX, React (за потреби), пошук/sitemap — після додавання в репо |
| **Деплой** | GitHub Actions на push у **`main`** → збірка → rsync `dist/` на Hetzner ([deploy.yml](../../.github/workflows/deploy.yml)) |
| **IDE** | Cursor: `.cursor/skills/`, `.cursor/mcp.json`, `.cursor/rules/` |

---

## Пайплайн (6 стадій)

```
Тема / нотатки (українською)
    ↓
1. Написання     → content-creation + writing + frontend-design + gapta-article-writer
    ↓
2. Рев'ю коду    → code-reviewer + seo-geo + web-design-guidelines
    ↓
3. Зображення    → nano-banana-pro | Cursor GenerateImage
    ↓
4. Збірка + тест → npm run build + playwright-cli + Context7
    ↓
5. Затвердження  → GitHub MCP: PR + рев'ю людиною
    ↓
6. Публікація    → merge у main → GitHub Actions → прод
    ↓
Стаття на gapta.com.ua (коли маршрути блогу є)
```

**Приклади запитів:**

- `"Напиши статтю українською про [тема] для gapta.com.ua, скіл gapta-article-writer"`
- `"Досліди [тема] через Exa, потім стаття gapta-article-writer"`
- `"Стаття з інтерактивом: gapta-article-writer + frontend-design"`

---

## Скіли (огляд)

| Стадія | Скіли |
|--------|--------|
| 1 | content-creation, writing, frontend-design, **gapta-article-writer** |
| 2 | code-reviewer, seo-geo, web-design-guidelines |
| 3 | nano-banana-pro (`GEMINI_API_KEY`) |
| 4 | `npm run build`, playwright-cli, Context7 MCP |
| 5–6 | conventional-commits, GitHub MCP |

**Збірка:** `npm run build` (не bun). Гілка за замовчуванням для роботи — **`main`**, не `master`.

---

## MCP

Див. [README-MCP.md](../README-MCP.md) та [mcp.example.json](../mcp.example.json). Ключі: `CONTEXT7_API_KEY`, `GITHUB_PERSONAL_ACCESS_TOKEN`, `EXA_API_KEY` — у оточенні, не в комітах.

---

## Cursor rules

| Файл | Призначення |
|------|-------------|
| article-writing.mdc | MDX статті Gapta, uk |
| astro-patterns.mdc | Astro-сторінки та (далі) блог |
| content-pipeline.mdc | 6 етапів, always apply |
| git-workflow.mdc | Гілки, Conventional Commits, **main** |
| react-components.mdc | React у статтях, коли з’явиться в deps |
| project-memory.mdc | Шляхи, env, PR у Gapta |

Кореневий контекст: [AGENTS.md](../../AGENTS.md).

---

## Структура `.cursor` (орієнтир)

```
Gapta/
├── AGENTS.md
├── .cursor/
│   ├── mcp.json
│   ├── mcp.example.json
│   ├── README-MCP.md
│   ├── rules/ ...
│   ├── skills/
│   │   ├── gapta-article-writer/
│   │   └── ...
│   └── docs/
│       ├── gapta-agents-skills-pipeline.md
│       └── FLOW.md
```

---

## Troubleshooting

- **Збірка:** `npm run build`; помилки схеми frontmatter — перевірити `content.config` у репо.
- **MCP:** ключі в env; логи MCP у Cursor.
- **Статті:** шлях `src/content/articles/` — лише після додавання колекцій у проєкт.
