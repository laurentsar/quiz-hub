// Service worker minimal pour la page portail : met en cache la coquille du hub.
// Chaque application (langue/, revision/) gère son propre cache offline.
const CACHE = 'quiz-hub-v1';
const SHELL = ['./', './index.html', './style.css', './manifest.webmanifest'];

self.addEventListener('install', (e) => {
  e.waitUntil(caches.open(CACHE).then((c) => c.addAll(SHELL)).then(() => self.skipWaiting()));
});
self.addEventListener('activate', (e) => {
  e.waitUntil(caches.keys().then((keys) =>
    Promise.all(keys.filter((k) => k !== CACHE).map((k) => caches.delete(k)))
  ).then(() => self.clients.claim()));
});
self.addEventListener('fetch', (e) => {
  const url = new URL(e.request.url);
  // On ne gère que la coquille du portail ; on laisse passer le reste (les
  // sous-apps ont leur propre service worker).
  if (url.origin === location.origin && SHELL.some((p) => url.pathname.endsWith(p.replace('./', '/')))) {
    e.respondWith(caches.match(e.request).then((r) => r || fetch(e.request)));
  }
});
