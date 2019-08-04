// Package hamming contain function for calculating hamming distance
package hamming

import "errors"

// Distance function is used to calculate hamming distance between two strings
func Distance(a, b string) (int, error) {

	if len(a) != len(b) {
		err := errors.New("Different sized strings")
		return 0, err
	}

	distance := 0

	for index := range a {
		if b[index] != a[index] {
			distance++
		}
	}

	return distance, nil
}
