package enemy

import (
	"math/rand"
	"time"
)

type ghost struct {
	Stats attribute
	Talk  messages
}

type skeleton struct {
	Stats attribute
	Talk  messages
}

type archer struct {
	Stats attribute
	Talk  messages
}

type attribute struct {
	name      string
	hitpoints int
	attack    int
	defense   int
}

type messages struct {
	encounter string
	flavor    string
	defeat    string
}

func initGhost() {

	rand.Seed(time.Now().UTC().UnixNano())
	var enemyNew ghost

	maxHp := 150
	minHp := 100

	maxAtt := 65
	minAtt := 50

	maxDef := 35
	minDef := 20

	enemyNew.Stats.name = "Ghost"
	enemyNew.Stats.hitpoints = rand.Intn((maxHp - minHp + 1) + minHp)
	enemyNew.Stats.attack = rand.Intn((maxAtt - minAtt + 1) + minAtt)
	enemyNew.Stats.defense = rand.Intn((maxDef - minDef + 1) + minDef)

}
