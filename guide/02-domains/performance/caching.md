# Caching

**[RECOMMANDE]** Redis + @Cacheable + CDN static assets | Score GRADE : 5/7

## 3 niveaux de cache

| Niveau | Outil | Usage |
|--------|-------|-------|
| Application | Spring @Cacheable + Redis | Donnees reference, resultats requetes couteuses |
| HTTP | Cache-Control headers, ETags | Reponses API semi-statiques |
| Static | CDN / Vite hashed assets | JS, CSS, images |

## Spring Cache + Redis

```java
@Configuration
@EnableCaching
public class CacheConfig {
    @Bean
    public RedisCacheConfiguration defaultCacheConfig() {
        return RedisCacheConfiguration.defaultCacheConfig()
            .entryTtl(Duration.ofMinutes(30))
            .serializeValuesWith(
                SerializationPair.fromSerializer(new GenericJackson2JsonRedisSerializer()));
    }
}

@Cacheable(value = "exercices", key = "#id")
public ExerciceDto getById(Long id) { ... }

@CacheEvict(value = "exercices", key = "#id")
public void update(Long id, ExerciceUpdateDto dto) { ... }
```

Sources : Spring Cache docs (niv. 3), Redis docs (niv. 3), CNCF — Redis gradue (niv. 2), Twelve-Factor VI (niv. 5), Google SRE Book (niv. 5)
