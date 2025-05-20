
[Your First 3D Game From Zero](https://www.gdquest.com/library/first_3d_game_godot4_arena_fps/) [4:32:49]  

01. [Setting up](https://player.vimeo.com/video/1060451728?h=1323494251) [25:51]
02. [Coding the camera rotation](https://player.vimeo.com/video/1060451747?h=98bfef9546) [13:28]
  A. `02:49` Use the unhandled input function to track when the mouse cursor moves
  B. `04:49` Rotate the player around the y-axis when the cursor moves left or right
  C. `08:23` Rotate the camera around the x-axis when the cursor moves up or down
  D. `11:42` Limit the rotation around the x-axis to prevent the camera from going upside down
03. [Limiting the mouse](https://player.vimeo.com/video/1060451758?h=6f5d737e05) [5:36]
  A. `00:27` Hide the mouse cursor at the start of the game
  B. `02:17` Show the mouse cursor when the player presses escape on their keyboard
04. [Coding ground movement](https://player.vimeo.com/video/1060451770?h=cd0624d20e) [15:46]
  A. `00:29` Define the physics process function
  B. `03:18` Create input actions to label different inputs in the code
  C. `06:31` Move the caracter along the ground
  D. `13:06` Transform the movement to be relative to the camera orientation
05. [Coding the Jump and fall](https://player.vimeo.com/video/1060451781?h=a0b6e248f6) [13:14]
  A. `00:53` Make the character go up when pressing jump
  B. `02:31` Apply gravity to fall back on the floor
  C. `05:52` Only allow jumping when the character touches the floor
  D. `06:29` Jump higher when keeping the jump key down
  E. `08:08` Add an aim reticle at the center
06. [Creating the level](https://player.vimeo.com/video/1060451791?h=9daba54269) [33:04]
  A. `00:46` Create a platform for the player to walk on
  B. `06:49` Add a sunlight and a blue sky
  C. `11:39` Improve color balance and contrast
  D. `13:31` Add fog to give depth to the scene
  E. `16:11` Design a material to control the platform's color and texture
  F. `23:39` Duplicate platforms to assemble the level
07. [Coding the Shooting mechanics](https://player.vimeo.com/video/1060451806?h=c71530aa4f) [35:48]
  A. `00:47` Set up the bullet scene
  B. `09:30` Place and orient the bullets and their spawning point
  C. `16:05` Code the bullet forward motion
  D. `19:17` Delete bullets when they travel too far
  E. `21:35` Make bullets move independently from the gun
  F. `23:35` Shoot a bullet when the player clicks
  G. `31:01` Shoot bullets automatically at fixed time intervals
08. [Creating the mob](https://player.vimeo.com/video/1060451822?h=25a9576abd) [36:08]
  A. `00:47` Create the mob scene and prevent it from falling
  B. `05:30` Play the fly animation
  C. `10:32` Design the mob's take damage animation
  D. `20:58` Layer animations in an animation tree
  E. `27:04` Play the hurt animation when a bullet hits the mob
09. [Getting the mob to follow the player](https://player.vimeo.com/video/1060451842?h=3e4df4c403) [8:34]
  A. `00:36` Track where the player is
  B. `03:08` Move towards the player position
  C. `06:17` Turn to  face the player
10. [Damaging and killing the mob](https://player.vimeo.com/video/1060451861?h=7fd147ad2b) [10:31]
  A. `00:24` Add health and kill the mob when health reaches 0
  B. `06:30` Make the mob disappear after dying
11. [Spawning the mobs continuously from spawners](https://player.vimeo.com/video/1060451878?h=7abfa33017) [30:20]
  A. `01:29` Set up the mob spwaner scene
  B. `04:38` Spawn mobs at fixed time intervals
  C. `12:32` Give every bat a unique material
  D. `15:14` Apply shaders to animate the spawner's halo and screen
  E. `26:17` Animate the helix turning
12. [Scoring](https://player.vimeo.com/video/1060451897?h=11a0de95a4) [13:34]
  A. `00:33` Draw a label to display the current score
  B. `03:57` Track the mobs spawned in the game
  C. `07:34` Increase the score when a mob dies
13. [Adding sounds](https://player.vimeo.com/video/1060451917?h=343ed5b80d) [6:04]
  A. `00:40` Add shooting sound
  B. `02:33` Add positional hurt and die mob sounds
14. [Setting up the kill plane](https://player.vimeo.com/video/1060451930?h=734fb29dd3) [5:25]
  A. `00:26` Set up the plane and collisions
  B. `02:45` Reload the game when the player touches the plane
15. [Adding visual effects and refining the level](https://player.vimeo.com/video/1060451946?h=f5a67a69cf) [15:22]
  A. `00:50` Code a function to spawn a visual effect at a specific position
  B. `05:04` Spawn poofs when the mob spawns and dies
  C. `10:12` Delay the mob's die signal to spawn the visual effect at the right time
  D. `11:47` Refine the game level
16. [Exporting the game](https://player.vimeo.com/video/1060451959?h=4f0946de95) [4:04]

