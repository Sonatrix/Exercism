// Package luhn contains function for valid luhn
package luhn

import (
	"strconv"
	"strings"
)

// Valid function check if number is valif lubn or not
func Valid(number string) bool {
	sum := 0

	fNumber := strings.Replace(number, " ", "", -1)
	length := len(fNumber)
	sNumber, err := strconv.Atoi(fNumber)

	if length <= 1 || err != nil {
		return false
	}

	i := 0

	for i < length {
		d := sNumber % 10
		sNumber /= 10

		if i%2 == 0 {
			sum += d
		} else {
			d2 := d * 2
			if d2 > 9 {
				sum += d2 - 9
			} else {
				sum += d2
			}
		}

		i++
	}

	if sum%10 == 0 {
		return true
	}

	return false
}
