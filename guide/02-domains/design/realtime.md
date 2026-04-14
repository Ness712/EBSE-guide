# Communication temps reel

**[RECOMMANDE]** WebSocket (SockJS+STOMP) pour Spring Boot, SSE pour one-way, polling en fallback | Score GRADE : 4/7

Le choix du transport depend du pattern de communication. WebSocket pour le bidirectionnel (chat, notifications), SSE pour le serveur-vers-client uniquement.

```java
// Spring Boot — WebSocket avec STOMP + SockJS fallback
@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {
    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        registry.addEndpoint("/ws").setAllowedOrigins("*").withSockJS();
    }
    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {
        registry.enableSimpleBroker("/topic", "/queue");
        registry.setApplicationDestinationPrefixes("/app");
    }
}
```

| Transport | Use case | Avantage |
|-----------|----------|----------|
| **WebSocket + STOMP** | Chat, collaboration | Bidirectionnel, sous-protocole structure |
| **SSE (Server-Sent Events)** | Notifications, feeds | Simple, reconnexion auto, HTTP standard |
| **Polling (fallback)** | Compatibilite legacy | Universel, pas de proxy issues |

Sources : Spring WebSocket docs — SockJS+STOMP reference implementation (niv. 3), IETF RFC 6455 — WebSocket protocol (niv. 1), MDN — Server-Sent Events specification (niv. 3), SWEBOK v4 — event-driven architecture patterns (niv. 1)
