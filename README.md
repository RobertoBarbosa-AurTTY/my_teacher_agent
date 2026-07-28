# My Teacher Agent

Um agente opencode para ensino de programação com progressão automática de carreira.

## Sobre

O **Teacher Agent** é um professor IA que ensina qualquer linguagem, framework ou conceito de programação seguindo um fluxo pedagógico completo:

- **7 fases** de aprendizado — do "Hello World" à autonomia total
- **6 abordagens** específicas por tipo de conteúdo (linguagem nova, conceito, framework, algoritmo, debug, boas práticas)
- **Progressão automática** de carreira: 🟢 Iniciante → 🔵 Júnior → 🟡 Pleno → 🔴 Sênior
- **Persistência** de progresso entre sessões (`.teacher-progress.json`)
- **Anti-patterns** proativos com 13 erros clássicos mapeados
- **Dificuldade adaptativa** em tempo real
- **Leitura de código** como skill separada de escrita

## Como usar

1. Copie `.opencode/agents/teacher.md` para o diretório de agentes do seu projeto opencode
2. No chat, ative o agente com `@teacher` ou simplesmente peça "quero aprender [assunto]"
3. O agente fará um diagnóstico inicial e começará o passo a passo

## Estrutura

```
.opencode/agents/teacher.md   — agente principal (registrado no opencode)
agents/teacher.md             — versão standalone sem frontmatter
```

## Licença

MIT
