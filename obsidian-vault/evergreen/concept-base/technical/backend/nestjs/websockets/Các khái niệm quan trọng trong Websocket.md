

+ Polling ?
+ Long Polling ?


### Core WebSocket Concepts

**1. The Handshake Process** WebSockets start with an HTTP request that gets "upgraded" to a WebSocket connection. This process involves:

- Client sends HTTP request with special headers (`Upgrade: websocket`)
- Server responds with HTTP 101 status (Switching Protocols)
- Connection transforms from HTTP to WebSocket protocol

**2. Bidirectional Communication** Once connected, both client and server can send messages at any time. There's no request-response cycle - it's more like an open channel.

**3. Message Types** WebSockets support different frame types:

- Text frames (UTF-8 strings)
- Binary frames (blob data)
- Control frames (ping/pong for keeping connection alive, close frames)

**4. Connection Lifecycle**

- **Opening**: Handshake and connection establishment
- **Open**: Active communication phase
- **Closing**: Graceful shutdown with close frames
- **Closed**: Connection terminated


### Websocket visualization

https://claude.ai/public/artifacts/ae2578ef-c8a2-46d7-8ffd-c5783ef5b694


https://claude.ai/chat/865ef4a7-c0f3-4479-9429-a070b4cc5aee
---
