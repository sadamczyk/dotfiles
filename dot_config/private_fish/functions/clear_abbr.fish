function clear_abbr -d "Clears all fish abbreviations"
	abbr -s | string replace -- -a -e | cut -d\  -f1,2,5 | source
end
