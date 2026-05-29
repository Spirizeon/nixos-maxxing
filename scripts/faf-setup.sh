#!/usr/bin/env bash

# This script is necessary to create a file expected by the command `faf-client-setup`
# Since it is located in /tmp and rarely needed, a script should suffice
# NOTE: The __PROTON and __STEAMAPPS paths may need to be changed

# Steps:
# 1. Create directory
# 2. Write content into file
# 3. Make file executable

mkdir -p /tmp/proton-chris

cat > /tmp/proton-chris/run << 'EOF'
#!/usr/bin/env bash

__PROTON="/home/chris/.local/share/Steam/compatibilitytools.d/Proton-GE Latest"
__STEAMAPPS="/games/SteamLibrary/steamapps"
__STEAM="${XDG_DATA_HOME:-$HOME/.local/share}/Steam"

cd "$__STEAMAPPS/common/Supreme Commander Forged Alliance" || exit
DEF_CMD=("$__STEAMAPPS/common/Supreme Commander Forged Alliance/bin/SupremeCommander.exe")
PATH="$__PROTON/files/bin/:/usr/bin:/bin" \
    TERM="xterm" \
    WINEDEBUG="-all" \
    WINEDLLPATH="$__PROTON/files/lib64/wine:$__PROTON/files/lib/wine" \
    LD_LIBRARY_PATH="$__PROTON/files/lib64/:$__PROTON/files/lib/:/usr/lib/pressure-vessel/overrides/lib/x86_64-linux-gnu/aliases:/usr/lib/pressure-vessel/overrides/lib/i386-linux-gnu/aliases" \
    WINEPREFIX="$__STEAMAPPS/compatdata/9420/pfx/" \
    WINEFSYNC="1" \
    SteamGameId="9420" \
    SteamAppId="9420" \
    WINEDLLOVERRIDES="steam.exe=b;dotnetfx35.exe=b;dotnetfx35setup.exe=b;beclient.dll=b,n;beclient_x64.dll=b,n;d3d11=n;d3d10core=n;d3d9=n;dxgi=n;d3d12=n;d3d12core=n" \
    STEAM_COMPAT_CLIENT_INSTALL_PATH="$__STEAM" \
    WINE_LARGE_ADDRESS_AWARE="1" \
    GST_PLUGIN_SYSTEM_PATH_1_0="$__PROTON/files/lib64/gstreamer-1.0:$__PROTON/files/lib/gstreamer-1.0" \
    WINE_GST_REGISTRY_DIR="$__STEAMAPPS/compatdata/9420/gstreamer-1.0/" \
    MEDIACONV_AUDIO_DUMP_FILE="$__STEAMAPPS/shadercache/9420/fozmediav1/audiov2.foz" \
    MEDIACONV_AUDIO_TRANSCODED_FILE="$__STEAMAPPS/shadercache/9420/transcoded_audio.foz" \
    MEDIACONV_VIDEO_DUMP_FILE="$__STEAMAPPS/shadercache/9420/fozmediav1/video.foz" \
    MEDIACONV_VIDEO_TRANSCODED_FILE="$__STEAMAPPS/shadercache/9420/transcoded_video.foz" \
    "$__PROTON/files/bin/wine64" c:\\windows\\system32\\steam.exe "${@:-${DEF_CMD[@]}}"
EOF

chmod +x /tmp/proton-chris/run
