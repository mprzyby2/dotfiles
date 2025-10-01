# 🎨 Wallpaper Filter Manager dla Omarchy

Zaawansowany system zarządzania filtrami tapet dla Hyprland z systemem Omarchy. Umożliwia kumulacyjne nakładanie filtrów na tapety z możliwością resetu do oryginału.

## ✨ Funkcje

- **Kumulacja filtrów** - nakładaj filtry jeden na drugi (np. blur + sepia + brightness)
- **Automatyczna detekcja zmian** - wykrywa gdy zmienisz tapetę przez Omarchy
- **40+ filtrów** - od podstawowych (grayscale, sepia) po zaawansowane (VHS, CRT, cartoon)
- **Szybki reset** - jeden przycisk wraca do oryginału
- **Integracja z Walker** - ładne menu w stylu Omarchy
- **Historia filtrów** - zapisuje kolejność zastosowanych efektów

## 📦 Wymagania

Przed instalacją upewnij się że masz zainstalowane:

```bash
# Sprawdź co masz:
which walker         # Walker (launcher używany przez Omarchy)
which magick         # ImageMagick v7+ (do przetwarzania obrazów)
which swaybg         # swaybg (używane przez Omarchy do tapet)
```

Jeśli czegoś brakuje:

```bash
# Arch Linux / Omarchy:
sudo pacman -S imagemagick walker
```

## 🚀 Instalacja

### Krok 1: Zapisz skrypt

```bash
# Stwórz folder na skrypty
mkdir -p ~/.config/hypr/scripts

# Skopiuj skrypt
nano ~/.config/hypr/scripts/wallpaper-filter
```

Wklej zawartość ze skryptu `wallpaper-filter` (dostępny w artefakcie), zapisz i zamknij.

### Krok 2: Nadaj uprawnienia

```bash
chmod +x ~/.config/hypr/scripts/wallpaper-filter
```

### Krok 3: Dodaj skróty klawiszowe

Edytuj konfigurację Hyprland:

```bash
nano ~/.config/hypr/hyprland.conf
```

Dodaj na końcu (Omarchy używa `bindd` z opisami):

```conf
# ============================================
# Wallpaper Filter Manager
# ============================================

# Otwórz menu filtrów
bindd = SUPER CONTROL SHIFT, W, Open wallpaper filter menu, exec, ~/.config/hypr/scripts/wallpaper-filter

# Szybki reset do oryginału
bindd = SUPER CONTROL SHIFT, R, Reset wallpaper to original, exec, ~/.config/hypr/scripts/wallpaper-filter reset

# Opcjonalne: Szybkie filtry
bindd = SUPER CONTROL, 1, Wallpaper: original, exec, ~/.config/hypr/scripts/wallpaper-filter none
bindd = SUPER CONTROL, 2, Wallpaper: mono gray, exec, ~/.config/hypr/scripts/wallpaper-filter mono-gray
bindd = SUPER CONTROL, 3, Wallpaper: mono blue, exec, ~/.config/hypr/scripts/wallpaper-filter mono-blue
bindd = SUPER CONTROL, 4, Wallpaper: blur, exec, ~/.config/hypr/scripts/wallpaper-filter blur
bindd = SUPER CONTROL, 5, Wallpaper: sepia, exec, ~/.config/hypr/scripts/wallpaper-filter sepia
```

**Uwaga:** Omarchy używa formatu `bindd` (bind with description) zamiast zwykłego `bind`, oraz spacji zamiast podkreślników w modyfikatorach (`SUPER CONTROL` nie `SUPER_CTRL`).

### Krok 4: Przeładuj konfigurację

```bash
hyprctl reload
```

Lub wyloguj się i zaloguj ponownie.

## 🎮 Instrukcja użytkowania

### Podstawowe użycie

**Menu filtrów:**
- Naciśnij `SUPER + CTRL + SHIFT + W`
- Wybierz filtr z listy
- Tapeta zmienia się natychmiast

