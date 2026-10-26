// Benchmark Suite for API Dash
// Performance regression detection for API requests, code generation, and more

library apidash_benchmark;

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:json_annotation/json_annotation.dart';

part 'benchmark_models.g.dart';

/// Benchmark result with regression detection
@JsonSerializable()
class BenchmarkResult {
  final String name;
  final String category;
  final int iterations;
  final Duration mean;
  final Duration median;
  final Duration min;
  final Duration max;
  final Duration stdDev;
  final int memoryKb;
  final DateTime timestamp;
  final Map<String, dynamic> metadata;

  BenchmarkResult({
    required this.name,
    required this.category,
    required this.iterations,
    required this.mean,
    required this.median,
    required this.min,
    required this.max,
    required this.stdDev,
    required this.memoryKb,
    required this.timestamp,
    this.metadata = const {},
  });

  factory BenchmarkResult.fromJson(Map<String, dynamic> json) => _$BenchmarkResultFromJson(json);
  Map<String, dynamic> toJson() => _$BenchmarkResultToJson(this);

  /// Check if this result represents a regression compared to baseline
  bool isRegression(Baseline baseline, {double threshold = 0.15}) {
    final baselineMean = baseline.results[name]?.mean ?? Duration.zero;
    if (baselineMean == Duration.zero) return false;
    
    final ratio = mean.inMicroseconds / baselineMean.inMicroseconds;
    return ratio > (1.0 + threshold);
  }

  /// Get regression percentage
  double regressionPercent(Baseline baseline) {
    final baselineMean = baseline.results[name]?.mean ?? Duration.zero;
    if (baselineMean == Duration.zero) return 0.0;
    
    return ((mean.inMicroseconds - baselineMean.inMicroseconds) / baselineMean.inMicroseconds) * 100;
  }
}

/// Baseline for regression detection
@JsonSerializable()
class Baseline {
  final String version;
  final DateTime createdAt;
  final Map<String, BenchmarkResult> results;

  Baseline({
    required this.version,
    required this.createdAt,
    required this.results,
  });

  factory Baseline.fromJson(Map<String, dynamic> json) => _$BaselineFromJson(json);
  Map<String, dynamic> toJson() => _$BaselineToJson(this);
}

/// Benchmark configuration
class BenchmarkConfig {
  final int iterations;
  final int warmupIterations;
  final Duration timeout;
  final bool measureMemory;
  final String outputDir;
  final double regressionThreshold;

  BenchmarkConfig({
    this.iterations = 100,
    this.warmupIterations = 10,
    this.timeout = const Duration(minutes: 5),
    this.measureMemory = true,
    this.outputDir = 'benchmark_results',
    this.regressionThreshold = 0.15,
  });
}

/// Base benchmark class
abstract class ApidashBenchmark extends BenchmarkBase {
  final BenchmarkConfig config;
  late final List<Duration> _samples;
  late final List<int> _memorySamples;

  ApidashBenchmark(String name, this.config) : super(name) {
    _samples = [];
    _memorySamples = [];
  }

  @override
  void run() {
    // Warmup
    for (int i = 0; i < config.warmupIterations; i++) {
      _runIteration();
    }

    // Actual benchmark
    for (int i = 0; i < config.iterations; i++) {
      final stopwatch = Stopwatch()..start();
      final memoryBefore = _getMemoryUsage();
      
      _runIteration();
      
      stopwatch.stop();
      final memoryAfter = _getMemoryUsage();
      
      _samples.add(stopwatch.elapsed);
      if (config.measureMemory) {
        _memorySamples.add(max(0, memoryAfter - memoryBefore));
      }
    }
  }

  void _runIteration() {
    // Override in subclasses
  }

  int _getMemoryUsage() {
    // Platform-specific memory measurement
    if (Platform.isLinux || Platform.isMacOS) {
      try {
        final result = Process.runSync('ps', ['-o', 'rss=', pid.toString()]);
        if (result.exitCode == 0) {
          return int.parse(result.stdout.toString().trim()) ~/ 1024; // KB
        }
      } catch (_) {}
    }
    return 0;
  }

