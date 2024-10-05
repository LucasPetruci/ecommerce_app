# Aplicativo de E-commerce Flutter

Um aplicativo de e-commerce desenvolvido com **Flutter**, focado em fornecer uma experiência de compra moderna com navegação intuitiva e responsiva.

## Funcionalidades

- Navegação por categorias e produtos
- Adição de produtos ao carrinho
- Interface responsiva para diferentes tamanhos de dispositivos

## Tecnologias Utilizadas

### Frontend
- **Flutter**: Framework principal para o desenvolvimento do aplicativo.
- **Dart**: Linguagem de programação usada para escrever o app.

### Gerenciamento de Estado
- **Provider**: Utilizado para gerenciar o estado do aplicativo, incluindo o carrinho e os produtos.

### Navegação
- **Google Nav Bar**: Usado para navegação no aplicativo com uma barra de navegação inferior estilizada.

## Como Rodar o Projeto

### Pré-requisitos:
- Ter o **Flutter** instalado ([Instruções](https://flutter.dev/docs/get-started/install))
- Um editor de texto como **VSCode** ou **Android Studio**

### Instalar dependências:
1. Clone este repositório:
    ```bash
    git clone https://github.com/LucasPetruci/ecommerce_app
    ```
2. Navegue até o diretório do projeto:
    ```bash
    cd ecommerce_app
    ```
3. Instale as dependências:
    ```bash
    flutter pub get
    ```

### Rodar o projeto:
1. Inicie o aplicativo em um emulador ou dispositivo físico:
    ```bash
    flutter run
    ```

## Estrutura de Pastas

```bash
lib/
│
├── components/
│   ├── bottom_nav_bar.dart        # Barra de navegação inferior personalizada
│   ├── cart_item.dart             # Item de carrinho de compras
│   └── shoe_tile.dart             # Componente para exibir um sapato
├── images/                        # Contém imagens de produtos
│   ├── AirJordan.png
│   ├── kdtrey.png
│   ├── kyrie.png
│   ├── nike.png
│   └── zoomfreak.png
├── models/
│   ├── cart.dart                  # Modelo para carrinho de compras
│   └── shoe.dart                  # Modelo para sapato
├── pages/
│   ├── cart_page.dart             # Página do carrinho
│   ├── home_page.dart             # Página inicial
│   ├── intro_page.dart            # Página de introdução
│   └── shop_page.dart             # Página da loja
└── main.dart                      # Arquivo principal do app
