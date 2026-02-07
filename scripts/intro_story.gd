extends Control
@onready var story_text: RichTextLabel = $StoryText
@onready var skip_button: Button = $SkipButton
@onready var v_scroll: ScrollBar = story_text.get_v_scroll_bar()

const SCROLL_DURATION: float = 90.0

func _ready() -> void:
	story_text.bbcode_enabled = true
	# Testo con BBCode (colori, effetti)
	#story_text.text = """[center][color=red][wave amp=20 freq=2]HammerHeart[/wave][/color][/center]
#[color=gray]E' una notte buia e tempestosa e il cielo è illuminato solo da terribili lampi, barlumi di luce nelle tenebre.[/color]
#Sei appena rientrato a casa dalla tua fucina, dopo una giornata di lavoro dura come il metallo che hai battuto e forgiato per tutto il giorno.\n\n
#Ma ad attenderti c'è un'amara sorpresa. La tua piccola abitazione è stata messa completamente sotto sopra, il tavolo della cucina
#rovesciato, la dispensa aperta e messa a soqquadro e la stanza da letto completamente distrutta.\n\n
#Ti guardi intorno impaurito alla ricerca di Adelina, la tua dolce sposa. Di lei, però, nessuna traccia. Cerchi 
#in tutte le stanze ma nulla da fare.\n\n
#Alla fine ti cade l'occhio su un foglio di carta fissato con un pugnale ad una delle pareti di casa. Un messaggio scritto con il sangue
#ti blocca il respiro: [color=yellow][i]"Se ci tieni alla tua dolce metà vieni a riprenderla al castello di Blorn e ... ricordati di portare con te il tuo martello[i][/color]".\n\n
 #
#Il tuo martello è l'unica speranza, insieme al tuo coraggio.
#Raccogli le gemme, prendi la chiave e apri il forziere per addentrarti nell'oscura dimora.
#[b]Non è il momento di avere paura![b]
#[shake rate=5 level=10]Premi SPAZIO per iniziare...[/shake]
#"""
	story_text.text = """[center][color=red][wave amp=20 freq=2]HammerHeart[/wave][/color][/center]

[color=gray]It's a dark and stormy night, the sky lit only by terrifying lightning flashes, glimmers of light in the darkness.

You've just returned home from your forge after a hard day hammering and forging metal.

But a bitter surprise awaits you. Your small home has been completely ransacked—the kitchen table overturned, the pantry opened and rummaged through, and the bedroom utterly destroyed.

You look around frightened, searching for Adelina, your sweet wife. But there's no trace of her. You search every room, but nothing.

Finally, your eye falls on a piece of paper pinned to the wall with a dagger. A message written in blood stops your breath: [color=yellow][i]'If you care about your sweet half, come reclaim her at Blorn Castle and... remember to bring your hammer with you.'[/i][/color]

Your hammer is your only hope, along with your courage.
Collect the gems, grab the key and open the chest to enter the dark dwelling.
[b]This is not the time to be afraid![/b]
[shake rate=5 level=10]Press SPACE to begin...[/shake][/color]"""

	
	# Avvia scorrimento
	scroll_story()
	
	

func scroll_story() -> void:
	# Aspetta che il testo sia renderizzato
	await get_tree().process_frame
	var tween = create_tween()
	tween.tween_method(
		_set_scroll,           # Funzione custom
		0.0,                   # Da
		v_scroll.max_value,    # A (fine scrollbar)
		SCROLL_DURATION        # Durata
	).set_trans(Tween.TRANS_LINEAR).set_ease(Tween.EASE_IN_OUT)
	
	# Fade-in elegante
	tween.parallel().tween_property(story_text, "modulate:a", 1.0, 1.5)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):  # SPAZIO
		go_to_level()

func _set_scroll(value: float) -> void:
	v_scroll.value = value

func go_to_level() -> void:
	MusicIntro.stop()
	get_tree().change_scene_to_file("res://scenes/level_1.tscn")

func _on_skip_button_pressed() -> void:
	go_to_level()
