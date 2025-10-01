# GNU Stow - Cheat Sheet

## Spis treści
- [Podstawowe komendy](#podstawowe-komendy)
- [Pierwsze uruchomienie](#pierwsze-uruchomienie)
- [Codzienne użycie](#codzienne-użycie)
- [Zarządzanie konfiguracjami](#zarządzanie-konfiguracjami)
- [Nowa maszyna](#nowa-maszyna)
- [Rozwiązywanie problemów](#rozwiązywanie-problemów)
- [Struktura katalogów](#struktura-katalogów)

## Podstawowe komendy

```bash
# Utworzenie symlinkow
stow pakiet

# Usunięcie symlinkow
stow -D pakiet

# Odświeżenie symlinkow (usuń + dodaj)
stow -R pakiet

# Symulacja (bez zmian)
stow -n pakiet

# Verbose (pokaż co robi)
stow -v pakiet

# Zainstaluj wszystko
stow */

# Custom target directory
stow -t /sciezka pakiet
```

## Pierwsze uruchomienie

### Krok 1: Utwórz strukturę
```bash
mkdir ~/dotfiles
cd ~/dotfiles
git init
```

### Krok 2: Przenieś istniejącą konfigurację
```bash
# Przykład dla hyprland
mkdir -p hyprland/.config
mv ~/.config/hyprland hyprland/.config/

# Przykład dla zsh
mkdir -p zsh
mv ~/.zshrc zsh/
```

### Krok 3: Linkuj z powrotem
```bash
cd ~/dotfiles
stow hyprland
stow zsh
```

### Krok 4: Git
```bash
git add .
git commit -m "Initial dotfiles"
git remote add origin git@github.com:user/dotfiles.git
git push -u origin main
```

## Codzienne użycie

### Edycja konfiguracji
```bash
# Edytujesz normalnie przez symlink
nvim ~/.config/hyprland/hyprland.conf

# Zmiany są automatycznie w ~/dotfiles/
cd ~/dotfiles
git status
git add .
git commit -m "Update config"
git push
```

### Dodanie nowej aplikacji
```bash
cd ~/dotfiles
mkdir -p kitty/.config/kitty
mv ~/.config/kitty/* kitty/.config/kitty/
stow kitty
git add kitty/
git commit -m "Add kitty"
```

### Usunięcie konfiguracji
```bash
cd ~/dotfiles
stow -D hyprland
# Pliki pozostają w ~/dotfiles/, tylko symlinki znikają
```

## Zarządzanie konfiguracjami

### Przełączanie między wersjami
```bash
# Masz: hyprland-work, hyprland-gaming
cd ~/dotfiles
stow -D hyprland-work
stow hyprland-gaming
```

### Dodanie nowych plików do istniejącego pakietu
```bash
# Dodajesz plik w ~/dotfiles/hyprland/.config/hyprland/scripts/
cd ~/dotfiles
stow -R hyprland  # odśwież
```

### Sprawdzenie co jest zlinkowane
```bash
# Sprawdź pojedynczy plik
ls -la ~/.config/hyprland

# Znajdź wszystkie symlinki
find ~ -type l -ls | grep dotfiles

# Test co by zrobił stow
cd ~/dotfiles
stow -n -v hyprland
```

## Nowa maszyna

```bash
# 1. Sklonuj
cd ~
git clone https://github.com/user/dotfiles.git
cd dotfiles

# 2. Zainstaluj wybrane
stow hyprland waybar kitty nvim zsh

# 3. Lub wszystko naraz
stow */
```

## Rozwiązywanie problemów

### Konflikt: plik już istnieje
```bash
# ERROR: existing target is neither a link nor a directory

# Opcja 1: Usuń istniejący
rm -rf ~/.config/hyprland
stow hyprland

# Opcja 2: Backup
mv ~/.config/hyprland ~/.config/hyprland.backup
stow hyprland

# Opcja 3: Adopt (przejmij istniejące do dotfiles)
stow --adopt hyprland
# UWAGA: nadpisuje pliki w ~/dotfiles/
```

### Ignorowanie plików
```bash
# Utwórz ~/dotfiles/.stow-local-ignore
cat > .stow-local-ignore << 'EOF'
README\.md
\.git
screenshots
\.DS_Store
EOF
```

### Naprawienie złych symlinkow
```bash
cd ~/dotfiles
stow -D pakiet  # usuń stare
stow pakiet     # dodaj nowe
```

## Struktura katalogów

### Prawidłowa struktura
```
~/dotfiles/
├── hyprland/
│   └── .config/
│       └── hyprland/
│           └── hyprland.conf
├── nvim/
│   └── .config/
│       └── nvim/
│           └── init.lua
├── zsh/
│   ├── .zshrc
│   └── .zsh/
└── git/
    └── .gitconfig
```

### Jak to działa
```bash
cd ~/dotfiles
stow hyprland

# Tworzy:
# ~/.config/hyprland -> ~/dotfiles/hyprland/.config/hyprland
```

### Domyślny target
Stow linkuje do katalogu nadrzędnego (parent directory).
Jeśli jesteś w `~/dotfiles`, linkuje do `~`.

## Przydatne aliasy

```bash
# Dodaj do ~/.zshrc lub ~/.bashrc
alias dotfiles='cd ~/dotfiles'
alias ds='cd ~/dotfiles && stow'
alias dsu='cd ~/dotfiles && stow -D'
alias dsr='cd ~/dotfiles && stow -R'
alias dsl='find ~/.config -type l -ls | grep dotfiles'
```

## Szybki workflow

```bash
# Nowa konfiguracja
cd ~/dotfiles
mkdir -p app/.config/app
mv ~/.config/app/* app/.config/app/
stow app
git add app && git commit -m "Add app" && git push

# Edycja
nvim ~/.config/app/config
cd ~/dotfiles && git add . && git commit -m "Update" && git push

# Usuń tymczasowo
cd ~/dotfiles && stow -D app

# Przywróć
cd ~/dotfiles && stow app
```