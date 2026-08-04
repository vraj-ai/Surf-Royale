class_name VisualReloadMetrics
extends RefCounted

const MAX_MEMORY_GROWTH_BYTES := 67_108_864
const MAX_POST_RELOAD_MEMORY_DRIFT_BYTES := 65_536

var _baseline_memory_bytes: int
var _baseline_scene_node_count: int
var _baseline_object_count: int
var _runs: Array[Dictionary] = []
var _post_reload_memory_bytes: Array[int] = []
var _post_reload_scene_node_counts: Array[int] = []
var _post_reload_object_counts: Array[int] = []

func _init(baseline_memory_bytes: int, baseline_scene_node_count: int, baseline_object_count: int) -> void:
	_baseline_memory_bytes = max(baseline_memory_bytes, 0)
	_baseline_scene_node_count = max(baseline_scene_node_count, 0)
	_baseline_object_count = max(baseline_object_count, 0)

func record(run_evidence: Dictionary, post_reload_memory_bytes: int, post_reload_scene_node_count: int, post_reload_object_count: int) -> void:
	_runs.append(run_evidence.duplicate(true))
	_post_reload_memory_bytes.append(max(post_reload_memory_bytes, 0))
	_post_reload_scene_node_counts.append(max(post_reload_scene_node_count, 0))
	_post_reload_object_counts.append(max(post_reload_object_count, 0))

func evidence() -> Dictionary:
	var max_cleanup_memory := _baseline_memory_bytes
	for value in _post_reload_memory_bytes:
		max_cleanup_memory = max(max_cleanup_memory, value)
	var cleanup_memory_growth := maxi(max_cleanup_memory - _baseline_memory_bytes, 0)
	var runs_passed := _runs.all(func(run: Dictionary) -> bool:
		return bool(run.get("passed", false))
	)
	var stable_nodes := _post_reload_scene_node_counts.all(func(count: int) -> bool:
		return count == _baseline_scene_node_count
	)
	var stable_objects := _post_reload_object_counts.is_empty() or _post_reload_object_counts.all(func(count: int) -> bool:
		return count == _post_reload_object_counts[0]
	)
	var cleanup_memory_drift := _value_range(_post_reload_memory_bytes)
	var memory_not_monotonically_growing := cleanup_memory_drift <= MAX_POST_RELOAD_MEMORY_DRIFT_BYTES
	var bounded_cumulative_memory := cleanup_memory_growth <= MAX_MEMORY_GROWTH_BYTES
	return {
		"reload_count": _runs.size(),
		"baseline_scene_node_count": _baseline_scene_node_count,
		"baseline_object_count": _baseline_object_count,
		"benchmark_runs_passed": runs_passed,
		"post_reload_memory_bytes": _post_reload_memory_bytes,
		"post_reload_scene_node_counts": _post_reload_scene_node_counts,
		"post_reload_object_counts": _post_reload_object_counts,
		"cleanup_memory_growth_bytes": cleanup_memory_growth,
		"post_reload_memory_drift_bytes": cleanup_memory_drift,
		"stable_post_reload_scene_node_count": stable_nodes,
		"stable_object_count": stable_objects,
		"memory_not_monotonically_growing": memory_not_monotonically_growing,
		"bounded_cumulative_memory_growth": bounded_cumulative_memory,
		"passed": runs_passed and stable_nodes and stable_objects and memory_not_monotonically_growing and bounded_cumulative_memory,
	}

func _value_range(values: Array[int]) -> int:
	if values.is_empty():
		return 0
	var lowest := values[0]
	var highest := values[0]
	for value in values:
		lowest = min(lowest, value)
		highest = max(highest, value)
	return highest - lowest
