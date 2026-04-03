# FLOW — контент-пайплайн Gapta (gapta.com.ua)

> Як вести статтю від ідеї до публікації: скіли, MCP, git. **Мова контенту — українська**, ніша — **комп’ютеризована вишивка**. Якщо в репо ще немає `src/content/articles/`, узгодь з [AGENTS.md](../../AGENTS.md) і створюй структуру після появи блогу в коді.

Детальний огляд скілів: [gapta-agents-skills-pipeline.md](gapta-agents-skills-pipeline.md).

---

## Передумови

| Інструмент | Перевірка |
|------------|-----------|
| **Node + npm** | `node --version`, `npm --version` |
| **uv** (nano-banana-pro) | `uv --version` (опційно) |
| **Git** | `git --version` |
| **Cursor** | MCP увімкнені |

**Змінні оточення:** `GEMINI_API_KEY`, `GITHUB_PERSONAL_ACCESS_TOKEN`, `EXA_API_KEY`, `CONTEXT7_API_KEY` — див. [.cursor/README-MCP.md](../README-MCP.md).

---

## Огляд стадій

```
Ідея (українською)
    ↓
1. Написання      → gapta-article-writer (+ content-creation, writing, frontend-design)
2. Рев'ю          → code-reviewer + seo-geo + web-design-guidelines
3. Зображення     → nano-banana-pro | GenerateImage
4. Збірка         → npm run build (+ playwright-cli за потреби)
5. PR             → GitHub MCP, рев'ю людиною
6. Публікація     → merge у main → GitHub Actions
    ↓
Стаття на gapta.com.ua (коли є маршрути блогу)
```

---

## Stage 1: Написання

**Промпти (приклади):**

```
Напиши українською статтю про [тема] для gapta.com.ua, скіл gapta-article-writer
```

```
Досліди [тема] через Exa, потім стаття українською — gapta-article-writer
```

```
Стаття про [тема] з інтерактивним блоком — gapta-article-writer та frontend-design
```

Після появи блогу в коді — шлях: `src/content/articles/{slug}/index.mdx`, `imgs/`, опційно `components/`.

---

## Stage 2: Рев'ю

```
Review the article at src/content/articles/{slug}/ using the code-reviewer skill
```

```
SEO audit on src/content/articles/{slug}/index.mdx using the seo-geo skill
```

---

## Stage 3: Зображення

Скіл `nano-banana-pro` або Cursor GenerateImage. Обкладинка в `imgs/`, у frontmatter відносний шлях до cover.

---

## Stage 4: Збірка

```bash
npm run build
npm run preview   # опційно
```

Має пройти `astro check && astro build` без помилок.

---

## Stage 5: Git і PR

- Гілка: `article/{slug}` (або `feat/…`).
- База для PR: **`main`** (не `master`).
- Репозиторій: **AZANIR/Gapta**.

```bash
git checkout main && git pull origin main
git checkout -b article/{slug}
# ... commits ...
git push -u origin HEAD
```

**PR:** GitHub MCP `create_pull_request`: owner `AZANIR`, repo **`Gapta`**, base **`main`**. Або `gh pr create`.

Скіл **conventional-commits** — для повідомлень комітів і гілок.

---

## Stage 6: Після merge

Деплой через [.github/workflows/deploy.yml](../../.github/workflows/deploy.yml).

**Після появи блогу в проді — перевірити:**

- URL статті на `https://gapta.com.ua/...` (точний шлях залежить від роутингу)
- OG-зображення, sitemap — коли буде налаштовано в проєкті

---

## Troubleshooting

| Проблема | Дія |
|----------|-----|
| MCP червоний | Ключі в env; перезапуск Cursor; [.cursor/README-MCP.md](../README-MCP.md) |
| Помилка збірки | Лог `npm run build`; Context7 для Astro docs |
| Немає папки content | Блог ще не додано — див. [AGENTS.md](../../AGENTS.md) «Планується» |

---

## Посилання

| Що | Де |
|----|-----|
| Сайт | [gapta.com.ua](https://gapta.com.ua) |
| Репо | [github.com/AZANIR/Gapta](https://github.com/AZANIR/Gapta) |
| Пайплайн-док | [gapta-agents-skills-pipeline.md](gapta-agents-skills-pipeline.md) |
