# Guía: Botón "Actualizar" in-app para una PWA (Next.js + serwist)

Esta guía explica cómo darle a una PWA la capacidad de **avisar al usuario que hay
una versión nueva** y actualizarse con un botón, **sin que el usuario tenga que
desinstalar la app ni borrar los datos del navegador**.

Está probada en producción en la app *Sostenibilidad Páramos* (Next.js 14 App
Router + `@serwist/next`). Si tu otra app usa el mismo stack, es prácticamente
copiar y pegar.

---

## 1. ¿Qué problema resuelve?

Una PWA guarda una copia de la app en el dispositivo (mediante un *service
worker*). Por defecto, cuando publicas cambios, el usuario puede quedarse con la
versión vieja hasta que el navegador decida actualizar — y muchos usuarios
terminan desinstalando y reinstalando, lo cual es tedioso y **borra sus datos
offline**.

Con este mecanismo:
1. Cuando hay una versión nueva, aparece una **barra pulsante** "✨ Nueva versión
   disponible" con un botón **"Actualizar ahora"**.
2. Al presionarlo, la app activa la versión nueva y se **recarga sola** (1–2 s).
3. Los datos offline (IndexedDB / localStorage) **no se pierden**.

---

## 2. Cómo funciona (resumen técnico)

- Por defecto serwist usa `skipWaiting: true`: la versión nueva se activa sola y
  sin avisar. Eso **impide** un botón controlado.
- El truco es poner **`skipWaiting: false`**: así la versión nueva queda "en
  espera" (*waiting*) hasta que el usuario la confirme.
- Un componente cliente (`UpdateBanner`) detecta esa versión en espera, muestra la
  barra, y al hacer clic le manda el mensaje `SKIP_WAITING` al service worker para
  que se active. Luego recarga la página una sola vez.

> ⚠️ La **primera** instalación no se ve afectada: cuando no hay un service worker
> previo, la app se activa de inmediato igual (gracias a `clientsClaim: true`).

---

## 3. Los 3 cambios (copiar y pegar)

### Cambio A — Service worker (`app/sw.js`)

Dentro de `new Serwist({ ... })`, cambia `skipWaiting` a `false` (deja
`clientsClaim: true`):

```js
const serwist = new Serwist({
  precacheEntries: self.__SW_MANIFEST,
  skipWaiting: false,   // ← la versión nueva ESPERA a que el usuario confirme
  clientsClaim: true,
  // ...el resto de tu configuración igual...
});

serwist.addEventListeners();

// Activar la versión en espera cuando el cliente lo pide (botón "Actualizar").
self.addEventListener('message', (event) => {
  if (event.data && event.data.type === 'SKIP_WAITING') {
    self.skipWaiting();
  }
});
```

> Nota: serwist ya añade su propio listener de `SKIP_WAITING` cuando
> `skipWaiting: false`. Dejar el listener manual es redundante pero inofensivo, y
> hace el comportamiento explícito.

### Cambio B — Componente del aviso (`components/UpdateBanner.jsx`)

Crea este archivo. **Cambia los colores** (`bg-pnn-azul`, `text-pnn-azul`) por los
de tu app — por ejemplo `bg-blue-600` / `text-blue-600`.

```jsx
'use client';
import { useState, useEffect, useRef } from 'react';

export default function UpdateBanner() {
  const [updateReady, setUpdateReady] = useState(false);
  const [applying, setApplying] = useState(false);
  const reloadingRef = useRef(false);

  useEffect(() => {
    if (typeof navigator === 'undefined' || !('serviceWorker' in navigator)) return;

    let reg;
    let interval;

    // Recargar una sola vez cuando el nuevo SW toma control.
    const onControllerChange = () => {
      if (reloadingRef.current) return;
      reloadingRef.current = true;
      window.location.reload();
    };
    navigator.serviceWorker.addEventListener('controllerchange', onControllerChange);

    // Mostrar la barra solo si hay una versión en espera Y ya había un SW activo
    // (es una actualización, no la primera instalación).
    const checkWaiting = () => {
      if (reg?.waiting && navigator.serviceWorker.controller) {
        setUpdateReady(true);
      }
    };

    const checkForUpdate = () => {
      if (reg) reg.update().catch(() => {});
    };

    const onVisibility = () => {
      if (document.visibilityState === 'visible') checkForUpdate();
    };

    navigator.serviceWorker.getRegistration().then((registration) => {
      if (!registration) return;
      reg = registration;

      checkWaiting();

      reg.addEventListener('updatefound', () => {
        const nuevo = reg.installing;
        if (!nuevo) return;
        nuevo.addEventListener('statechange', () => {
          if (nuevo.state === 'installed') checkWaiting();
        });
      });

      // Revisar al abrir, al volver a primer plano y cada 30 min.
      checkForUpdate();
      document.addEventListener('visibilitychange', onVisibility);
      interval = setInterval(checkForUpdate, 30 * 60 * 1000);
    });

    return () => {
      navigator.serviceWorker.removeEventListener('controllerchange', onControllerChange);
      document.removeEventListener('visibilitychange', onVisibility);
      if (interval) clearInterval(interval);
    };
  }, []);

  const recargarUnaVez = () => {
    if (reloadingRef.current) return;
    reloadingRef.current = true;
    window.location.reload();
  };

  const aplicarActualizacion = async () => {
    setApplying(true);
    const registration = await navigator.serviceWorker.getRegistration();
    const waiting = registration?.waiting;

    if (waiting) {
      waiting.addEventListener('statechange', () => {
        if (waiting.state === 'activated') recargarUnaVez();
      });
      waiting.postMessage({ type: 'SKIP_WAITING' });
    }

    // Red de seguridad: recargar en máximo 2.5 s pase lo que pase.
    setTimeout(recargarUnaVez, 2500);
  };

  if (!updateReady) return null;

  return (
    <div className="py-2 px-4 text-xs font-bold text-white bg-pnn-azul shadow-md flex items-center justify-between animate-pulse">
      <span className="flex items-center gap-2">
        <span className="w-2 h-2 rounded-full bg-white animate-ping" />
        ✨ Nueva versión disponible
      </span>
      <button
        onClick={aplicarActualizacion}
        disabled={applying}
        className="ml-4 bg-white text-pnn-azul px-3 py-1 rounded-full text-[10px] hover:bg-blue-50 transition-colors uppercase disabled:opacity-70"
      >
        {applying ? 'Actualizando…' : 'Actualizar ahora'}
      </button>
    </div>
  );
}
```

