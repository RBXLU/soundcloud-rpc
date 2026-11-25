# soundcloud-rpc

**[English](#english) · [Русский](#русский)**

Discord Rich Presence for SoundCloud on Linux — shows what you're listening to
in the browser as **"Listening to SoundCloud"**, with the track title, artist,
artwork, a progress bar and a button that opens the track.

```
🎵 Listening to SoundCloud
   Я копаю
   так себе чел
   00:10 ━━━━━━━━──────── 01:05     [ Listen on SoundCloud ]
```

---

## English

### How it works

Browsers on Linux publish the media that is playing over **MPRIS** (D-Bus).
`soundcloud-rpc` watches for a player whose URL is on `soundcloud.com`, looks
up the artwork through SoundCloud's public oEmbed endpoint and sends it to the
Discord desktop app over its local IPC socket. No browser extension, no
third-party libraries, no tokens — a single Python file.

- The status appears while a track **plays** and disappears a few seconds
  after you pause or close the tab.
- Track changes and seeking are picked up automatically.
- If Discord is restarted, the script reconnects by itself.
- Works with native, Flatpak and Snap builds of Discord.

### Requirements

- Linux with systemd (user services)
- Python 3 and **python-dbus**
  (`python-dbus` on Arch, `python3-dbus` on Debian/Ubuntu/Fedora)
- Discord desktop app
- A browser that reports the page URL over MPRIS — **Firefox** is tested.
  Chromium-based browsers may not expose the URL, in which case nothing is shown.

### Installation

1. **Create a Discord application** — its name is what the status will say:
   open <https://discord.com/developers/applications> → **New Application** →
   name it `SoundCloud` → **Create**, then copy the **Application ID**.
   (Optionally upload a SoundCloud logo as the app icon.)
2. Install:
   ```sh
   git clone https://github.com/RBXLU/soundcloud-rpc.git
   cd soundcloud-rpc
   ./install.sh YOUR_APPLICATION_ID
   ```
   Without an argument the installer asks for the ID.

That's it — play something on soundcloud.com and check your Discord profile.

### Usage

```sh
systemctl --user status soundcloud-rpc     # is it running?
journalctl --user -u soundcloud-rpc -f     # live log
systemctl --user restart soundcloud-rpc    # restart
./uninstall.sh                             # remove (add --purge to forget the ID)
```

### Troubleshooting

- **Nothing appears.** In Discord: *Settings → Activity Privacy → Share your
  detected activities with others* must be on. Make sure the Discord desktop
  app (not the web version) is running.
- **SoundCloud logo instead of the artwork.** The artwork lookup failed; the
  script retries every 30 seconds. See the log.
- **The button is missing on your own profile.** Discord hides activity
  buttons from yourself — other people see it.

### License

[MIT](LICENSE)

---

## Русский

### Как это работает

Браузеры в Linux сообщают системе, что сейчас играет, через **MPRIS** (D-Bus).
`soundcloud-rpc` находит плеер, у которого адрес на `soundcloud.com`, берёт
обложку через открытый oEmbed SoundCloud и передаёт всё это в приложение
Discord через его локальный сокет. Не нужны ни расширение для браузера, ни
сторонние библиотеки, ни токены — это один файл на Python.

- Статус появляется, пока трек **играет**, и пропадает через несколько секунд
  после паузы или закрытия вкладки.
- Смена трека и перемотка подхватываются автоматически.
- Если перезапустить Discord, скрипт сам переподключится.
- Работает с обычным Discord, а также с версиями из Flatpak и Snap.

### Что нужно

- Linux с systemd (пользовательские службы)
- Python 3 и **python-dbus**
  (`python-dbus` в Arch, `python3-dbus` в Debian/Ubuntu/Fedora)
- Приложение Discord для компьютера
- Браузер, который передаёт адрес страницы через MPRIS — проверено с
  **Firefox**. Браузеры на Chromium могут не передавать адрес, и тогда статус
  не появится.

### Установка

1. **Создайте приложение Discord** — его название и будет написано в статусе:
   откройте <https://discord.com/developers/applications> → **New Application**
   → назовите `SoundCloud` → **Create** и скопируйте **Application ID**.
   (По желанию загрузите логотип SoundCloud как значок приложения.)
2. Установите:
   ```sh
   git clone https://github.com/RBXLU/soundcloud-rpc.git
   cd soundcloud-rpc
   ./install.sh ВАШ_APPLICATION_ID
   ```
   Если не указать ID, установщик спросит его сам.

Готово — включите что-нибудь на soundcloud.com и загляните в свой профиль Discord.

### Управление

```sh
systemctl --user status soundcloud-rpc     # работает ли
journalctl --user -u soundcloud-rpc -f     # журнал в реальном времени
systemctl --user restart soundcloud-rpc    # перезапуск
./uninstall.sh                             # удалить (с --purge — забыть и ID)
```

### Если что-то не так

- **Статус не появляется.** В Discord: *Настройки → Конфиденциальность
  активности → «Показывать обнаруженную активность»* должно быть включено.
  Проверьте, что запущено приложение Discord, а не веб-версия.
- **Вместо обложки логотип SoundCloud.** Обложку не удалось получить; скрипт
  повторяет попытку каждые 30 секунд. Подробности — в журнале.
- **В своём профиле не видно кнопки.** Discord не показывает кнопки активности
  самому себе — их видят другие.

### Лицензия

[MIT](LICENSE)