  /// Calculate statistics from samples
  BenchmarkResult calculateResults(String category, {Map<String, dynamic> metadata = const {}}) {
    if (_samples.isEmpty) {
      return BenchmarkResult(
        name: name,
        category: category,
        iterations: 0,
        mean: Duration.zero,
        median: Duration.zero,
        min: Duration.zero,
        max: Duration.zero,
        stdDev: Duration.zero,
        memoryKb: 0,
        timestamp: DateTime.now(),
        metadata: metadata,
      );
    }

    final sortedSamples = List<Duration>.from(_samples)..sort();
    final sum = _samples.fold<Duration>(Duration.zero, (a, b) => a + b);
    final mean = Duration(microseconds: (sum.inMicroseconds / _samples.length).round());
    final median = sortedSamples[_samples.length ~/ 2];
    final min = sortedSamples.first;
    final max = sortedSamples.last;

    // Standard deviation
    final meanMicros = mean.inMicroseconds.toDouble();
    final variance = _samples
        .map((d) => pow(d.inMicroseconds - meanMicros, 2))
        .reduce((a, b) => a + b) / _samples.length;
    final stdDev = Duration(microseconds: sqrt(variance).round());

    int avgMemory = 0;
    if (_memorySamples.isNotEmpty) {
      avgMemory = (_memorySamples.reduce((a, b) => a + b) / _memorySamples.length).round();
    }

    return BenchmarkResult(
      name: name,
      category: category,
      iterations: _samples.length,
      mean: mean,
      median: median,
      min: min,
      max: max,
      stdDev: stdDev,
      memoryKb: avgMemory,
      timestamp: DateTime.now(),
      metadata: metadata,
    );
  }
}

/// HTTP Request Benchmark
class HttpRequestBenchmark extends ApidashBenchmark {
  final String url;
  final String method;
  final Map<String, String>? headers;
  final dynamic body;

  HttpRequestBenchmark({
    required super.name,
    required this.url,
    required this.method,
    this.headers,
    this.body,
    required super.config,
  }) : super(name, config);

  @override
  void _runIteration() {
    // Simulated HTTP request - in real implementation would use better_networking
    // This is a placeholder for the actual benchmark
  }
}

/// Code Generation Benchmark
class CodeGenBenchmark extends ApidashBenchmark {
  final String language;
  final String library;
  final Map<String, dynamic> requestSpec;

  CodeGenBenchmark({
    required super.name,
    required this.language,
    required this.library,
    required this.requestSpec,
    required super.config,
  }) : super(name, config);

  @override
  void _runIteration() {
    // Simulated code generation - in real implementation would use apidash_core codegen
  }
}

/// JSON Parsing Benchmark
class JsonParsingBenchmark extends ApidashBenchmark {
  final String jsonString;

  JsonParsingBenchmark({
    required super.name,
    required this.jsonString,
    required super.config,
  }) : super(name, config);

  @override
  void _runIteration() {
    // Simulated JSON parsing
  }
}

/// Benchmark Runner
class BenchmarkRunner {
  final BenchmarkConfig config;
  final List<ApidashBenchmark> _benchmarks = [];

  BenchmarkRunner({BenchmarkConfig? config}) : config = config ?? BenchmarkConfig();

  void addBenchmark(ApidashBenchmark benchmark) {
    _benchmarks.add(benchmark);
  }

  Future<List<BenchmarkResult>> runAll() async {
    final results = <BenchmarkResult>[];

    for (final benchmark in _benchmarks) {
      print('Running benchmark: ${benchmark.name}...');
      benchmark.run();
      final result = benchmark.calculateResults(_getCategory(benchmark.name));
      results.add(result);
      print('  ${result.mean.inMilliseconds}ms mean (${result.iterations} iterations)');
    }

    return results;
  }

  String _getCategory(String name) {
    if (name.contains('http') || name.contains('request')) return 'http';
    if (name.contains('codegen') || name.contains('generate')) return 'codegen';
    if (name.contains('json') || name.contains('parse')) return 'json';
    if (name.contains('import') || name.contains('export')) return 'import_export';
    if (name.contains('ai') || name.contains('ml')) return 'ai';
    return 'other';
  }

  /// Save results to file
  Future<void> saveResults(List<BenchmarkResult> results, String filename) async {
    final dir = Directory(config.outputDir);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    final file = File('${config.outputDir}/$filename');
    final jsonResults = results.map((r) => r.toJson()).toList();
    await file.writeAsString(const JsonEncoder.withIndent('  ').convert(jsonResults));
    print('Results saved to ${file.path}');
  }

  /// Load baseline
  Future<Baseline?> loadBaseline(String filename) async {
    final file = File('${config.outputDir}/$filename');
    if (!await file.exists()) return null;

    final json = await file.readAsString();
    final data = jsonDecode(json) as Map<String, dynamic>;
    return Baseline.fromJson(data);
  }

  /// Save baseline
  Future<void> saveBaseline(Baseline baseline, String filename) async {
    final dir = Directory(config.outputDir);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    final file = File('${config.outputDir}/$filename');
    await file.writeAsString(const JsonEncoder.withIndent('  ').convert(baseline.toJson()));
  }

