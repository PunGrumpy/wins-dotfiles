set fish_greeting ""

set -gx TERM xterm-256color

set -gx EDITOR nvim

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH

# Theme
set -g theme_color_scheme terminal-dark
set -g fish_prompt_pwd_dir_length 1
set -g theme_display_user yes
set -g theme_hide_hostname no
set -g theme_hostname always

# Starship prompt
if command -qv starship &> /dev/null
    source (dirname (status --current-filename))/starship.fish
    eval (starship init fish)
end

# Aliases
alias ls "ls -p -G"
alias la "ls -A"
alias ll "ls -l"
alias lla "ll -A"
alias g git
alias vim nvim
command -qv nvim && alias vim nvim
if type -q eza
    alias ll "eza -l --group --icons --long"
    alias lla "ll -a"
end
