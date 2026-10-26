// Interactive Documentation Tree Component
// React-based collapsible/expandable documentation tree

import React, { useState } from 'react';

const DocTreeNode = ({ node, level = 0, onSelect }) => {
  const [expanded, setExpanded] = useState(level < 2); // Expand first 2 levels by default
  const hasChildren = node.children && node.children.length > 0;
  const isLeaf = !hasChildren;

  const handleClick = (e) => {
    e.stopPropagation();
    if (hasChildren) {
      setExpanded(!expanded);
    }
    if (onSelect) {
      onSelect(node);
    }
  };

  const getIcon = () => {
    if (node.type === 'package') return '📦';
    if (node.type === 'module') return '📁';
    if (node.type === 'class') return '📄';
    if (node.type === 'function') return '⚙️';
    if (node.type === 'api') return '🌐';
    if (node.type === 'config') return '⚙️';
    if (node.type === 'test') return '🧪';
    if (node.type === 'doc') return '📖';
    return '📄';
  };

  const getTypeColor = () => {
    const colors = {
      package: '#6366f1',
      module: '#8b5cf6',
      class: '#ec4899',
      function: '#f97316',
      api: '#06b6d4',
      config: '#84cc16',
      test: '#ef4444',
      doc: '#10b981',
    };
    return colors[node.type] || '#64748b';
  };

  return (
    <div style={{ marginLeft: `${level * 20}px` }}>
      <div
        style={{
          display: 'flex',
          alignItems: 'center',
          padding: '6px 10px',
          borderRadius: '6px',
          cursor: hasChildren ? 'pointer' : 'default',
          backgroundColor: expanded ? 'rgba(99, 102, 241, 0.1)' : 'transparent',
          transition: 'background-color 0.2s',
          border: `1px solid ${expanded ? 'rgba(99, 102, 241, 0.3)' : 'transparent'}`,
          userSelect: 'none',
        }}
        onClick={handleClick}
        onMouseEnter={(e) => e.target.style.backgroundColor = 'rgba(99, 102, 241, 0.05)'}
        onMouseLeave={(e) => e.target.style.backgroundColor = expanded ? 'rgba(99, 102, 241, 0.1)' : 'transparent'}
      >
        {hasChildren && (
          <span
            style={{
              display: 'inline-block',
              width: '20px',
              textAlign: 'center',
              transition: 'transform 0.2s',
              transform: expanded ? 'rotate(90deg)' : 'rotate(0deg)',
              fontSize: '12px',
              color: '#64748b',
            }}
          >
            ▶
          </span>
        )}
        {!hasChildren && <span style={{ width: '20px', display: 'inline-block' }} />}
        <span
          style={{
            display: 'inline-block',
            width: '20px',
            height: '20px',
            borderRadius: '4px',
            backgroundColor: getTypeColor(),
            marginRight: '8px',
            fontSize: '12px',
            display: 'flex',
            alignItems: 'center',
            justifyContent: 'center',
          }}
        >
          {getIcon()}
        </span>
        <span style={{ fontWeight: hasChildren ? '600' : '400', fontSize: '14px' }}>
          {node.name}
        </span>
        {node.description && (
          <span style={{ marginLeft: '8px', fontSize: '12px', color: '#94a3b8', fontStyle: 'italic' }}>
            {node.description}
          </span>
        )}
        {node.metadata && (
          <span style={{ marginLeft: '8px', fontSize: '10px', color: '#64748b' }}>
            {Object.entries(node.metadata).map(([k, v]) => `${k}: ${v}`).join(' • ')}
          </span>
        )}
      </div>
      {expanded && hasChildren && (
        <div style={{ borderLeft: '2px solid rgba(99, 102, 241, 0.2)', marginLeft: '10px', paddingLeft: '8px' }}>
          {node.children.map((child) => (
            <DocTreeNode key={child.id} node={child} level={level + 1} onSelect={onSelect} />
          ))}
        </div>
      )}
    </div>
  );
};

