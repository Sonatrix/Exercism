// Package scrabble contains function for calculating scrabble score
package scrabble

import "strings"

// Score function convert the string to scrabble score
func Score(input string) int {

	result := 0
	modifiedString := strings.ToUpper(input)

	for index := range modifiedString {
		result += getScrabbleValue(rune(modifiedString[index]))
	}

	return result
}

// getScrabbleValue function to scrabble value
func getScrabbleValue(input rune) int {

	switch input {
	case 'A', 'E', 'I', 'O', 'U', 'L', 'N', 'R', 'S', 'T':
		return 1
	case 'D', 'G':
		return 2
	case 'B', 'C', 'M', 'P':
		return 3
	case 'F', 'H', 'V', 'W', 'Y':
		return 4
	case 'K':
		return 5
	case 'J', 'X':
		return 8
	case 'Q', 'Z':
		return 10
	default:
		return 0
	}
}
