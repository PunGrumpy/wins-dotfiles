set -g _distro ""
set -g ICON ""

switch $(uname)
    case "Darwin"
        set -g _distro "macos"
    case "Linux"
        set -g _distro "linux"
    case "MINGW*"
        set -g _distro "windows"
    case "*"
        set -g _distro ""
end

switch $_distro
    case "*macos*"
        set -g ICON "🍎"
    case "*linux*"
        set -g ICON "🐧"
    case "*windows*"
        set -g ICON "🪟"
    case "*"
        set -g ICON ""
end

set -x STARSHIP_DISTRO "$ICON"