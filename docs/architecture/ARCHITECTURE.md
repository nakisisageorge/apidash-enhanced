# Architecture Visualization for API Dash Enhanced

This document describes the interactive architecture visualization for API Dash Enhanced.

## Overview

The architecture visualization is built with **React Flow** and provides an interactive, explorable diagram of the API Dash Enhanced system architecture.

## Components

### 1. Package Dependency Graph
Shows the 12+ Dart packages and their relationships:
- **apidash_core** - Core models, services, and utilities
- **apidash_design_system** - Reusable UI components
- **better_networking** - HTTP/WebSocket/gRPC/MQTT networking
- **curl_parser** - cURL command parsing
- **genai** - AI integration (multi-provider, agentic engine)
- **har** - HAR import/export
- **insomnia_collection** - Insomnia import
- **json_explorer** - JSON visualization
- **json_field_editor** - JSON editing
- **multi_trigger_autocomplete_plus** - Smart autocomplete
- **postman** - Postman import
- **seed** - Seed data
- **apidash_mcp** - MCP Server (NEW)
- **apidash_african_apis** - African API Collections (NEW)
- **apidash_benchmark** - Benchmark Suite (NEW)

### 2. Data Flow Diagram
```
┌─────────────┐     ┌──────────────┐     ┌─────────────┐     ┌──────────────┐
│   User UI   │────▶│  Request     │────▶│  Network    │────▶│   Response   │
│  (Flutter)  │     │  Builder     │     │  Layer      │     │  Processor   │
└─────────────┘     └──────────────┘     └─────────────┘     └──────────────┘
       │                   │                   │                    │
       ▼                   ▼                   ▼                    ▼
┌─────────────┐     ┌──────────────┐     ┌─────────────┐     ┌──────────────┐
│ Collections │     │  Code Gen    │     │   Cache     │     │  Preview/    │
│  Manager    │     │  (20+ langs) │     │  Manager    │     │  Save        │
└─────────────┘     └──────────────┘     └─────────────┘     └──────────────┘
```

### 3. AI Pipeline (DashBot + GenAI + MCP)
```
┌─────────────────────────────────────────────────────────────────────┐
│                        DASHBOT (AI Assistant)                       │
├─────────────────────────────────────────────────────────────────────┤
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐             │
│  │   Prompts    │  │ Agentic      │  │   Models     │             │
│  │  (30+ types) │  │  Engine      │  │  (Multi-     │             │
│  └──────────────┘  └──────────────┘  │   provider)  │             │
│                                       └──────────────┘             │
└─────────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────────┐
│                        MCP SERVER (NEW)                             │
├─────────────────────────────────────────────────────────────────────┤
│  Tools: Collections | Requests | CodeGen | Import/Export | AI     │
│  Transports: stdio | HTTP/SSE | WebSocket                          │
└─────────────────────────────────────────────────────────────────────┘
```

### 4. Platform Targets
- **Desktop**: Linux (AppImage/snap), macOS (DMG), Windows (MSIX/EXE)
- **Mobile**: Android (APK/AAB), iOS (IPA)
- **Web**: Progressive Web App (PWA)

## Interactive Features

1. **Zoom/Pan** - Navigate large diagrams
2. **Node Expansion** - Click to expand package details
3. **Edge Highlighting** - Hover to trace data flows
4. **Search/Filter** - Find components by name
5. **Legend Toggle** - Show/hide layer categories
6. **Export** - Save as PNG/SVG/PDF

## Implementation

The visualization is implemented as a React component in `docs/architecture/ArchitectureViz.jsx`:

```jsx
import ReactFlow, { 
  Node, Edge, Background, Controls, MiniMap,
  useNodesState, useEdgesState, addEdge
} from 'reactflow';

// Nodes represent packages/services
const initialNodes = [
  { id: 'apidash_core', type: 'package', position: { x: 100, y: 100 }, data: { label: 'apidash_core' }},
  { id: 'better_networking', type: 'package', position: { x: 300, y: 100 }, data: { label: 'better_networking' }},
  // ... more nodes
];

// Edges represent dependencies
const initialEdges = [
  { id: 'e1', source: 'apidash_core', target: 'better_networking' },
  // ... more edges
];

export function ArchitectureViz() {
  const [nodes, setNodes, onNodesChange] = useNodesState(initialNodes);
  const [edges, setEdges, onEdgesChange] = useEdgesState(initialEdges);
  
  return (
    <ReactFlow
      nodes={nodes}
      edges={edges}
      onNodesChange={onNodesChange}
      onEdgesChange={onEdgesChange}
      onConnect={onConnect}
    >
      <Background />
      <Controls />
      <MiniMap />
    </ReactFlow>
  );
}
```

## Live Demo

The interactive architecture visualization is available at:
- **GitHub Pages**: https://nakisisageorge.github.io/apidash-enhanced/architecture/
- **Local**: Run `cd docs/architecture && npm install && npm start`

## Files

- `docs/architecture/ArchitectureViz.jsx` - Main React Flow component
- `docs/architecture/package-graph.json` - Package dependency data
- `docs/architecture/data-flow.json` - Data flow definitions
- `docs/architecture/ai-pipeline.json` - AI pipeline structure
- `docs/architecture/platform-targets.json` - Platform build targets