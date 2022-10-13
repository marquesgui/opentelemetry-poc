package main

import (
	"github.com/nats-io/nats.go"
	"log"
	"time"
)

func main() {
	log.Println("Main4: Starting app...")
	nc, err := nats.Connect("nats://192.168.64.6:4222")
	if err != nil {
		log.Fatal(err)
	}
	defer nc.Close()

	ec, err := nats.NewEncodedConn(nc, nats.JSON_ENCODER)
	if err != nil {
		log.Fatal(err)
	}
	defer ec.Close()

	type msg struct {
		Text      string `json:"text"`
		Timestamp string `json:"date"`
	}

	go func() {
		if _, err := ec.Subscribe("telemetry-poc.end", func(m *msg) {
			log.Printf("Runner4 | Text: %s, Timestamp: %s", m.Text, m.Timestamp)
		}); err != nil {
			log.Fatal(err)
		}
	}()

	for true {
		time.Sleep(time.Millisecond * 500)
	}

	//if err := ec.Publish("telemetry-poc", &msg{Text: "Teste123", Timestamp: time.Now().String()}); err != nil {
	//	log.Fatal(err)
	//}
}
