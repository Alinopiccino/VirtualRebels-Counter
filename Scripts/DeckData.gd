extends Resource
class_name DeckData

@export var deck_name: String
@export var cards: Array[CardData] = []
@export var is_valid: bool = true
@export_enum("none", "asc", "desc") var mana_sort_state: String = "none"
@export_enum("none", "asc", "desc") var rank_sort_state: String = "none"
@export_enum("Fire", "Earth", "Water", "Wind") var mana_slot_1: String = "Fire"
@export_enum("Fire", "Earth", "Water", "Wind") var mana_slot_2: String = "Fire"
@export_enum("Fire", "Earth", "Water", "Wind") var mana_slot_3: String = "Fire"
@export_enum("Fire", "Earth", "Water", "Wind") var mana_slot_4: String = "Fire"
@export_enum("Fire", "Earth", "Water", "Wind") var mana_slot_5: String = "Fire"

func get_mana_slots() -> Array[String]:
	return [mana_slot_1, mana_slot_2, mana_slot_3, mana_slot_4, mana_slot_5]


# === 🔁 SERIALIZZAZIONE / DESERIALIZZAZIONE ===

func to_dict() -> Dictionary:
	var card_dicts: Array = []
	for card in cards:
		if card != null:
			card_dicts.append(card.to_dict()) # serve che anche CardData supporti to_dict()
	return {
		"deck_name": deck_name,
		"cards": card_dicts,
		"is_valid": is_valid,
		"mana_sort_state": mana_sort_state,
		"rank_sort_state": rank_sort_state,
		"mana_slots": get_mana_slots()
	}

static func from_dict(data: Dictionary) -> DeckData:
	var deck = DeckData.new()
	deck.deck_name = data.get("deck_name", "Unknown Deck")
	deck.is_valid = data.get("is_valid", true)
	deck.mana_sort_state = data.get("mana_sort_state", "none")
	deck.rank_sort_state = data.get("rank_sort_state", "none")
	var mana_slots = data.get("mana_slots", [])
	if mana_slots.size() >= 5:
		deck.mana_slot_1 = mana_slots[0]
		deck.mana_slot_2 = mana_slots[1]
		deck.mana_slot_3 = mana_slots[2]
		deck.mana_slot_4 = mana_slots[3]
		deck.mana_slot_5 = mana_slots[4]

	var cards: Array[CardData] = []
	for cdict in data.get("cards", []):
		var c = CardData.from_dict(cdict)
		cards.append(c)
	deck.cards = cards
	return deck
