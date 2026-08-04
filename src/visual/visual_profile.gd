class_name VisualProfile
extends RefCounted

const PERFORMANCE := "performance"
const TARGET := "target"
const CAPTURE := "capture"

static func normalize(requested: String) -> String:
	var candidate := requested.strip_edges().to_lower()
	if candidate in [PERFORMANCE, TARGET, CAPTURE]:
		return candidate
	return TARGET

static func settings(requested: String) -> Dictionary:
	match normalize(requested):
		PERFORMANCE:
			return {
				"profile": PERFORMANCE,
				"water_detail": false,
				"reflections": false,
				"fog": false,
				"foliage": false,
				"particles": false,
			}
		CAPTURE:
			return {
				"profile": CAPTURE,
				"water_detail": true,
				"reflections": true,
				"fog": true,
				"foliage": true,
				"particles": true,
			}
		_:
			return {
				"profile": TARGET,
				"water_detail": true,
				"reflections": true,
				"fog": true,
				"foliage": true,
				"particles": true,
			}

static func target_profile_requires_forward_plus(requested: String) -> bool:
	return normalize(requested) in [TARGET, CAPTURE]

static func renderer_is_forward_plus(renderer: String) -> bool:
	return renderer.strip_edges() == "Forward+"
