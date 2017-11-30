package main

import (
	"testing"
)

func TestSample(t *testing.T) {
	expect := "make make great again"
	actual := Hello()
	if actual != expect {
		t.Fatalf("expect %v got %v", expect, actual)
	}
}
