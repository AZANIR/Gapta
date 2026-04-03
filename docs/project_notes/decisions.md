# Архітектурні рішення (ADR) — Gapta

Нумерація послідовно: ADR-001, ADR-002, …

---

### ADR-001: Tailwind CSS v4 через `@tailwindcss/vite` (2026-04-03)

**Контекст:**
- `@astrojs/tailwind` v6 орієнтований на Tailwind v3; з Tailwind v4 збірка падає (PostCSS-плагін винесено окремо).

**Рішення:**
- Використовувати офіційний плагін **`@tailwindcss/vite`** у `astro.config.mjs` (`vite.plugins`).
- Глобальні стилі: `src/styles/global.css` з `@import 'tailwindcss'` та `@plugin 'daisyui'`.

**Альтернативи:**
- Відкат на Tailwind v3 + `@astrojs/tailwind` — відхилено: хотіли залишитись на v4.

**Наслідки:**
- Збірка `npm run build` стабільна на Tailwind 4 + DaisyUI 5.
- Документація Astro/AGENTS має відповідати фактичному стеку.
