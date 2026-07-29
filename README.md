# My Teacher Agent

Agentes opencode para aprendizado e ensino de programação.

## Agentes disponíveis

### Teacher (`@teacher`)

Agente de aprendizado generalista com progressão automática de carreira. Ensina qualquer linguagem, framework ou conceito.

- **7 fases** de aprendizado — do "Hello World" à autonomia total
- **6 abordagens** específicas (linguagem nova, conceito, framework, algoritmo, debug, boas práticas)
- **Progressão automática:** 🟢 Iniciante → 🔵 Júnior → 🟡 Pleno → 🔴 Sênior
- **Persistência** de progresso entre sessões via `.teacher-progress.json`
- **Dificuldade adaptativa** em tempo real

### Professor API (`@teacher-api`)

Agente especializado em **ensinar construção de APIs do zero**. Guia o aluno passo a passo como em uma aula particular, independente da tecnologia.

- **Diagnóstico** do projeto (e-commerce, ERP, etc.) e nível de experiência
- **Mapeamento de requisitos** e modelagem de dados
- **Escolha tecnológica guiada** com comparação de linguagens, frameworks e bancos
- **Arquitetura** (camadas, injeção de dependência, DTOs, Clean Architecture)
- **Implementação incremental** — teoria antes do código, linha por linha
- **Boas práticas:** testes, validação, erros, logs, autenticação, Docker

## Instalação

### Via script (recomendado)

```bash
git clone https://github.com/RobertoBarbosa-AurTTY/my_teacher_agent.git
cd my_teacher_agent

# Instala globalmente (disponível em qualquer projeto)
./install.ps1                        # PowerShell
./install.sh                         # bash

# Apenas no projeto atual
./install.ps1 -Scope local
./install.sh local

# Instala + define como agente padrão
./install.ps1 -Scope global -SetDefault
./install.sh global teacher-api --default
```

### Manual

Copie o arquivo do agente desejado para o diretório de agentes do opencode:

| Escopo | Diretório |
|--------|-----------|
| Global (todo projeto) | `~/.config/opencode/agents/` (Linux/Mac) |
| Global (Windows) | `%USERPROFILE%\.config\opencode\agents\` |
| Local (projeto atual) | `.opencode/agents/` |

## Como usar

No chat do opencode, ative o agente desejado:

```
@teacher Quero aprender Python do zero
@teacher-api Quero construir um e-commerce
```

## Estrutura do repositório

```
.opencode/agents/
├── teacher-api.md   — agente especialista em APIs
└── teacher.md         — agente generalista
agents/
└── teacher.md         — versão standalone do teacher (sem frontmatter)
install.ps1            — instalador para Windows (PowerShell)
install.sh             — instalador para Linux/Mac (bash)
```

## Licença

MIT
