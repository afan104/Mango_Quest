# Adding a New Sound to the Game

Follow these steps to add a new sound to the game. If you are only registering a new signal to an existing sound or vice versa, you can skip some of these steps.
The way to add new sounds to the game is by using the `Audio Manager` scene. This scene is responsible for playing sounds in the game and managing their playback.

## 1. Define the Signal (if necessary)

First, determine which signal you want to use in `signal_bus.gd`. For example, if you want to play a sound when the player dies, you can use the signal `player_died`. If the signal does not exist, create a new one with the following code:

```gdscript
signal player_died
```

## 2. Emit the Signal (if necessary)

In the script where you want to play the sound, you need to emit the signal using the `SignalBus`. For example, to play a sound when the player dies, use this code:

```gdscript
SignalBus.player_died.emit()
```

## 3. Create the `AudioStreamPlayer` (if necessary)

Create a new `AudioStreamPlayer` in the `Audio Manager` scene and add the sound you want to play to it. You don't need to add the sound to the `AudioStreamPlayer` if you are only registering a signal to an existing sound.

## 4. Register the Signal

In `audio_manager.gd`, add a reference to the `AudioStreamPlayer` you created in the previous step at the top of the file. For example, if you created an `AudioStreamPlayer` called `Player Died Sound`, add the following code:

```gdscript
@onready var player_died_sound = "$Player Died Sound"
```

Next, register the signal in the `initialize_callback_map` function with the following code:

```gdscript
audio_callback_map[SignalBus.player_died] = [player_died_sound, true]
```

The `true` value indicates that the sound should loop when played. If you do not want the sound to loop, use `false` instead.