export const DocumentationTree = ({ data, onNodeSelect }) => {
  const [searchTerm, setSearchTerm] = useState('');

  const filterNode = (node) => {
    if (!searchTerm) return true;
    const term = searchTerm.toLowerCase();
    const matches = 
      node.name.toLowerCase().includes(term) ||
      (node.description?.toLowerCase().includes(term)) ||
      (node.type?.toLowerCase().includes(term));
    
    if (matches) return true;
    
    if (node.children) {
      return node.children.some(filterNode);
    }
    
    return false;
  };

  const filteredData = data.filter(filterNode);

  return (
    <div style={{ fontFamily: 'system-ui, sans-serif', maxWidth: '800px', margin: '0 auto' }}>
      <div style={{ marginBottom: '20px' }}>
        <input
          type="text"
          placeholder="🔍 Search documentation..."
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
          style={{
            width: '100%',
            padding: '10px 14px',
            fontSize: '14px',
            border: '1px solid #e2e8f0',
            borderRadius: '8px',
            outline: 'none',
            transition: 'border-color 0.2s, box-shadow 0.2s',
            boxShadow: '0 1px 2px rgba(0,0,0,0.05)',
          }}
          onFocus={(e) => e.target.style.borderColor = '#6366f1'}
          onBlur={(e) => e.target.style.borderColor = '#e2e8f0'}
        />
        <div style={{ display: 'flex', gap: '8px', marginTop: '12px', flexWrap: 'wrap' }}>
          <button
            onClick={() => {
              const expandAll = (nodes) => nodes.forEach(n => {
                n._expanded = true;
                if (n.children) expandAll(n.children);
              });
              expandAll([...data]);
              // Force re-render would need state management
            }}
            style={{
              padding: '6px 12px',
              fontSize: '12px',
              border: '1px solid #e2e8f0',
              borderRadius: '6px',
              background: 'white',
              cursor: 'pointer',
            }}
          >
            Expand All
          </button>
          <button
            onClick={() => {
              const collapseAll = (nodes) => nodes.forEach(n => {
                n._expanded = false;
                if (n.children) collapseAll(n.children);
              });
              collapseAll([...data]);
            }}
            style={{
              padding: '6px 12px',
              fontSize: '12px',
              border: '1px solid #e2e8f0',
              borderRadius: '6px',
              background: 'white',
              cursor: 'pointer',
            }}
          >
            Collapse All
          </button>
          <span style={{ marginLeft: 'auto', fontSize: '12px', color: '#94a3b8' }}>
            {data.reduce((acc, n) => acc + (n.children?.length || 0) + 1, 0)} items
          </span>
        </div>
      </div>
      <div style={{ 
        border: '1px solid #e2e8f0', 
        borderRadius: '8px', 
        padding: '16px',
        backgroundColor: '#fafafa',
        maxHeight: '70vh',
        overflow: 'auto',
      }}>
        {filteredData.map((node) => (
          <DocTreeNode key={node.id} node={node} onSelect={onNodeSelect} />
        ))}
      </div>
    </div>
  );
};

