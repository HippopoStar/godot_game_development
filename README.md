# godot\_game\_development

[GitHub - Godot Engine - awesome-godot (#themes)](https://github.com/godotengine/awesome-godot#themes)  

[GitHub - Godot Engine - godot/icon.svg](https://github.com/godotengine/godot/blob/master/icon.svg)  
[GitHub - Godot Engine - godot/icon.png](https://github.com/godotengine/godot/blob/master/icon.png)  

```
GODOT_APP=~/Downloads/Godot/Godot_v4.4.1-stable_linux.x86_64
GODOT_ICON=~/Downloads/Godot/godot_icon.svg
GODOT_ENTRY=~/.local/share/applications/godot.desktop

cat <<_EOF > "${GODOT_ENTRY}"
[Desktop Entry]
Version=1.0
Type=Application
Name=Godot
Comment=Launch Godot Engine
Icon=${GODOT_ICON}
Exec=${GODOT_APP}
_EOF

chmod a+x "${GODOT_ENTRY}"
```

[YouTube - MisterMV - Godot & la creation de Chants of Sennaar (27:43)](https://youtu.be/MQfMkOJHHYQ?t=1663)  

