# 🎬 **Catálogo de Filmes – Flutter**
[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)](https://flutter.dev/)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart&logoColor=white)](https://dart.dev/)
[![TMDB API](https://img.shields.io/badge/API-TMDB-90cea1?logo=themoviedatabase&logoColor=white)](https://www.themoviedb.org/)
[![Status](https://img.shields.io/badge/Status-Concluído-success)]()
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)]()

## 1. Descrição do Projeto

Este aplicativo foi desenvolvido como parte da disciplina de **Programação Mobile I** do curso de Análise e Desenvolvimento de Sistemas do **Instituto Federal de Rondônia (IFRO)**.

O objetivo do projeto é criar uma aplicação móvel utilizando o framework **Flutter** que consuma uma API REST pública para exibir um catálogo de filmes. A aplicação permite que o usuário pesquise por títulos, visualize detalhes técnicos (como sinopse, gêneros, produtoras e duração) e gerencie listas pessoais de filmes (Favoritos, Já Assistidos e Assistir Depois).

O projeto implementa conceitos fundamentais de desenvolvimento mobile, incluindo:
*   **Arquitetura de Software:** Separação de responsabilidades em Camadas (Models, Screens, Services, Providers).
*   **Integração de API:** Consumo de dados remotos via HTTP.
*   **Gerenciamento de Estado:** Uso do padrão Provider para reatividade.
*   **Persistência de Dados:** Armazenamento local de listas e histórico de busca.

### Capturas de Tela

| Tela Inicial | Detalhes do Filme | Listas Pessoais |
|:---:|:---:|:---:|
| ![Tela Inicial](caminho_para_print_home.png) | ![Detalhes](caminho_para_print_detalhes.png) | ![Favoritos](caminho_para_print_listas.png) |
> *Figura 1: Fluxo principal da aplicação (Home, Detalhes e Listas).*

---

## 2. API Utilizada

A aplicação consome dados da **The Movie Database (TMDB) API**.

*   **Documentação Oficial:** [https://developer.themoviedb.org/docs](https://developer.themoviedb.org/docs)
*   **Endpoints principais utilizados:**
    *   `GET /search/movie`: Para realizar a busca textual de títulos a partir da entrada do usuário.
    *   `GET /movie/{movie_id}`: Para obter os detalhes completos de uma obra específica (sinopse, poster, produtoras, etc).

---

## 3. Principais Packages e Dependências

Para atender aos requisitos funcionais e não-funcionais, foram utilizados os seguintes pacotes externos:

*   **`http`**: Responsável por realizar as requisições HTTP (GET) para a API do TMDB e lidar com as respostas JSON de forma assíncrona.
*   **`provider`**: Utilizado para o gerenciamento de estado da aplicação, permitindo que as listas de filmes sejam atualizadas reativamente entre as diferentes telas.
*   **`shared_preferences`**: Implementado para a persistência de dados local, garantindo que o histórico de busca e as listas do usuário sejam salvos no dispositivo.
*   **`flutter_svg`**: Utilizado para renderização de arquivos de imagem vetorial (.svg), assegurando a qualidade visual de ícones e logotipos.

---

## **4. Instruções de Execução**

Certifique-se de ter o [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado.
```bash
git clone https://github.com/ArmandoGT/Flutter-API-Catalog.git
cd catalogmovie 
flutter pub get 
flutter run
```

*Obs: Configure sua chave da API do TMDB em `lib/services/api_config_example.dart`, substitua 'Your-API-Key' pela a sua e retire "_example" do nome do arquivo.*

---

**Criado com dedicação 🧭 por [ArmandoGT](https://github.com/ArmandoGT)**
