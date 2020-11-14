package main

import (
	"fmt"
)

var x int = 4

func main() {

	c := 5
	x = 6
	fmt.Println(x, c)
	varTest()
}

func varTest() {
	fmt.Println(x)

}
