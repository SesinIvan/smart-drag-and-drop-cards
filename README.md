# Smart Drag and Drop Cards

My experimental asset for **Godot 4.x** to add mechanics for transferring cards within a single field (a battlefield or a player's hand)

![Gif of cards being moved inside the field](https://raw.githubusercontent.com/SesinIvan/relocatable-drag-and-drop-cards/main/dnd_replace_in_field.gif)
![Gif of cards being moved form field to field](https://raw.githubusercontent.com/SesinIvan/relocatable-drag-and-drop-cards/main/dnd_from_field_to_field.gif)

## Background
While playing Hearthstone Battlegrounds, I noticed that the character affects the leftmost card in the hand, but it is impossible to change the location of cards in the hand, although it can be done on the field.

I decided to implement the mechanics of moving cards in the hand, because in other card games like Magic: The Gathering or Hearthstone and in Godot Asset Store there is no such function. 

As a result, it turned out to create not so much a "special hand" as a universal field with relocatable card mechanics.

## How It Works
I took a cool [tutorial](https://youtu.be/Pa0P1lUoC-M?si=Uy0jS18My5LJzYid) on creating cards and moving them around as a basis.

There are two important scenes to the example: 
- Card - scene that is on a field
- Field - scene that contains the cards

### Card
The card has the following important elements:

- DropPointDetector (Area2D) - responsible for defining the fields and their Area2Ds
- CardsDetector (Area2D) - responsible for defining overlapping CardsDetectors of other cards
- State Machine and the following states:
    - Idle - idle state when no cursor is on the card
    - Hover - the state when the cursor is hovered over the card
    - Click - the state when the left mouse button is pressed and when the cursor is moved it switches to Drag state.
    - Drag - state of moving the card. In this state, the card changes its parent to CanvasLayer to be above all cards and fields
    - Release - the state that occurs when the card is released. In this state, the card checks its current location with DropPointDetector/CardsDetector and determines where to move the card depending on the result.

### Field
A card has the following important elements:
- CardsHolder (HBoxContainer) - this node stores and arrange cards, so the parent node of cards is Control
- CardDropAreaRight (Area2D) and CardDropAreaLeft (Area2D) - these important nodes are necessary for the card to determine where it goes depending on its release using the Release state.

The field script has the following important functions:
- return_card_starting_position() - the card returns to its field and to its original position
- card_reposition() - the card takes the given position depending on its location on the field among other cards.
    - If there are no cards, it becomes at the center of the field. (Possibly due to HBoxContainer alignment set to Center).
    - If one card is already on the field (and it will always be at center), we check which of the CardDropAreaRight/CardDropAreaLeft is touched by the DropPointDetector and place it at the beginning/end of the row of cards.
    - If a card touches 2 cards with CardsDetector, then we become in this field between them.
- set_new_card() - the card remembers its new home field and takes the given position using card_reposition()

### Practice
When a card enters the Release state, its location is checked:

- If the card is located outside of any fields, it refers to its "home" field and returns to its starting position using the return_card_starting_position() function of its field
- If a card is placed in a field and this is its "home" field, then we check its position within that field and its relation to other cards using the card_reposition() function of that field.
- If a card is located in a field and this is a new field for it, then it changes its home field and is placed in the field using the set_new_card() function of the new field.

## Current Status
So far, I have implemented everything I wanted within this program. Cards move between fields and take positions depending on its position.

No bugs causing crashes and errors were found.

I use this project for the basis of my 2 projects (game and utility program).
