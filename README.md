# Lemoncode Módulo 8 · Cloud · Render + Docker

Ejercicio **opcional** del Máster Frontend de Lemoncode (Módulo 8 — Cloud).
Despliegue automatizado de una aplicación frontend en **Render** usando **Docker**.

**Build stage** (`node:24-alpine`): clona el código del repo
[Portfolio](https://github.com/SergioSuarezGil/Portfolio) y lo compila
con Vite (`npm run build`). Genera la carpeta `dist/` con HTML, CSS y JS
optimizados.

**Serve stage** (`nginx:alpine`): sirve los archivos estáticos de `dist/`
con Nginx. El puerto de escucha se inyecta desde la variable `$PORT` que
Render asigna dinámicamente (por eso usamos `envsubst` en el `CMD`).

## Aplicación desplegada

Este repositorio **no contiene el código fuente**. El `Dockerfile` clona
el repo público [Portfolio](https://github.com/SergioSuarezGil/Portfolio)
durante el build. Así el mismo código sirve en varios entornos
(GitHub Pages + Render) sin duplicación.

**URL del despliegue:**

https://lemoncode-mod8-cloud-render.onrender.com

[APP DESPLEGADA](https://lemoncode-mod8-cloud-render.onrender.com)


## Probar en local

```bash
docker build -t portfolio-render .
docker run --rm -p 8080:10000 portfolio-render
# Abrir http://localhost:8080
```

## Autor

Sergio Suárez — [@SergioSuarezGil](https://github.com/SergioSuarezGil)