### Cambio C — Montar el aviso en el layout

Muéstralo en el layout que envuelve las pantallas de la app (donde el usuario ya
está dentro). Importa y renderiza el componente cerca del tope:

```jsx
import UpdateBanner from '@/components/UpdateBanner';

// ...dentro del return del layout, arriba del contenido:
<UpdateBanner />
```

> El aviso solo aparece en las rutas donde montes `<UpdateBanner />`. Si lo pones
> únicamente en el layout interno, **no saldrá en la pantalla de login** (que suele
> estar en otro grupo de rutas). Si lo quieres en todas partes, móntalo en el
> layout raíz.

---

## 4. Detalles clave que evitan dolores de cabeza

1. **`skipWaiting: false` es el cambio central.** Sin eso, no hay botón posible.
2. **La red de seguridad (`setTimeout(recargarUnaVez, 2500)`) es importante.** En
   algunos navegadores el evento `controllerchange` no dispara de forma confiable;
   el timeout garantiza que la app se recargue siempre.
3. **El código que muestra y maneja el botón corre desde la versión ACTIVA.** Por
   eso, si arreglas el `UpdateBanner`, el arreglo solo toma pleno efecto una vez que
   esa versión arreglada quede activa (la primera vez puede requerir cerrar y
   reabrir la app una sola vez).
4. **Los datos offline están a salvo:** recargar la página no toca IndexedDB ni
   localStorage. El service worker solo cambia el "cascarón" de la app.

---

## 5. Cómo probarlo

Serwist normalmente está **deshabilitado en desarrollo** (`npm run dev`), así que
hay que probar con el build de producción:

1. `npm run build` y `npm run start`. Abre en Chrome (no incógnito) y entra a la app.
2. Haz un cambio visible cualquiera (por ejemplo un texto). Vuelve a
   `npm run build` + `npm run start`.
3. **Recarga** la app y espera 2–3 segundos → debe aparecer la **barra**.
4. Presiona **"Actualizar ahora"** → la app se recarga sola y el cambio aparece.

Truco para verlo claro: pon un marcador visible tipo `(v1)`, `(v2)`, `(v3)` en una
pantalla y ve cómo cambia el número al actualizar.

---

## 6. Texto listo para pegarle a Claude en otra app Next.js

> Quiero agregar un botón in-app de "Actualizar" para mi PWA (Next.js App Router
> con `@serwist/next`), igual al patrón estándar de update-prompt. Haz estos 3
> cambios:
>
> 1. En mi service worker (`app/sw.js` o equivalente), dentro de `new Serwist({…})`
>    cambia `skipWaiting` a `false` (deja `clientsClaim: true`) y agrega un listener
>    `self.addEventListener('message', e => { if (e.data?.type === 'SKIP_WAITING')
>    self.skipWaiting(); })`.
> 2. Crea `components/UpdateBanner.jsx`: un componente cliente que con
>    `navigator.serviceWorker.getRegistration()` detecte `reg.waiting`/`updatefound`,
>    revise actualizaciones al montar, en `visibilitychange` y cada 30 min, muestre
>    una barra pulsante "Nueva versión disponible" con un botón que haga
>    `waiting.postMessage({type:'SKIP_WAITING'})`, recargue en `controllerchange` y
>    tenga una red de seguridad `setTimeout(reload, 2500)`. Usa los colores de mi app.
> 3. Monta `<UpdateBanner />` en el layout interno de la app.
>
> Luego pruébalo con `npm run build` + `npm run start` haciendo dos builds.

---

*Referencia de la implementación original: commit `feat(pwa): boton "Actualizar"
in-app…` en el repo Sostenibilidad Páramos. Archivos: `app/sw.js`,
`components/UpdateBanner.jsx`, `app/(app)/layout.jsx`.*
