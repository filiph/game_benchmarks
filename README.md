Benchmarking game engines with a particular focus on 2D casual gaming.

Includes the following game engines:

* Unity
* Godot
* Flutter (including Flame)

**Full disclosure:** This project was created by a member of the Flutter game development community (@filiph), so it's geared towards comparing Flutter to popular game engines. When relevant, expect more focus on comparing Flutter to other engines than other engines between themselves. 

Much effort has been spent to make the comparison fair (it would be useless otherwise). If you see technical or methodological issues, please contribute!

## Philosophy

Benchmarks are clearly useful for decision-making and goal-setting but can become less than useful (i.e. actually _harmful_) in certain circumstances. For example, it is easy to over-index on a specific benchmark and instead of optimizing for real-life scenario, optimize for the arbitrary code in the benchmark. It's also common for us people to cling to the datapoints provided by benchmarks even though the picture tends to be much more complex, _precisely_ because the datapoints let us pretend that the picture is actually simple.

For this reason, 

1. The context and focus of this benchmark is explicitly stated so that people can't confuse it with a general-purpose comparison. We are interested in comparing Flutter (and Flame) with popular game engines, especially in the context of 2D games like Slay the Spire, Balatro, Peglin, Undertale, Papers Please, or TIS-100.
2. It is forbidden to optimize the code of the implementations beyond what's vaguely defined as “best practices.” In other words, while it's expected that the implementation for each game engine will not have outright performance bugs, it is _not okay_ to apply wizard-level optimizations that only a few software engineers would think of. This is not a race to see who can implement it better, it's a benchmark.
3. It is highly discouraged to use measurements from this benchmark as a sole datapoint. Always augment with more context. Remember Goodhart’s Law.
4. It is highly encouraged to read the fine print. To make some measurements, one needs to make a number of subtle judgement calls. These are documented, and often quite important in their effect on the numbers.


## Methodology

The same "game" is implemented in all benchmarked game engines. The implementations don't need to be pixel-perfect but they have to be functionally the same.

Here are a few characteristics of 2D games (and especially _casual_ 2D games) that seem relevant for benchmarking:

- There's always movement. Almost no game screen is fully static.
- Backgrounds are artistic, which almost always translates to large bitmap image files being shown.
- There's music. Which means that sizeable audio files need to be bundled with the game, and one needs to be loaded on start.
- Many subgenres (but not all) track a significant number of entities and update them every frame.
- There's almost always an overlay with some UI elements.
- Casual games try to start as soon as possible (in contrast with many hardcore games, which are meant for focused, uninterrupted play sessions, and can therefore take their time on startup).

For these reasons, the implemented project looks the way it does. See below.


#### Elements of the implemented project

- We try to get to the "game" as soon as possible. No splash screens, no loading screens if possible.
- We show a big, complicated bitmap file as the background.
- We also show a reasonably big logo file with transparency, and we continuously animate it with a breathing effect.
- We instantiate 20 buttons. Each disappears when clicked.
- We start playing music. This is a medium-length looped track (2:30 minutes), about 5 MB in MP3 form.
- We add a button for audio on and off. This is mostly a convenience feature for the person running the benchmark (it can get annoying to hear the music on repeat for an hour) but it's also the only way to play the audio on the web (browsers don't allow audio until the user interacts with the page in some way).
- We have a pair of buttons for increasing and decreasing the number of entities in the game, by an increment of 100. The entity count starts at 0.
- When new entities are added, they simply wander around the screen. _But_, this is not meant to be a particle system benchmark. Entities must be implemented as actual entities in the engine (e.g. `GameObject` in Unity). Each entity is also paired with another entity, and each of the pair's velocity subtly influences the other's velocity. This attempts to simulate the fact that, in most games, entities react to other entities. However, the entities are not rigid bodies in a 2D physics simulations and there is no collision detection. Only a simple `velocity` vector is implemented. Not only is this not meant to be a particle system benchmark, this is also not meant to be a physics engine benchmark. It is merely a way to see how big of an impact the number of game objects has on CPU and memory usage.


#### What we measure

- **Startup time** (time to first full, interactive frame)
  - Why this benchmark? Because, especially for casual games, slow startup times can be a strong disincentive to come back to playing games. Imagine if Solitaire or Minesweeper took 2 minutes to load.
- **Max entities** (how many entities before framerate starts to suffer)
  - Why this benchmark? Because it's good to know how busy the game can be. This is less important for, say, card games, but it's important for some popular 2D genres, such as Vampire Survivor-likes or 2D simulators.
- **CPU usage** (how much CPU does the game need for normal operation)
  - Why this benchmark? Because good FPS is less impressive when it drains the phone's battery in record time, or when it makes the laptop's fans go into overdrive.
- **Memory usage** (how much RAM does the game need for normal operation)
  - Why this benchmark? Because memory is limited on mobile devices, and memory pressure can be as serious or more than high CPU load.


#### Targets

- Web (P0)
- iOS (P0, stands in for "mobile")
- --- (targets below this line aren't tracked at this point)
- Android (P1)
- Windows (P2, stands in for "desktop")
- Linux (P4)
- macOS (P4)


#### Measured game engines

- Flutter vanilla (P0)
- Flutter Flame (P0)
- Unity (P0)
  - Because it's the most popular commercial game engine for indies. Still the industry standard.
  - Popular games: Among us, Peglin, Machinarium, Mini Metro, Hearthstone, Thomas Was Alone, TIS-100, My Talking Tom, among others.
- Godot (P0)
  - Because it's the most popular open source game engine for indies. There seems to be a trend going in that direction from Unity so it would be weird to omit this engine despite the lack of popular games to date.
  - Popular games: Brotato, Dome Keeper, ΔV: Rings of Saturn (and not many others if we're looking at the popular ones).
- --- (engines below this line aren't tracked at this point)
- Game Maker (P1)
  - Because it's the most popular game engine made specifically for 2D games.
  - Popular games: Katana Zero, Downwell, Undertale, Minit, Nidhogg 2, among others.
- LÖVE (P2)
  - Code-focused game runtime/framework, no IDE. Application authors write Lua. Draw 2D scenes with a Canvas-like interface. Offers custom fragment shaders.
  - Popular games: Balatro.
- libGDX (P2)
  - Similar to Flutter in that there's no IDE, just a framework, and that the language used is at least superficially similar to Dart (it's Java).
  - Popular games: Slay the Spire, Mindustry, Wildermyth.
- Construct 3 (P4)
- Defold (P4)

A good resource to check popular games by engine: [SteamDB Engine page](https://steamdb.info/tech/). But it only includes Steam (i.e. desktop) games.


## Contributing

This repo uses Git Large File Storage (LFS) to store large files and directories that aren't useful to source-control. Please [install Git LFS](https://git-lfs.com/) before cloning.
