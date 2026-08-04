extends Node

const NETWORK_SESSION := preload("res://src/network/network_session.gd")
const VisualReloadMetricsType = preload("res://src/visual/visual_reload_metrics.gd")
const LAUNCH_SCREEN_SCENE_PATH := "res://src/app/launch_screen.tscn"
const TUTORIAL_COVE_SCENE_PATH := "res://src/world/tutorial_cove.tscn"

var _server_smoke_seconds := -1.0
var _smoke_elapsed := 0.0
var _smoke_ticks := 0
var _visual_reload_arguments: Dictionary = {}
var _visual_reloads_remaining := 0
var _visual_reload_metrics: Variant

func _ready() -> void:
	_server_smoke_seconds = _read_server_smoke_duration()
	if _server_smoke_seconds >= 0.0:
		print("SERVER_SMOKE_START tick_rate=%d" % Engine.physics_ticks_per_second)
		return

	var arguments := _argument_map()
	if arguments.has("server"):
		_start_network_server(arguments)
		return
	if arguments.has("client"):
		_start_network_client(arguments)
		return
	if arguments.has("visual-reload-smoke"):
		_visual_reload_arguments = arguments
		_visual_reloads_remaining = maxi(int(arguments.get("reload-count", "3")), 1)
		_visual_reload_metrics = VisualReloadMetricsType.new(
			OS.get_static_memory_usage(),
			get_tree().get_node_count(),
			int(Performance.get_monitor(Performance.OBJECT_COUNT)),
		)
		_start_visual_reload()
		return
	if arguments.has("slice-benchmark") or arguments.has("slice-smoke"):
		_start_tutorial_cove(arguments)
		return

	var launch_scene := ResourceLoader.load(LAUNCH_SCREEN_SCENE_PATH) as PackedScene
	if launch_scene == null:
		push_error("Could not load launch screen: %s" % LAUNCH_SCREEN_SCENE_PATH)
		get_tree().quit(1)
		return
	var launch_screen := launch_scene.instantiate()
	launch_screen.local_slice_requested.connect(_open_local_tutorial_cove.bind(launch_screen))
	add_child(launch_screen)

func _physics_process(delta: float) -> void:
	if _server_smoke_seconds < 0.0:
		return

	_smoke_ticks += 1
	_smoke_elapsed += delta
	if _smoke_elapsed < _server_smoke_seconds:
		return

	var expected_ticks := _server_smoke_seconds * float(Engine.physics_ticks_per_second)
	var within_tolerance := absf(float(_smoke_ticks) - expected_ticks) <= 2.0
	if within_tolerance:
		print("SERVER_SMOKE_OK ticks=%d elapsed=%.3f" % [_smoke_ticks, _smoke_elapsed])
		get_tree().quit(0)
	else:
		push_error("Server tick cadence outside tolerance: ticks=%d expected=%.1f" % [_smoke_ticks, expected_ticks])
		get_tree().quit(1)

func _open_local_tutorial_cove(launch_screen: Control) -> void:
	launch_screen.queue_free()
	_start_tutorial_cove({})

func _start_tutorial_cove(arguments: Dictionary, exit_when_finished: bool = true) -> Node:
	var scene := ResourceLoader.load(TUTORIAL_COVE_SCENE_PATH) as PackedScene
	if scene == null:
		push_error("Could not load Tutorial Cove scene: %s" % TUTORIAL_COVE_SCENE_PATH)
		get_tree().quit(1)
		return null
	var cove := scene.instantiate()
	cove.set("benchmark_duration_seconds", -1.0)
	if arguments.has("slice-benchmark"):
		cove.set("benchmark_duration_seconds", float(arguments.get("slice-benchmark", "300.0")))
	elif arguments.has("slice-smoke"):
		cove.set("benchmark_duration_seconds", float(arguments.get("slice-smoke", "3.0")))
	cove.set("benchmark_requires_frame_budget", arguments.has("slice-benchmark"))
	cove.set("benchmark_result_path", String(arguments.get("result", "")))
	cove.set("benchmark_screenshot_path", String(arguments.get("screenshot", "")))
	cove.set("benchmark_profile", String(arguments.get("profile", "target")))
	cove.set("benchmark_exit_on_finish", exit_when_finished)
	add_child(cove)
	return cove

func _start_visual_reload() -> void:
	var cove := _start_tutorial_cove({
		"slice-smoke": _visual_reload_arguments.get("visual-reload-smoke", "3.0"),
		"profile": _visual_reload_arguments.get("profile", "target"),
	}, false)
	if cove == null:
		return
	cove.connect("benchmark_completed", _on_visual_reload_completed.bind(cove))

func _on_visual_reload_completed(evidence: Dictionary, cove: Node) -> void:
	cove.queue_free()
	call_deferred("_record_visual_reload_cleanup", evidence)

func _record_visual_reload_cleanup(evidence: Dictionary) -> void:
	await get_tree().process_frame
	await get_tree().process_frame
	_visual_reload_metrics.record(
		evidence,
		OS.get_static_memory_usage(),
		get_tree().get_node_count(),
		int(Performance.get_monitor(Performance.OBJECT_COUNT)),
	)
	_visual_reloads_remaining -= 1
	if _visual_reloads_remaining > 0:
		_start_visual_reload()
		return

	var aggregate: Dictionary = _visual_reload_metrics.evidence()
	var passed := bool(aggregate.get("passed", false))
	var result_path := String(_visual_reload_arguments.get("reload-result", ""))
	if not result_path.is_empty():
		var absolute_path := ProjectSettings.globalize_path(result_path)
		DirAccess.make_dir_recursive_absolute(absolute_path.get_base_dir())
		var file := FileAccess.open(absolute_path, FileAccess.WRITE)
		if file == null:
			push_error("Could not write visual reload evidence: %s" % absolute_path)
			get_tree().quit(1)
			return
		file.store_string(JSON.stringify(aggregate, "	"))
	print("VISUAL_RELOAD_SMOKE_%s reloads=%d" % ["OK" if passed else "FAILED", int(aggregate.get("reload_count", 0))])
	get_tree().quit(0 if passed else 1)

func _start_network_server(arguments: Dictionary) -> void:
	var session := NETWORK_SESSION.new()
	session.name = "NetworkSession"
	add_child(session)
	var result: int = session.start_server(
		int(arguments.get("port", "7000")),
		float(arguments.get("duration", "7.0")),
		String(arguments.get("result", ""))
	)
	if result != OK:
		get_tree().quit(1)

func _start_network_client(arguments: Dictionary) -> void:
	var session := NETWORK_SESSION.new()
	session.name = "NetworkSession"
	add_child(session)
	var result: int = session.start_client(
		String(arguments.get("host", "127.0.0.1")),
		int(arguments.get("port", "7000")),
		int(arguments.get("client", "0")),
		float(arguments.get("duration", "4.0")),
		String(arguments.get("result", ""))
	)
	if result != OK:
		get_tree().quit(1)

func _argument_map() -> Dictionary:
	var result := {}
	for argument in OS.get_cmdline_user_args():
		var normalized := argument.trim_prefix("--")
		var separator := normalized.find("=")
		if separator == -1:
			result[normalized] = true
		else:
			result[normalized.left(separator)] = normalized.substr(separator + 1)
	return result

func _read_server_smoke_duration() -> float:
	for argument in OS.get_cmdline_user_args():
		if argument.begins_with("--server-smoke="):
			return maxf(argument.trim_prefix("--server-smoke=").to_float(), 0.05)
	return -1.0
