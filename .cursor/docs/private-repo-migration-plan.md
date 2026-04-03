# Деплой Gapta (орієнтир)

Цей файл раніше описував інший проєкт (Docker / artstroy). Для **Gapta** актуальне:

| Параметр | Значення |
|----------|----------|
| Репозиторій | [AZANIR/Gapta](https://github.com/AZANIR/Gapta) |
| Гілка CI | `main` |
| Workflow | [.github/workflows/deploy.yml](../../.github/workflows/deploy.yml) |
| Артефакт | вміст `dist/` після `npm run build` |
| Ціль на сервері | наприклад `/var/www/gapta.com.ua/` (див. workflow і [README.md](../../README.md)) |

Секрети GitHub Actions: `SSH_PRIVATE_KEY`, `REMOTE_HOST`, `REMOTE_USER`, `REMOTE_PORT` — у налаштуваннях репозиторію.

Якщо репозиторій зроблять приватним, достатньо щоб deploy-ключ і secrets лишались валідними; логіка rsync у workflow не залежить від публічності репо.
