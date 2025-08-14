# farmweather
## Getting Started

FarmWeather 🌦️ ✅
FarmWeather é um aplicativo Flutter desenvolvido para auxiliar no gerenciamento de tarefas agrícolas e na consulta de condições climáticas locais, com foco em funcionalidade online e offline.

✨ Funcionalidades
Gerenciamento de Tarefas
Listagem de Tarefas: Visualização clara de todas as tarefas pendentes, em andamento e finalizadas.

Criação de Tarefas: Formulário para adicionar novas tarefas com nome, área/talhão e hora prevista.

Atualização de Status: Mude o status de uma tarefa diretamente no card (Pendente, Em Andamento, Finalizada).

Busca em Tempo Real: Filtre tarefas instantaneamente pelo nome ou pela área.

Persistência Local: Todas as tarefas são salvas em um banco de dados SQLite local usando o framework Drift.

Consulta de Clima
Dados Atuais: Exibição da temperatura, umidade e um ícone representando a condição climática atual no local atual, caso esteja com a localização ativada.

Previsão Horária: Gráfico com a previsão de temperatura para as próximas horas.

API Pública: Integração com a API Open-Meteo para obter dados climáticos precisos para a sua localização atual. Caso esteja com a localização desligada, será buscada o local padrão, que é Petropolis - RJ.

Cache Offline Inteligente: A última consulta de clima é salva localmente. Se o aplicativo for aberto sem conexão com a internet, ele exibe os últimos dados salvos.

Indicador de Status: Um indicador visual claro na tela informa ao usuário se os dados exibidos são "Ao Vivo" (da API) ou "Em Cache" (salvos localmente).

🛠️ Tecnologias Utilizadas
Framework: Flutter

Linguagem: Dart

Banco de Dados Local: Drift (SQLite)

Requisições HTTP: http

Verificação de Conectividade: connectivity_plus

Gerenciamento de Estado: Provider & StatefulWidget

Ícones: Material Icons

Formatação de Datas: intl

## Como executar o projeto?
1- Clonar o repositorio: https://github.com/RafaelNeiva2/DataAgrin.git <br>
2- Navegar até o projeto <br>
3- Instalar as dependências : flutter pub get <br>
4- Executar o gerador de codigo do Drift: flutter pub run build_runner build --delete-conflicting-outputs <br>
5- Executar o aplicativo: flutter run
