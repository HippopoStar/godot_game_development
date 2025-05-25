
[GDQuest - Godot Tutorials - Your First 3D GAME From Zero](https://gdquest.com/tutorial/godot/3d/first-3d-game-godot-4/) [4:32:49]  

---

[YouTube - GDQuest - 2025\_05\_11 - Your First 3D GAME From Zero in Godot 4 \*\*Survivor Arena FPS\*\*](https://youtu.be/NJJNWGD25rg) [2:22:52]  
- `0:52:12` $\[%\]
- `1:42:39` $\[%\]

---

01. [Setting up](https://player.vimeo.com/video/1060451728?h=1323494251) [25:51]
02. [Coding the camera rotation](https://player.vimeo.com/video/1060451747?h=98bfef9546) [13:28]
	- `02:49` **A**. Use the unhandled input function to track when the mouse cursor moves
	- `04:49` **B**. Rotate the player around the y-axis when the cursor moves left or right
	- `08:23` **C**. Rotate the camera around the x-axis when the cursor moves up or down
	- `11:42` **D**. Limit the rotation around the x-axis to prevent the camera from going upside down
03. [Limiting the mouse](https://player.vimeo.com/video/1060451758?h=6f5d737e05) [5:36]
	- `00:27` **A**. Hide the mouse cursor at the start of the game
	- `02:17` **B**. Show the mouse cursor when the player presses escape on their keyboard
04. [Coding ground movement](https://player.vimeo.com/video/1060451770?h=cd0624d20e) [15:46]
	- `00:29` **A**. Define the physics process function
	- `03:18` **B**. Create input actions to label different inputs in the code
	- `06:31` **C**. Move the caracter along the ground
	- `13:06` **D**. Transform the movement to be relative to the camera orientation
05. [Coding the Jump and fall](https://player.vimeo.com/video/1060451781?h=a0b6e248f6) [13:14]
	- `00:53` **A**. Make the character go up when pressing jump
	- `02:31` **B**. Apply gravity to fall back on the floor
	- `05:52` **C**. Only allow jumping when the character touches the floor
	- `06:29` **D**. Jump higher when keeping the jump key down
	- `08:08` **E**. Add an aim reticle at the center
06. [Creating the level](https://player.vimeo.com/video/1060451791?h=9daba54269) [33:04]
	- `00:46` **A**. Create a platform for the player to walk on
	- `06:49` **B**. Add a sunlight and a blue sky
	- `11:39` **C**. Improve color balance and contrast
	- `13:31` **D**. Add fog to give depth to the scene
	- `16:11` **E**. Design a material to control the platform's color and texture
	- `23:39` **F**. Duplicate platforms to assemble the level
07. [Coding the Shooting mechanics](https://player.vimeo.com/video/1060451806?h=c71530aa4f) [35:48]
	- `00:47` **A**. Set up the bullet scene
	- `09:30` **B**. Place and orient the bullets and their spawning point
	- `16:05` **C**. Code the bullet forward motion
	- `19:17` **D**. Delete bullets when they travel too far
	- `21:21` **E**. Make bullets move independently from the gun
	- `23:35` **F**. Shoot a bullet when the player clicks
	- `31:01` **G**. Shoot bullets automatically at fixed time intervals
08. [Creating the mob](https://player.vimeo.com/video/1060451822?h=25a9576abd) [36:08]
	- `00:47` **A**. Create the mob scene and prevent it from falling
	- `05:30` **B**. Play the fly animation
	- `10:32` **C**. Design the mob's take damage animation
	- `20:58` **D**. Layer animations in an animation tree (`26:59` $\[%\])
	- `27:04` **E**. Play the hurt animation when a bullet hits the mob
09. [Getting the mob to follow the player](https://player.vimeo.com/video/1060451842?h=3e4df4c403) [8:34]
	- `00:36` **A**. Track where the player is
	- `03:08` **B**. Move towards the player position
	- `06:17` **C**. Turn to face the player
10. [Damaging and killing the mob](https://player.vimeo.com/video/1060451861?h=7fd147ad2b) [10:31]
	- `00:24` **A**. Add health and kill the mob when health reaches 0
	- `06:30` **B**. Make the mob disappear after dying
11. [Spawning the mobs continuously from spawners](https://player.vimeo.com/video/1060451878?h=7abfa33017) [30:20]
	- `01:29` **A**. Set up the mob spawner scene
	- `04:38` **B**. Spawn mobs at fixed time intervals
	- `12:32` **C**. Give every bat a unique material
	- `15:14` **D**. Apply shaders to animate the spawner's halo and screen
	- `26:17` **E**. Animate the helix turning
12. [Scoring](https://player.vimeo.com/video/1060451897?h=11a0de95a4) [13:34]
	- `00:33` **A**. Draw a label to display the current score
	- `03:57` **B**. Track the mobs spawned in the game (`06:20` $\[%\])
	- `07:34` **C**. Increase the score when a mob dies
13. [Adding sounds](https://player.vimeo.com/video/1060451917?h=343ed5b80d) [6:04]
	- `00:40` **A**. Add shooting sound
	- `02:33` **B**. Add positional hurt and die mob sounds
14. [Setting up the kill plane](https://player.vimeo.com/video/1060451930?h=734fb29dd3) [5:25]
	- `00:26` **A**. Set up the plane and collisions
	- `02:45` **B**. Reload the game when the player touches the plane
15. [Adding visual effects and refining the level](https://player.vimeo.com/video/1060451946?h=f5a67a69cf) [15:22]
	- `00:50` **A**. Code a function to spawn a visual effect at a specific position
	- `05:04` **B**. Spawn poofs when the mob spawns and dies
	- `10:12` **C**. Delay the mob's die signal to spawn the visual effect at the right time
	- `11:47` **D**. Refine the game level
16. [Exporting the game](https://player.vimeo.com/video/1060451959?h=4f0946de95) [4:04]

