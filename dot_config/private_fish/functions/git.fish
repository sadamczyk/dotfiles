function g -d 'Runs git status without args, or git when args are given.'
	# https://stackoverflow.com/a/29643375
	if count $argv > /dev/null
		git $argv
	else
		git status
	end
end
