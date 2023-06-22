if status is-interactive
    # General abbreviations 
    abbr -a -- conf cd ~/.config/
    abbr -a -- chm chezmoi
    abbr -a -- g git

    ## Docker
    abbr -a -- d docker
    abbr -a -- dc docker compose
    abbr -a -- dcu 'docker compose up -d'
    abbr -a -- dcub 'docker compose up --build -d'
    abbr -a -- dcb 'docker compose build'
    abbr -a -- dcd 'docker compose down'
    abbr -a -- dps 'docker ps'

    # Color theme
    fish_config theme choose Bay\ Cruise

    # Exports
    # -R for color, -x4 for tabs = 4 spaces
    set -gx LESS "-Rx4"
end

export PATH="/usr/local/bin:$PATH"

# Load additional config not tracked by chezmoi
source ~/.config/fish/local_config.fish
