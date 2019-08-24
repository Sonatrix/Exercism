// Package diffsquares contains functions for calculations
package diffsquares

// SumOfSquares calculate the sum of square
func SumOfSquares(n int) int {
	sum := (n * (n + 1) * (2*n + 1)) / 6
	return sum
}

// SquareOfSum calculate the square of sum
func SquareOfSum(n int) int {
	sum := (n * (n + 1)) / 2
	squares := sum * sum

	return squares
}

// Difference of SquareOfSum and SumOfSquares
func Difference(n int) int {
	sqOfSum := SquareOfSum(n)
	sumOfSq := SumOfSquares(n)

	difference := sqOfSum - sumOfSq

	return difference
}
