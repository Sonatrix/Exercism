// Package isogram contains the functions for checking if string is isogram or not
package isogram

import "strings"

// IsIsogram  check if string is isogram or not
func IsIsogram(input string) bool {
	inputLower := strings.ToLower(input)
	frequency := make(map[rune]bool)
	space := ' '
	hyphen := '-'

	for _, character := range inputLower {
		_, ok := frequency[character]

		if ok && character != space && character != hyphen {
			return false
		}

		frequency[character] = true
	}

	return true
}
