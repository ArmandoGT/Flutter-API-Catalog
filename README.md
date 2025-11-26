# Catálogo de Filmes - Atividade Avaliativa

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
| ![Tela Inicial](.png) | ![Detalhes](.png) | ![Favoritos](.png) |
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

*   **`http`**
    *   Responsável por realizar as requisições HTTP (GET) para a API do TMDB e lidar com as respostas JSON de forma assíncrona.
*   **`provider`**
    *   Utilizado para o gerenciamento de estado da aplicação. Ele permite que as listas de filmes (favoritos, assistidos, pendentes) sejam atualizadas reativamente entre as diferentes telas sem a necessidade de *prop drilling*.
*   **`shared_preferences`**
    *   Implementado para a persistência de dados local (armazenamento *key-value*). Garante que o histórico de busca e as listas do usuário sejam salvos no dispositivo e recuperados ao reiniciar o app.
*   **`flutter_svg`**
    *   Utilizado para renderização de arquivos de imagem vetorial (.svg), assegurando a qualidade visual de ícones e logotipos (ex: logo do TMDB na tela "Sobre Nós").

---

## 4. Instruções de Execução

Para executar este projeto em seu ambiente local, certifique-se de ter o [Flutter SDK](https://docs.flutter.dev/get-started/install) instalado e configurado.

### Passo 1: Clonar o repositório
