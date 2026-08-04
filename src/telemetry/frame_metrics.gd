class_name FrameMetrics
extends RefCounted

var _start_memory_bytes: int
var _end_memory_bytes: int
var _frame_seconds: Array[float] = []

func _init(start_memory_bytes: int) -> void:
	_start_memory_bytes = max(start_memory_bytes, 0)
	_end_memory_bytes = _start_memory_bytes

func record(frame_seconds: float) -> bool:
	if not is_finite(frame_seconds) or frame_seconds < 0.0:
		return false
	_frame_seconds.append(frame_seconds)
	return true

func finish(end_memory_bytes: int) -> void:
	_end_memory_bytes = max(end_memory_bytes, 0)

func p95_ms() -> float:
	return _percentile_ms(0.95)

func one_percent_low_frame_ms() -> float:
	return _percentile_ms(0.99)

func worst_frame_ms() -> float:
	return _percentile_ms(1.0)

func memory_growth_bytes() -> int:
	return maxi(_end_memory_bytes - _start_memory_bytes, 0)

func sample_count() -> int:
	return _frame_seconds.size()

static func is_non_loading_interval(interval_start_seconds: float, warm_up_seconds: float) -> bool:
	return (
		is_finite(interval_start_seconds)
		and is_finite(warm_up_seconds)
		and interval_start_seconds >= warm_up_seconds
	)

func _percentile_ms(percentile: float) -> float:
	if _frame_seconds.is_empty():
		return 0.0
	var ordered := _frame_seconds.duplicate()
	ordered.sort()
	var index := clampi(ceili(percentile * float(ordered.size())) - 1, 0, ordered.size() - 1)
	return ordered[index] * 1000.0
