---
name: Оновлення AGENTS для Gapta
overview: "AGENTS + .cursor під Gapta: сайт gapta.com.ua — українською, тематика блогу комп’ютеризована вишивка; зараз у коді заглушка. Ребрендинг ArtStroy→Gapta у скілах/правилах/доках; CI npm/main/rsync; окремо безпека mcp.json."
todos:
  - id: rewrite-header-links
    content: AGENTS overview — Gapta, вишивка, uk; посилання gapta.com.ua + AZANIR/Gapta; блок «зараз заглушка / далі блог»
    status: completed
  - id: stack-structure-deploy
    content: Tech stack фактичний + коротко планований блог; структура; Deploy npm, main, deploy.yml
    status: completed
  - id: blog-pipeline-gapta
    content: Переписати content pipeline / collections у AGENTS під Gapta (не прибирати блог), українська та тематика вишивки
    status: completed
  - id: git-mcp-env
    content: Git main, repo Gapta; MCP/env у доках без секретів; mcp.json — винести секрети; tsconfig @/
    status: completed
  - id: cursor-rules-docs-skills
    content: У .cursor замінити ArtStroy→Gapta; artstroy-article-writer → gapta-article-writer (або оновити текст); FLOW/docs під gapta.com.ua
    status: completed
isProject: false
---

# Оновлення AGENTS.md і папки `.cursor` під Gapta

## Продукт і мова (узгоджено з вами)

