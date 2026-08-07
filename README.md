# Mes Quiz — page portail

Une seule page web qui donne accès aux **deux applications de révision**, sans
authentification (comme GestHôte) :

- **VocaLang** (`www/langue/`) — vocabulaire anglais/espagnol, grammaire, verbes.
- **CyberRévision** (`www/revision/`) — cybersécurité, homologation, certifications.

Chaque app est une PWA autonome (offline, progression en `localStorage`). Le
portail (`www/index.html`) ne fait que les lister.

## Mettre à jour le contenu

Les deux apps sont **recopiées** dans `www/langue` et `www/revision`. Après une
modification de `~/quiz-app` ou `~/quiz-thales` :

```bash
./sync.sh          # resync les deux apps depuis ~/quiz-app et ~/quiz-thales
git add -A && git commit -m "sync apps" && git push
```

## Publication web (GitHub Pages, public, sans login)

Même schéma que GestHôte. Une seule fois :

1. Créer le dépôt **public** `laurentsar/quiz-hub` et `git push`.
2. Le workflow `.github/workflows/pages.yml` publie `www/` sur la branche
   `gh-pages` à chaque push (via `peaceiris/actions-gh-pages`).
3. `github.com/laurentsar/quiz-hub/settings/pages` → Source **Deploy from a
   branch** → `gh-pages` / `(root)` → **Save**.
4. URL publique : `https://laurentsar.github.io/quiz-hub/`

## Accès réseau local (Home Assistant)

Le dossier `www/` est aussi déployable tel quel sur HA :
`http://192.168.1.172:8123/local/quiz-hub/index.html` (LAN, sans login).
