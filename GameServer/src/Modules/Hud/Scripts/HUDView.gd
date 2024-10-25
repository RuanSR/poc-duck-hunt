class_name HudView extends CanvasLayer

func update_score(score: int) -> void:
	$Sprite/Label.text = str(score)
