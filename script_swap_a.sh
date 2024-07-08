#!/bin/bash

# Define the characters to swap
old_char='a'  # Letter a
new_char='а'  # Cyrillic letter а

# Function to swap characters once in a file
swap_char_once() {
    local file=$1
    local temp_file=$(mktemp)

    # Swap the first occurrence of old_char with new_char
    awk -v old="$old_char" -v new="$new_char" '{
        if (match($0, old)) {
            print substr($0, 1, RSTART-1) new substr($0, RSTART+1)
        } else {
            print
        }
    }' "$file" > "$temp_file"

    # Replace the original file with the modified content
    mv "$temp_file" "$file"
}

# Export the function and variables to be used by find -exec
export -f swap_char_once
export old_char
export new_char


# Decommente cette ligne pour aller a la racine des le debut
# cd

# hotswap les deux characteres sur tout les fichiers .c du repertoire courant et de tout les sous-repertoires
find . -type f -name "*.c" -exec bash -c 'swap_char_once "$0"' {} \;

# revenir a l'emplacement initial, nivu niconu hehe
# cd "$OLDPWD"

echo "cheh"

