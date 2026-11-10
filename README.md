# my-awesome-ai-stuff

A laboratory for reusable AI agents, skills and agentic engineering patterns.

## Agents

### Journey Engineering Agent

Reconstructs and plans complex digital journeys from Figma and other engineering evidence. Uses a canonical **Journey Model** between design and implementation.

- [Agent instructions](agents/journey-engineering-agent/AGENTS.md)
- [Agent overview](agents/journey-engineering-agent/README.md)

### UX Product Engineer

General-purpose agent for incrementally evolving existing digital products, without a fixed repository, product, technology stack or documentation path. Focuses on task efficiency, operational clarity, error prevention, accessibility and implementation quality.

- [Agent instructions](agents/ux-product-engineer/AGENTS.md)
- [Agent overview](agents/ux-product-engineer/README.md)
- [Issue template](agents/ux-product-engineer/artifacts/issue-template.md)
- [Friction register template](agents/ux-product-engineer/artifacts/friction-register.md)

### Coordenador

Ponto único de contato humano e responsável por orquestrar agentes, validar prontidão, decidir dentro de limites de baixo risco, escalar ambiguidades e consolidar entregas.

- [Agent instructions](agents/coordinator/AGENTS.md)
- [Agent overview](agents/coordinator/README.md)

### Implementador

Engenheiro pragmático que implementa escopo aprovado com simplicidade, boas práticas da plataforma, testes e documentação.

- [Agent instructions](agents/implementer/AGENTS.md)
- [Agent overview](agents/implementer/README.md)

### Qualidade

Modela cenários de teste antes do desenvolvimento usando álgebra booleana, tabelas de decisão e técnicas complementares. Orienta regressão e revisa evidências da entrega.

- [Agent instructions](agents/quality/AGENTS.md)
- [Agent overview](agents/quality/README.md)

## Modelo de colaboração

`Humano <-> Coordenador -> Qualidade -> Implementador -> Qualidade -> Coordenador -> Humano`

O Coordenador pode invocar qualquer agente ou subagente disponível no contexto. Especialistas reportam ao Coordenador; somente ele interage com o humano. Critérios de aceite materialmente ambíguos bloqueiam o desenvolvimento.

Uma entrega só está concluída quando código, testes, documentação e critérios de aceite estiverem integralmente atendidos e houver evidências de validação.

## Shared principles

- Evidence before assumptions.
- Deterministic work before LLM reasoning when practical.
- Preserve uncertainty instead of manufacturing certainty.
- Human decisions become durable project knowledge.
- Measure product outcomes, not output volume.