- **Що це за сайт:** [gapta.com.ua](https://gapta.com.ua) — **блог і сайт про комп’ютеризовану вишивку** (машинна вишивка, digitizing, обладнання/матеріали тощо — формулювання можна уточнити в AGENTS одним реченням).
- **Мова контенту й UI:** **українська** (у коді вже `lang="uk"` у [BaseLayout.astro](D:/QA_A/Gapta/src/layouts/BaseLayout.astro)).
- **Поточний стан репозиторію:** **заглушка** (мінімальні сторінки); **ціль** — повноцінний блог. У `AGENTS.md` варто явно розділити «як зараз» і «планується», щоб агенти не вважали наявними шляхи на кшталт `src/content/articles/`, доки їх не додано.

## Чому недостатньо «тільки посилання й title»

Поточний [AGENTS.md](D:/QA_A/Gapta/AGENTS.md) копіює **ArtStroy**: artstroy.net, repo artstroy, Bun, `master`, Docker — це не відповідає Gapta.

**Фактично зараз у Gapta:**

- Репозиторій: **`https://github.com/AZANIR/Gapta`**, деплой: **`main`** → `npm` → `dist/` на Hetzner ([deploy.yml](D:/QA_A/Gapta/.github/workflows/deploy.yml)).
- Стек у [package.json](D:/QA_A/Gapta/package.json): Astro 5, Tailwind 4, DaisyUI 5, TS — **поки без** MDX/React/Pagefind (можуть з’явитися з введенням блогу).

**У скілах і правилах:** не прибирати блоговий пайплайн — **перейменувати та переорієнтувати** ArtStroy → **Gapta**, тематика статей — **вишивка**, мова — **українська**.

## Що зробити в AGENTS.md (конкретно)

1. **Заголовок і Overview**  
   GAPTA / Gapta; **блог про комп’ютеризовану вишивку**; **мова сайту — українська**; домени з [README](D:/QA_A/Gapta/README.md); підрозділ **«Поточний стан»** — заглушка, **«Планується»** — повноцінний блог (шляхи `content/…` лише після імплементації).

2. **Посилання**  
   `https://gapta.com.ua`, `https://github.com/AZANIR/Gapta`; прибрати artstroy.

3. **Tech Stack**  
   **Факт:** Astro, Tailwind, DaisyUI, TS, npm. Опційно рядок **«планується для блогу»** (MDX, пошук тощо) без вигаданих версій.

4. **Project Structure**  
   Фактичне дерево з README + примітка про майбутні папки блогу.

5. **Контент блогу**  
   Не викидати розділи про колекції/frontmatter — переписати під **Gapta**, **uk**, приклади категорій під **вишивку**. Позначити як **цільова схема**, поки файлів у репо немає.

6. **Build & Deploy**  
   `npm`, **`main`**, [deploy.yml](D:/QA_A/Gapta/.github/workflows/deploy.yml); без Docker artstroy.

7. **Git Workflow**  
   **`main`**; PR у **Gapta**; гілки `article/{slug}` для майбутніх постів.

8. **Content Pipeline**  
   Зберегти 6 етапів і skills; **artstroy.net** → **gapta.com.ua**; **artstroy-article-writer** → **gapta-article-writer** (після перейменування скілу).

9. **MCP / Environment**  
   Перелік у AGENTS без секретів; виправити [.cursor/mcp.json](D:/QA_A/Gapta/.cursor/mcp.json) окремо.

10. **Code Conventions**  
   Зараз Astro + Tailwind; MDX/React — як **після додавання** в залежності.

## Перевірка папки `.cursor` (зроблено аудит)

Оновити `.cursor`, щоб не посилались на **artstroy** і **master**. Блоговий пайплайн **залишаємо**, змінюємо бренд, домен, **main**, тему **вишивка**, мову **uk**.

### Критично: секрети в репозиторії

У [.cursor/mcp.json](D:/QA_A/Gapta/.cursor/mcp.json) зараз захардкожені API-ключі (context7, GitHub PAT, Exa). Якщо файл потрапляє в git — **ротація ключів** і перехід на змінні оточення / локальний override (наприклад `.cursor/mcp.json` у `.gitignore` або шаблон без значень). Це окремий security-крок при виконанні плану.

### Rules (`.cursor/rules/`) — усі згадують ArtStroy або `master`

| Файл | Що не так |
|------|-----------|
| [project-memory.mdc](D:/QA_A/Gapta/.cursor/rules/project-memory.mdc) | Gapta, root `D:\QA_A\Gapta`, repo `Gapta`, base `main`, гілки статей |
| [git-workflow.mdc](D:/QA_A/Gapta/.cursor/rules/git-workflow.mdc) | `alwaysApply: true` → **`main`**, гілки `article/...` для блогу |
| [content-pipeline.mdc](D:/QA_A/Gapta/.cursor/rules/content-pipeline.mdc) | Блог **Gapta**, merge у **main**, тематика вишивка |
| [article-writing.mdc](D:/QA_A/Gapta/.cursor/rules/article-writing.mdc) | MDX для **Gapta**, **uk**, **комп’ютеризована вишивка** |
| [react-components.mdc](D:/QA_A/Gapta/.cursor/rules/react-components.mdc) | Ребренд; React — коли з’явиться в проєкті |
| [astro-patterns.mdc](D:/QA_A/Gapta/.cursor/rules/astro-patterns.mdc) | Gapta + майбутній блог |
| [task-completion.mdc](D:/QA_A/Gapta/.cursor/rules/task-completion.mdc) | `alwaysApply: true`, вимагає `docs/project_notes/` — у Gapta цієї структури може не бути; узгодити з репо або вимкнути |

**Рекомендація при виконанні:** скрізь **`main`**, repo **`Gapta`**, **gapta.com.ua**; **не** видаляти article/MDX/React-правила — адаптувати під майбутній блог (**uk**, вишивка).

### Документація (`.cursor/docs/`)

| Файл | Зміст |
|------|--------|
| [artstroy-agents-skills-pipeline.md](D:/QA_A/Gapta/.cursor/docs/artstroy-agents-skills-pipeline.md) | Повністю artstroy.net / artstroy / artstroy-article-writer |
| [FLOW.md](D:/QA_A/Gapta/.cursor/docs/FLOW.md) | Пайплайн контенту artstroy.net |
| [private-repo-migration-plan.md](D:/QA_A/Gapta/.cursor/docs/private-repo-migration-plan.md) | Міграція AZANIR/artstroy і Docker — для Gapta застаріло |

**Рекомендація:** перейменувати наприклад у `gapta-agents-skills-pipeline.md`, оновити вміст (домен, репо, **вишивка**, **uk**); [FLOW.md](D:/QA_A/Gapta/.cursor/docs/FLOW.md) — те саме. [private-repo-migration-plan.md](D:/QA_A/Gapta/.cursor/docs/private-repo-migration-plan.md) — замінити/архівувати під rsync Gapta, без Docker artstroy.

### Skills (`.cursor/skills/`)

- [conventional-commits/SKILL.md](D:/QA_A/Gapta/.cursor/skills/conventional-commits/SKILL.md) → **Gapta**, repo **`Gapta`**, base **`main`**.
- Перейменувати **`artstroy-article-writer`** → **`gapta-article-writer`**: оновити `SKILL.md` (gapta.com.ua, **комп’ютеризована вишивка**, **українська**, категорії/приклади під тему; внутрішні посилання — на Gapta, не ArtStroy).
- `content-creation`, `writing`, `seo-geo`, `frontend-design`, `playwright-cli`, `project-memory` — замінити згадки **ArtStroy / artstroy.net** на **Gapta**.

### Prompts

- [.cursor/prompts/eax.mp](D:/QA_A/Gapta/.cursor/prompts/eax.mp) — за текстовим пошуком **artstroy** не знайдено; при виконанні можна швидко переглянути вручну на старі URL.

## Підсумок

| Рішення | Зміст плану |
|---------|-------------|
| Блог | Пайплайн і скіли для статей **залишаємо**; у доках — **заглушка зараз** / **блог далі**. |
| Тема | **Комп’ютеризована вишивка**; мова **українська**. |
| Ребрендинг | ArtStroy → **Gapta** скрізь; article skill → **`gapta-article-writer`**. |
| Технічно | **main**, **npm**, rsync; **безпека mcp.json**. |

Після виконання контекст агентів відповідатиме [Gapta](https://github.com/AZANIR/Gapta), майбутньому блогу та поточному CI.
