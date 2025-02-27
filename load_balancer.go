package main

import (
	"fmt"
	"net"
	"sync"
)

var servers = []string{"127.0.0.1:8081", "127.0.0.1:8082", "127.0.0.1:8083"}
var connections = make(map[string]int)
var mutex = &sync.Mutex{}

func getLeastConnectionsServer() string {
	mutex.Lock()
	defer mutex.Unlock()

	minServer := servers[0]
	minConn := connections[minServer]

	for _, server := range servers {
		if connections[server] < minConn {
			minServer = server
			minConn = connections[server]
		}
	}
	connections[minServer]++
	return minServer
}

func main() {
	fmt.Println("Load Balancer Running...")
	ln, _ := net.Listen("tcp", ":9090")

	for {
		conn, _ := ln.Accept()
		go func(c net.Conn) {
			defer c.Close()
			server := getLeastConnectionsServer()
			fmt.Println("Routing request to:", server)
		}(conn)
	}
}