**Szybki reset:**
- Naciśnij `SUPER + CTRL + SHIFT + R`
- Wraca do oryginalnej tapety

**Szybkie filtry (bez menu):**
- `SUPER + CTRL + 2` → czarno-białe
- `SUPER + CTRL + 3` → niebieskie mono
- `SUPER + CTRL + 4` → rozmycie
- `SUPER + CTRL + 5` → sepia

### Użycie przez terminal

```bash
# Zastosuj filtr
~/.config/hypr/scripts/wallpaper-filter mono-blue

# Nakładaj kolejne filtry (kumulacja)
~/.config/hypr/scripts/wallpaper-filter blur
~/.config/hypr/scripts/wallpaper-filter brightness-up
~/.config/hypr/scripts/wallpaper-filter sepia

# Reset do oryginału
~/.config/hypr/scripts/wallpaper-filter reset
```

## 📚 Lista dostępnych filtrów

### 🎨 Podstawowe
- `none` - oryginał (bez zmian)
- `mono-gray` - czarno-białe
- `invert` - odwrócone kolory
- `sepia` - stary, brązowy odcień

### 🌈 Kolory monochromatyczne
- `mono-blue` - niebieski odcień
- `mono-red` - czerwony odcień
- `mono-green` - zielony odcień
- `mono-purple` - fioletowy odcień
- `mono-orange` - pomarańczowy odcień
- `mono-cyan` - cyjanowy odcień
- `mono-pink` - różowy odcień

### 🎭 Artystyczne
- `oil-paint` - obraz farbami olejnymi
- `watercolor` - efekt akwareli
- `sketch` - szkic ołówkiem
- `charcoal` - rysunek węglem
- `posterize` - efekt plakatu (mniej kolorów)
- `cartoon` - efekt kreskówki

### 🌫️ Rozmycie
- `blur` - rozmycie gaussowskie
- `motion-blur` - rozmycie ruchu
- `radial-blur` - rozmycie radialne
- `pixelate` - pikselizacja

### 💡 Światło i kolory
- `brightness-up` - zwiększ jasność
- `brightness-down` - zmniejsz jasność
- `contrast-up` - zwiększ kontrast
- `contrast-down` - zmniejsz kontrast
- `saturate` - zwiększ nasycenie
- `desaturate` - zmniejsz nasycenie
- `vignette` - ciemne rogi
- `glow` - poświata

### 🎞️ Tekstury
- `noise` - szum elektroniczny
- `film-grain` - ziarno filmowe
- `emboss` - wytłoczenie 3D
- `sharpen` - wyostrzenie

### 📼 Retro/Vintage
- `vhs` - efekt taśmy VHS
- `crt` - efekt starego monitora
- `faded` - wyblaknięte kolory

## 🎨 Przykładowe kombinacje

### Vintage Look
```bash
wallpaper-filter faded
wallpaper-filter sepia
wallpaper-filter film-grain
wallpaper-filter vignette
```
**Efekt:** Stara, wyblaknięta fotografia z ziarnistością i ciemnymi rogami

### Neon Cyberpunk
```bash
wallpaper-filter mono-cyan
wallpaper-filter saturate
wallpaper-filter glow
wallpaper-filter contrast-up
```
**Efekt:** Intensywny neonowy cyjanowy z poświatą

### Artystyczny szkic
```bash
wallpaper-filter sketch
wallpaper-filter mono-purple
wallpaper-filter vignette
```
**Efekt:** Fioletowy szkic artystyczny

### Retro Gaming
```bash
wallpaper-filter pixelate
wallpaper-filter crt
wallpaper-filter contrast-up
```
**Efekt:** Stary ekran CRT z pikselami

### Mglisty poranek
```bash
wallpaper-filter desaturate
wallpaper-filter blur
wallpaper-filter brightness-down
wallpaper-filter vignette
```
**Efekt:** Mglisty, stonowany krajobraz

