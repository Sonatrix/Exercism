// Package strand contains functions for transcription
package strand

// ToRNA function transcribe the string to its rna transcription
func ToRNA(dna string) string {

	transcription := map[rune]rune{'C': 'G', 'G': 'C', 'T': 'A', 'A': 'U'}

	if dna == "" {
		return ""
	}

	dnastr := ""
	for _, char := range dna {
		dnastr += string(transcription[char])
	}

	return dnastr

}
