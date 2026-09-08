# my-awesome-ai-stuff

A laboratory for reusable AI agents, skills and agentic engineering patterns.

## Journey Engineering Agent

The first structured agent in this repository focuses on reconstructing and planning complex digital journeys from Figma and other engineering evidence.

### Why

Traditional screen-to-code agents tend to analyze each screen independently. This agent introduces a canonical **Journey Model** between design and implementation so that screens, states, actions, transitions and decisions can be validated before code is generated.

### Structure

```text
agents/journey-engineering-agent/
├── AGENTS.md
├── README.md
├── artifacts/
│   ├── decisions.md
│   ├── design-system-map.yaml
│   ├── journey-overview.md
│   ├── journey.yaml
│   └── open-questions.md
└── skills/
    ├── design-system-mapping/
    ├── figma-analysis/
    ├── journey-modeling/
    └── journey-review/
```

### Workflow

`Figma -> Evidence -> Journey Model -> Human Validation -> Design System Mapping -> Architecture -> Implementation`

The agent is intentionally human-in-the-loop during discovery. Uncertainty is represented explicitly rather than converted into fabricated certainty.
