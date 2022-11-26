extends Node

enum Category{STUDENT, TEACHER};
enum Scene{CHOOSE_FEATURE, ADD_EDIT_DELETE, GRAPHEME_FORM,
DISPLAY_GRAPHEME_LIST, DISPLAY_GRAPHEME_ITEM, GAME_LIST,
ADD_QUESTIONNAIRE, GAME_QUESTIONNAIRE, WINNING_SCREEN,
MONSTER_MARKET, IDENTIFY_GAME, IDENTIFY_SELECT};
enum Mode{ADD, CHANGE, DELETE};

var user_type: int = -1;
var screen_type: int = -1;
var mode_type: int = -1;

var ref_ortho_repo: OrthographyRepository;
var ref_selected_item: Object;

signal user_selected();
signal change_screen();

func load_repo():
	self.ref_ortho_repo = SaveLoading.orthography_repo;
	
func set_user(type: int) -> void:
	self.user_type = type;
	emit_signal("user_selected");

func set_screen(type: int) -> void:
	self.screen_type = type;
	emit_signal("change_screen");

func set_mode(type: int) -> void:
	self.mode_type = type;

func select_item(item: Object) -> void:
	self.ref_selected_item = item;
