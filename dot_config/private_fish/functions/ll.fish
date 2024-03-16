function ll --wraps ls --description "List contents of directory, including hidden files in directory using long format"
    eza -la $argv
end