### Film noir
```bash
wallpaper-filter mono-gray
wallpaper-filter contrast-up
wallpaper-filter film-grain
wallpaper-filter vignette
```
**Efekt:** Czarno-biały film z lat 40-tych

## 🔧 Jak to działa

### Kumulacja filtrów

System działa na zasadzie kumulacji - każdy kolejny filtr jest nakładany na poprzedni wynik:

```
Oryginał → Brightness Up → Stan 1 (+jasność)
Stan 1 → Blur → Stan 2 (+jasność +blur)
Stan 2 → Sepia → Stan 3 (+jasność +blur +sepia)
```

### Automatyczna detekcja zmian tapety

Gdy zmienisz tapetę przez Omarchy (np. `omarchy-theme-bg-next`), skrypt:
1. Wykrywa nową tapetę (sprawdza checksum MD5)
2. Automatycznie zapisuje ją jako nowy oryginał
3. Czyści historię filtrów
4. Pozwala nakładać nowe filtry

### Reset

Przycisk "RESET TO ORIGINAL" lub komenda `reset`:
- Przywraca prawdziwy oryginał (sprzed wszelkich filtrów)
- Czyści historię filtrów
- Resetuje checksum

## 📁 Struktura plików

```
~/.config/hypr/
├── hyprland.conf                    # Twoja konfiguracja z keybindami
└── scripts/
    └── wallpaper-filter             # Główny skrypt

~/.cache/wallpapers/                 # Cache (automatycznie tworzony)
├── true_original.jpg                # Prawdziwy oryginał (backup)
├── current_state.jpg                # Obecny stan po filtrach
├── current_filtered.jpg             # Plik tymczasowy
├── wallpaper_checksum.txt           # MD5 do detekcji zmian
└── filter_history.txt               # Historia zastosowanych filtrów
```

## 🐛 Rozwiązywanie problemów

### Menu się nie otwiera

```bash
# Sprawdź czy Walker jest zainstalowany
which walker

# Test ręczny skryptu
~/.config/hypr/scripts/wallpaper-filter

# Zobacz błędy
~/.config/hypr/scripts/wallpaper-filter 2>&1 | less
```

### Filtry nie działają

```bash
# Sprawdź ImageMagick
which magick
magick -version

# Jeśli masz starą wersję (convert zamiast magick):
# W skrypcie zamień CONVERT_CMD="magick" na CONVERT_CMD="convert"

# Test konkretnego filtra z debugowaniem
~/.config/hypr/scripts/wallpaper-filter mono-blue 2>&1
```

### Tapeta nie zmienia się

```bash
# Sprawdź czy swaybg działa
ps aux | grep swaybg

# Restart swaybg
killall swaybg
swaybg -i ~/.config/omarchy/current/background -m fill &

# Sprawdź uprawnienia
ls -la ~/.config/omarchy/current/background
ls -la ~/.cache/wallpapers/
```

### Reset nie działa poprawnie

```bash
# Usuń cache i zacznij od nowa
rm -rf ~/.cache/wallpapers
~/.config/hypr/scripts/wallpaper-filter

# Spowoduje to:
# 1. Zapisanie obecnej tapety jako nowy oryginał
# 2. Wyczyszczenie całej historii
```

### Nowa tapeta nie jest wykrywana

```bash
# Sprawdź czy checksum się zmienia
md5sum ~/.config/omarchy/current/background

# Wymuś nową tapetę jako oryginał
rm ~/.cache/wallpapers/wallpaper_checksum.txt
~/.config/hypr/scripts/wallpaper-filter
```

### Powiadomienia nie działają

```bash
# Sprawdź czy masz notify-send
which notify-send

# Test powiadomienia
notify-send "Test" "Działa?"

# Jeśli nie masz, zainstaluj:
sudo pacman -S libnotify
```

## 🎯 Customizacja