  /// Compare results with baseline and detect regressions
  Map<String, dynamic> compareWithBaseline(List<BenchmarkResult> results, Baseline baseline) {
    final regressions = <Map<String, dynamic>>[];
    final improvements = <Map<String, dynamic>>[];

    for (final result in results) {
      if (result.isRegression(baseline, threshold: config.regressionThreshold)) {
        regressions.add({
          'benchmark': result.name,
          'category': result.category,
          'currentMeanMs': result.mean.inMilliseconds,
          'baselineMeanMs': baseline.results[result.name]?.mean.inMilliseconds ?? 0,
          'regressionPercent': result.regressionPercent(baseline).toStringAsFixed(2),
          'threshold': config.regressionThreshold,
        });
      } else if (result.mean.inMicroseconds < (baseline.results[result.name]?.mean.inMicroseconds ?? 0)) {
        improvements.add({
          'benchmark': result.name,
          'category': result.category,
          'improvementPercent': ((baseline.results[result.name]!.mean.inMicroseconds - result.mean.inMicroseconds) / baseline.results[result.name]!.mean.inMicroseconds * 100).toStringAsFixed(2),
        });
      }
    }

    return {
      'regressions': regressions,
      'improvements': improvements,
      'totalBenchmarks': results.length,
      'regressionCount': regressions.length,
      'improvementCount': improvements.length,
      'threshold': config.regressionThreshold,
    };
  }
}

/// Pre-defined benchmark suite for API Dash
class ApidashBenchmarkSuite {
  static Future<void> runFullSuite({
    BenchmarkConfig? config,
    String? baselineFile,
    bool saveBaseline = false,
  }) async {
    final runner = BenchmarkRunner(config: config ?? BenchmarkConfig());
    
    // Add HTTP benchmarks
    runner.addBenchmark(HttpRequestBenchmark(
      name: 'http_get_simple',
      url: 'https://httpbin.org/get',
      method: 'GET',
      config: config ?? BenchmarkConfig(),
    ));

    runner.addBenchmark(HttpRequestBenchmark(
      name: 'http_post_json',
      url: 'https://httpbin.org/post',
      method: 'POST',
      headers: {'Content-Type': 'application/json'},
      body: {'key': 'value' * 100},
      config: config ?? BenchmarkConfig(),
    ));

    // Add code generation benchmarks
    for (final language in ['dart', 'python', 'javascript', 'java', 'go', 'rust']) {
      runner.addBenchmark(CodeGenBenchmark(
        name: 'codegen_$language',
        language: language,
        library: 'default',
        requestSpec: {'method': 'POST', 'url': 'https://api.example.com/test'},
        config: config ?? BenchmarkConfig(),
      ));
    }

    // Add JSON parsing benchmarks
    runner.addBenchmark(JsonParsingBenchmark(
      name: 'json_parse_small',
      jsonString: '{"key": "value", "number": 123, "array": [1,2,3]}',
      config: config ?? BenchmarkConfig(),
    ));

    runner.addBenchmark(JsonParsingBenchmark(
      name: 'json_parse_large',
      jsonString: '{"data": ' + '{"id": 1, "name": "item", "value": "x" * 100},' * 1000 + '"last": true}',
      config: config ?? BenchmarkConfig(),
    ));

    // Run all benchmarks
    final results = await runner.runAll();

    // Save results
    final timestamp = DateTime.now().toIso8601String().replaceAll(':', '-');
    await runner.saveResults(results, 'benchmark_results_$timestamp.json');

    // Load baseline if provided
    if (baselineFile != null) {
      final baseline = await runner.loadBaseline(baselineFile);
      if (baseline != null) {
        final comparison = runner.compareWithBaseline(results, baseline);
        await runner.saveResults(
          [BenchmarkResult(
            name: 'comparison',
            category: 'meta',
            iterations: 1,
            mean: Duration.zero,
            median: Duration.zero,
            min: Duration.zero,
            max: Duration.zero,
            stdDev: Duration.zero,
            memoryKb: 0,
            timestamp: DateTime.now(),
            metadata: comparison,
          )],
          'comparison_$timestamp.json',
        );

        if (comparison['regressionCount'] > 0) {
          print('⚠️  REGRESSIONS DETECTED: ${comparison['regressionCount']}');
          for (final reg in comparison['regressions']) {
            print('  ${reg['benchmark']}: ${reg['regressionPercent']}% slower');
          }
          exit(1);
        } else {
          print('✅ No regressions detected');
        }
      }
    }

    // Save new baseline if requested
    if (saveBaseline) {
      final baseline = Baseline(
        version: '0.1.0',
        createdAt: DateTime.now(),
        results: {for (final r in results) r.name: r},
      );
      await runner.saveBaseline(baseline, 'baseline_$timestamp.json');
      print('Baseline saved');
    }
  }
}