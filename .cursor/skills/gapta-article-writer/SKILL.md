---
name: gapta-article-writer
description: Write complete MDX blog articles for gapta.com.ua (computerized embroidery niche) in Ukrainian, with correct frontmatter, SEO, and optional React components. Use when creating new posts for the Gapta blog once content collections exist, or when drafting article structure and copy.
---

# Gapta Article Writer

You write for **GAPTA** ([gapta.com.ua](https://gapta.com.ua)) — сайт **українською** про **комп’ютеризовану вишивку**: машини, digitizing, нитки, стабілізатори, ПЗ, огляди та практичні поради.

**Репозиторій:** [AZANIR/Gapta](https://github.com/AZANIR/Gapta). Якщо в репо ще немає `src/content/articles/`, створюй файли як **чернетку структури** і узгоджуй шляхи з наявним `content.config` після появи блогу в коді.

## Process

### Step 1: Research & Planning

1. Обери **категорію** з таблиці нижче (латинський `id` у frontmatter).
2. **Аудиторія:** власники машин вишивки, digitizers, майстри цехів, ентузіасти.
3. **План:** 3–5 основних розділів; логіка «від проблеми до рішення» або «огляд → висновки».
4. Для актуальних даних по бібліотеках/ПЗ — **Context7 MCP**; для фактів і джерел — **Exa MCP** (за потреби).

### Step 2: Create Article Structure (коли блог у коді)

```
src/content/articles/{slug}/
├── index.mdx
└── imgs/
```

Slug: **латиниця**, `kebab-case` (наприклад `vybir-nythky-dlya-polotna`). У тексті статті — **українська**.

### Step 3: Frontmatter

Шаблон узгоджуй з фактичною Astro-схемою в репо. Поки схема не зафіксована в коді, використовуй:

```yaml
---
draft: true
title: ""
description: ""
cover: "./imgs/cover.avif"
coverAlt: ""
category: obladnannya
author: leonid-m
publishedTime: "YYYY-MM-DDTHH:mm:ss.000Z"
---
```

- `title` / `description`: українською; довжини як у проєкту (орієнтир — до ~80 / ~180 символів для SEO).
- **Запитай користувача:** лишати `draft: true` чи одразу публікувати (`draft: false`), якщо поле є в схемі.

Якщо в проєкті замість `draft` використовується `isDraft` — підлаштуй під колекцію.

### Step 4: Write Content (українська)

1. **Вступ:** чому тема важлива для читача вишивки.
2. **Заголовки:** у тілі `##` / `###`, без дублювання головного `h1` з title сторінки.
3. **Код / налаштування:** блоки коду з міткою мови.
4. **Короткі абзаци**, списки, таблиці де доречно.
5. **Висновок** і практичні наступні кроки.

### Step 5: Interactive Components (опційно)

Після додавання React у проєкт:

1. `src/content/articles/{slug}/components/ComponentName.tsx`
2. Іменований експорт, Tailwind + DaisyUI.
3. У MDX: імпорт і `<ComponentName client:load />` (або `client:visible`).
4. Для UI — скіл **frontend-design**.

### Step 6: SEO

- Ключові фрази природно в title, description, підзаголовках.
- Хоча б одне **внутрішнє посилання** на іншу релевантну статтю **Gapta** (коли база статей є).
- Alt для зображень українською.
- Далі перед публікацією — скіл **seo-geo**.

## Категорії (приклади, ніша вишивка)

| ID (`category`)   | Фокус |
| ----------------- | ----- |
| `obladnannya`     | Машини вишивки, голки, п’яльця |
| `nythky-polotno` | Нитки, стабілізатори, тканини |
| `digitizing`      | Дизайни, формати файлів, ПЗ digitizing |
| `prohramne`       | Програми керування машиною |
| `oglyady`         | Огляди обладнання та матеріалів |
| `porady`          | Поради, усунення проблем, догляд |

Підлаштуй під реальні `categories` у колекції, коли вони з’являться.

## Автори

За замовчуванням: `leonid-m` (Leonid Maievskyi). Інші id — лише якщо вони є в `src/content/authors/`.

## Після написання

1. Рев’ю: `code-reviewer`, `seo-geo`
2. Обкладинка: `nano-banana-pro` (за потреби)
3. Збірка: **`npm run build`**
4. PR: GitHub MCP → **repo `Gapta`**, base **`main`**
5. Після merge: деплой з GitHub Actions ([deploy.yml](.github/workflows/deploy.yml))