### Zmiana skrótów klawiszowych

Edytuj `~/.config/hypr/hyprland.conf` i zmień keybindy według preferencji.

**Pamiętaj:** Omarchy używa formatu `bindd` z opisami i spacji w modyfikatorach:

```conf
# Przykład: Zmień na SUPER + W
bindd = SUPER, W, Open wallpaper filters, exec, ~/.config/hypr/scripts/wallpaper-filter

# Przykład: Dodaj więcej szybkich filtrów
bindd = SUPER CONTROL, 6, Wallpaper: cartoon, exec, ~/.config/hypr/scripts/wallpaper-filter cartoon
bindd = SUPER CONTROL, 7, Wallpaper: VHS effect, exec, ~/.config/hypr/scripts/wallpaper-filter vhs
bindd = SUPER CONTROL, 8, Wallpaper: glow, exec, ~/.config/hypr/scripts/wallpaper-filter glow
```

Format Omarchy `bindd`:
```conf
bindd = MODYFIKATORY, KLAWISZ, Opis keybinda, exec, komenda
```

**Nie używaj:** `SUPER_CTRL_SHIFT` (podkreślniki)  
**Używaj:** `SUPER CONTROL SHIFT` (spacje)

### Modyfikacja intensywności filtrów

W skrypcie możesz dostosować parametry filtrów. Przykłady:

```bash
# Silniejsze rozmycie (zmień 0x8 na 0x15)
"blur")
    $CONVERT_CMD "$source" -blur 0x15 "$FILTERED_OUTPUT"
    ;;

# Więcej ziarna filmowego (zmień 0.3 na 0.5)
"film-grain")
    $CONVERT_CMD "$source" +noise Gaussian -attenuate 0.5 "$FILTERED_OUTPUT"
    ;;

# Mocniejszy sepia (zmień 80% na 100%)
"sepia")
    $CONVERT_CMD "$source" -sepia-tone 100% "$FILTERED_OUTPUT"
    ;;
```

### Dodanie własnych filtrów

W sekcji `case $filter in` dodaj nowy filtr:

```bash
"my-custom-filter")
    $CONVERT_CMD "$source" -modulate 120,80,100 -blur 0x2 "$FILTERED_OUTPUT"
    ;;
```

Następnie dodaj go do menu:

```bash
FILTER=$(echo -e "\
...
━━━ Moje Filtry ━━━
  My Custom Filter
..." | walker --dmenu --theme dmenu_250 -p "Wallpaper Filter…")
```

I w mapowaniu:

```bash
*My\ Custom\ Filter*) apply_filter "my-custom-filter" ;;
```

## 📝 Notatki

- **Jakość obrazu:** Wielokrotne nakładanie filtrów może obniżyć jakość - używaj resetu gdy zauważysz pogorszenie
- **Performance:** Niektóre filtry (cartoon, crt) mogą trwać 2-3 sekundy na dużych rozdzielczościach
- **Cache:** Folder `~/.cache/wallpapers/` można bezpiecznie usunąć - zostanie odtworzony
- **Backup:** Prawdziwy oryginał jest zawsze bezpieczny w `true_original.jpg`

## 🤝 Wsparcie

Jeśli napotkasz problemy:

1. Sprawdź sekcję "Rozwiązywanie problemów" powyżej
2. Uruchom skrypt z debugowaniem: `bash -x ~/.config/hypr/scripts/wallpaper-filter 2>&1 | less`
3. Sprawdź logi Hyprland: `hyprctl logs` lub `journalctl --user -u hyprland`

## 📜 Licencja

Ten skrypt jest wolnym oprogramowaniem. Możesz go używać, modyfikować i dystrybuować według własnych potrzeb.

## 🎉 Enjoy!

Miłego eksperymentowania z filtrami! Pamiętaj - kombinuj, testuj i twórz unikalne efekty wizualne dla swojego desktopu. 🚀