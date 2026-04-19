# Lemoncode Módulo 8 · Cloud · Render + Docker

Ejercicio **opcional** del Máster Frontend de Lemoncode (Módulo 8 — Cloud)

Despliegue **automatizado** de una aplicación frontend en **Render** usando **Docker**

## Aplicación desplegada

Este repositorio **no contiene el código fuente**. El `Dockerfile` clona
el repo [Portfolio](https://github.com/SergioSuarezGil/Portfolio) durante
el build, así el mismo código sirve en varios entornos sin duplicación

**URL del despliegue:**
https://lemoncode-mod8-cloud-render.onrender.com

## Arquitectura

Multi-stage build definido en el [`Dockerfile`](./Dockerfile):

- **Build stage** (`node:24-alpine`): clona el repo Portfolio y compila
  con Vite (`npm ci && npm run build`) → genera `dist/`
- **Serve stage** (`nginx:alpine`): sirve `dist/` con Nginx escuchando en
  el puerto que Render inyecta vía `$PORT` (resuelto con `envsubst` sobre
  [`nginx.conf`](./nginx.conf))

- **Tipo de servicio:** Render **Web Service** (Docker)
- **Plan:** Free
- **Hosting:** contenedor Nginx en la infraestructura de Render con HTTPS automático

## Configuración en Render

1. [dashboard.render.com](https://dashboard.render.com) → **New → Web Service**
2. Conectar la cuenta de GitHub y seleccionar **este** repo
   (`Lemoncode_Mod8_Cloud_Render`)
3. Render detecta el `Dockerfile` automáticamente:
   - **Environment:** Docker
   - **Branch:** `main`
   - **Auto-Deploy:** `Yes`

## Despliegue automatizado

A diferencia del ejercicio manual, cada push dispara un rebuild sin intervención:

```
1. git push a main (en este repo)
2. Render detecta el webhook de GitHub
3. docker build (clona Portfolio + npm build + nginx image)
4. Rollout de la nueva imagen sin downtime
```

## Probarlo previamente en local

Para probarlo en local he seguido estos pasos

```bash
docker build -t portfolio-render .
docker run --rm -p 8080:10000 portfolio-render
# Abrir http://localhost:8080
```

## Autor

Sergio Suárez — [@SergioSuarezGil](https://github.com/SergioSuarezGil)