// Sample data structure for API Dash Enhanced
export const apiDashDocumentationData = [
  {
    id: 'root',
    name: 'API Dash Enhanced',
    type: 'package',
    description: 'AI-powered cross-platform API client with MCP server',
    children: [
      {
        id: 'packages',
        name: 'Packages (14)',
        type: 'module',
        description: 'Modular Dart packages',
        children: [
          { id: 'apidash_core', name: 'apidash_core', type: 'package', description: 'Core models, services, utilities', metadata: { requests: 45, tests: 32 } },
          { id: 'apidash_design_system', name: 'apidash_design_system', type: 'package', description: 'Reusable UI components', metadata: { components: 28 } },
          { id: 'better_networking', name: 'better_networking', type: 'package', description: 'HTTP/WebSocket/gRPC/MQTT', metadata: { protocols: 5 } },
          { id: 'curl_parser', name: 'curl_parser', type: 'package', description: 'cURL command parsing' },
          { id: 'genai', name: 'genai', type: 'package', description: 'Multi-provider AI integration', metadata: { providers: 8 } },
          { id: 'har', name: 'har', type: 'package', description: 'HAR import/export' },
          { id: 'insomnia_collection', name: 'insomnia_collection', type: 'package', description: 'Insomnia import' },
          { id: 'json_explorer', name: 'json_explorer', type: 'package', description: 'JSON visualization' },
          { id: 'json_field_editor', name: 'json_field_editor', type: 'package', description: 'JSON editing' },
          { id: 'multi_trigger_autocomplete_plus', name: 'multi_trigger_autocomplete_plus', type: 'package', description: 'Smart autocomplete' },
          { id: 'postman', name: 'postman', type: 'package', description: 'Postman import' },
          { id: 'seed', name: 'seed', type: 'package', description: 'Seed data' },
          { id: 'apidash_mcp', name: 'apidash_mcp (NEW)', type: 'package', description: 'MCP Server for AI agents', metadata: { tools: 10 } },
          { id: 'apidash_african_apis', name: 'apidash_african_apis (NEW)', type: 'package', description: 'African API collections', metadata: { apis: 47, categories: 6 } },
          { id: 'apidash_benchmark', name: 'apidash_benchmark (NEW)', type: 'package', description: 'Benchmark suite' },
        ],
      },
      {
        id: 'features',
        name: 'Core Features',
        type: 'module',
        children: [
          { id: 'collections', name: 'Collection Management', type: 'feature', description: 'Organize requests in collections/folders' },
          { id: 'requests', name: 'Request Builder', type: 'feature', description: 'HTTP, GraphQL, WebSocket, MQTT, gRPC' },
          { id: 'environments', name: 'Environment Variables', type: 'feature', description: 'Variable substitution, secrets management' },
          { id: 'codegen', name: 'Code Generation', type: 'feature', description: '20+ languages/frameworks', metadata: { languages: 20 } },
          { id: 'import_export', name: 'Import/Export', type: 'feature', description: 'Postman, Insomnia, HAR, OpenAPI, cURL' },
          { id: 'dashbot', name: 'DashBot AI Assistant', type: 'feature', description: '30+ prompt types for API workflows' },
          { id: 'response_preview', name: 'Response Preview', type: 'feature', description: 'JSON, XML, images, audio, video, PDF' },
          { id: 'history', name: 'Request History', type: 'feature', description: 'Full history with search/filter' },
          { id: 'mcp_server', name: 'MCP Server (NEW)', type: 'feature', description: '10 tools via stdio/HTTP/SSE', metadata: { tools: 10 } },
          { id: 'african_apis', name: 'African APIs (NEW)', type: 'feature', description: '47 pre-built API collections', metadata: { collections: 47 } },
        ],
      },
      {
        id: 'architecture',
        name: 'Architecture',
        type: 'module',
        children: [
          { id: 'data_flow', name: 'Data Flow', type: 'doc', description: 'Request → Network → Response → Preview' },
          { id: 'ai_pipeline', name: 'AI Pipeline', type: 'doc', description: 'DashBot → GenAI → Agentic Engine → Tools' },
          { id: 'plugin_system', name: 'Plugin System', type: 'doc', description: 'Extensible package architecture' },
          { id: 'platform_targets', name: 'Platform Targets', type: 'doc', description: 'Linux, macOS, Windows, Android, iOS, Web' },
        ],
      },
      {
        id: 'african_apis_detail',
        name: 'African API Collections (NEW)',
        type: 'module',
        children: [
          { id: 'mobile_money', name: 'Mobile Money (10)', type: 'category', description: 'M-Pesa, MoMo, Airtel, Orange, Wave, Chipper, Paga, Opay, PalmPay', metadata: { apis: 10, endpoints: 47 } },
          { id: 'fintech', name: 'FinTech (7)', type: 'category', description: 'Flutterwave, Paystack, Interswitch, Payfast, Ozow, Yoco, Peach', metadata: { apis: 7 } },
          { id: 'logistics', name: 'Logistics (5)', type: 'category', description: 'Sendy, Lori, Kobo360, Truckr, GIG', metadata: { apis: 5 } },
          { id: 'banking', name: 'Banking (7)', type: 'category', description: 'Standard Bank, ABSA, FNB, Nedbank, Equity, KCB, Co-op', metadata: { apis: 7 } },
          { id: 'identity', name: 'Identity (3)', type: 'category', description: 'Smile Identity, Youverify, Prembly', metadata: { apis: 3 } },
          { id: 'payments', name: 'Payments (5)', type: 'category', description: 'MFS Africa, Cellulant, DPO, iPay, Jenga', metadata: { apis: 5 } },
        ],
      },
      {
        id: 'mcp_tools',
        name: 'MCP Server Tools (NEW)',
        type: 'module',
        description: '10 tools exposed to AI agents',
        children: [
          { id: 'mcp_collections', name: 'Collection Tools (3)', type: 'tool', description: 'create, list, get, update, delete collections/folders' },
          { id: 'mcp_requests', name: 'Request Tools (4)', type: 'tool', description: 'create, send, history, save requests' },
          { id: 'mcp_codegen', name: 'CodeGen Tools (2)', type: 'tool', description: 'generate code (20 langs), list languages' },
          { id: 'mcp_import_export', name: 'Import/Export Tools (6)', type: 'tool', description: 'Postman, Insomnia, HAR, OpenAPI, cURL import/export' },
          { id: 'mcp_ai', name: 'AI Tools (5)', type: 'tool', description: 'generate request, explain response, debug, generate tests, generate docs' },
          { id: 'mcp_environments', name: 'Environment Tools (5)', type: 'tool', description: 'create, list, update, delete, activate environments' },
        ],
      },
      {
        id: 'testing',
        name: 'Testing & Quality',
        type: 'module',
        children: [
          { id: 'unit_tests', name: 'Unit Tests', type: 'test', description: '100+ unit tests across packages' },
          { id: 'integration_tests', name: 'Integration Tests', type: 'test', description: 'End-to-end workflow tests' },
          { id: 'benchmark', name: 'Benchmark Suite', type: 'test', description: 'Regression detection for performance' },
          { id: 'security', name: 'Security Scanning', type: 'test', description: 'TruffleHog, Semgrep, OSV, dependency check' },
        ],
      },
      {
        id: 'ci_cd',
        name: 'CI/CD Pipeline',
        type: 'module',
        children: [
          { id: 'analyze', name: 'Analyze & Lint', type: 'config', description: 'flutter analyze, dart format' },
          { id: 'test', name: 'Unit & Integration Tests', type: 'config', description: 'Parallel test execution with coverage' },
          { id: 'build', name: 'Multi-platform Build', type: 'config', description: 'Linux, macOS, Windows, Android, iOS, Web' },
          { id: 'benchmarks', name: 'Benchmarks', type: 'config', description: 'Performance regression detection' },
          { id: 'security', name: 'Security Scanning', type: 'config', description: 'Dependency check, secret scan, SAST' },
          { id: 'slsa', name: 'SLSA Provenance', type: 'config', description: 'Supply chain security' },
          { id: 'publish', name: 'Release & Deploy', type: 'config', description: 'pub.dev, GitHub Releases, GitHub Pages' },
        ],
      },
      {
        id: 'documentation',
        name: 'Documentation',
        type: 'module',
        children: [
          { id: 'readme', name: 'README.md', type: 'doc', description: 'Project overview, quick start, features' },
          { id: 'design_doc', name: 'DESIGN_DOCUMENT.md', type: 'doc', description: 'Architecture, decisions, security, performance' },
          { id: 'case_study', name: 'PORTFOLIO_CASE_STUDY.md', type: 'doc', description: 'Problem, approach, results, lessons' },
          { id: 'before_after', name: 'BEFORE_AFTER.md', type: 'doc', description: 'Detailed comparison table' },
          { id: 'architecture_viz', name: 'Architecture Visualization', type: 'doc', description: 'Interactive React Flow diagram' },
          { id: 'mcp_guide', name: 'MCP Server Guide', type: 'doc', description: 'Setup, tools, authentication, examples' },
          { id: 'african_apis_guide', name: 'African APIs Guide', type: 'doc', description: 'Collection usage, authentication, examples' },
        ],
      },
    ],
  },
];

export default DocumentationTree;