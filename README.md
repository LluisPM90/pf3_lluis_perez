# PF3 – Rick and Morty API (Flutter)

Práctica Final 3  
Módulo: Programación Multimèdia i Dispositius Mòbils  
Curso: 2025–2026  
Alumno: Lluís Pérez  
Repositorio: pf3_lluis_perez  

---

## 📱 Descripción del proyecto

Aplicación móvil desarrollada con **Flutter** que consume la **Rick and Morty API** para mostrar un listado de personajes de la serie.

La aplicación presenta:
- Una pantalla principal con **CardSwiper** y **Slider**
- Una pantalla de detalle con información completa de cada personaje
- Consumo de una API REST en formato JSON
- Modelado de datos generado con **quicktype**

Este proyecto se ha realizado como práctica individual siguiendo las directrices indicadas en el enunciado de la **Práctica Final 3**.

---

## 🌐 API utilizada

Rick and Morty API (REST – JSON)

- Listado de personajes:  
  https://rickandmortyapi.com/api/character
- Detalle de personaje:  
  https://rickandmortyapi.com/api/character/{id}

La API proporciona:
- Listado de elementos
- Imágenes mediante URL
- Información adicional (estado, especie, género, origen, etc.)

---

## 🧩 Funcionalidades principales

- Visualización de personajes mediante **CardSwiper**
- Carrusel adicional mediante **Slider**
- Navegación a pantalla de detalle
- Carga de imágenes desde URL
- Gestión de estados de carga y error
- Arquitectura basada en separación de:
  - Models
  - Services
  - Screens

---

## 🛠️ Tecnologías y librerías

- Flutter
- Dart
- HTTP
- flutter_card_swiper
- carousel_slider

---

## ▶️ Ejecución del proyecto

1. Clonar el repositorio:
   ```bash
   git clone https://github.com/LluisPM90/pf3_lluis_perez.git
