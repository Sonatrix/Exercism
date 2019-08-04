// Package twofer contains method for personalize message
package twofer

import "strings"

// ShareWith personalize personalise message.
func ShareWith(name string) string {

	message := "One for you, one for me."

	if name != "" {
		return strings.Replace(message, "you", name, 1)
	}

	return message

}
