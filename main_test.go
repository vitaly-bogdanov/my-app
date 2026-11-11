package main

import "testing"

func TestAdd(t *testing.T) {
	if Add(2, 3) != 5 {
		t.Fatal("Add(2,3) должен вернуть 5")
	}
}

func BenchmarkAdd(b *testing.B) {
	for b.Loop() {
		sink = Add(2, 3)
	}
}

// sink не даёт компилятору выкинуть вызов Add как неиспользуемый.
var sink int
