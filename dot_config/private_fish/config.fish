if status is-interactive
    # General abbreviations
    abbr -a -- conf cd ~/.config/
    abbr -a -- cm chezmoi
    abbr -a -- g git
    abbr -a -- gs git status -sb
    abbr -a -- e hx
    abbr -a -- vi nvim
    abbr -a -- vim nvim

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

export EDITOR="hx"
export PATH="$HOME/.scripts:/usr/local/bin:$PATH"

# TODO Check if this only works / is necessary on linux?
export DOCKER_HOST="unix:///home/sadamczyk/.docker/desktop/docker.sock"

# https://rsteube.github.io/carapace-bin/setup.html
mkdir -p ~/.config/fish/completions
carapace --list | awk '{print $1}' | xargs -I{} touch ~/.config/fish/completions/{}.fish # disable auto-loaded completions (#185)
carapace _carapace | source

# https://starship.rs/
starship init fish | source

# Load additional config not tracked by chezmoi
source ~/.config/fish/local_config.fish
