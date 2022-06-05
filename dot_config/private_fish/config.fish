if status is-interactive
    # General abbreviations
    abbr -a -U -- l ll

    ## Docker
    abbr -a -U -- d docker
    abbr -a -U -- dc docker-compose
    abbr -a -U -- dcu 'docker-compose up -d'
    abbr -a -U -- dcub 'docker-compose up --build -d'
    abbr -a -U -- dcd 'docker-compose down'
    abbr -a -U -- dps 'docker ps'
end

export PATH="/usr/local/bin:$PATH"

# Load additional config not tracked by chezmoi
source ~/.config/fish/local_config.fish
