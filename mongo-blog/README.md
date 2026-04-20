# mongo-blog

Image Docker MongoDB pour un blog. La base `blog_db` et la collection `posts` sont creees au lancement.

## Lancer le projet

```
docker build -t mongo-blog:1.0.0 .
docker run -d --name mongo-blog -p 27017:27017 mongo-blog:1.0.0
```

## Healthcheck

```
./check-status.sh mongo-blog
```

## Tester le validateur

```
docker exec mongo-blog mongosh --eval "db.getSiblingDB('blog_db').posts.insertOne({titre: 'Test', auteur: 'Moi', vues: 'coucou'})"
```

Ca doit renvoyer une erreur car vues doit etre un entier.

## Docker Hub

```
docker pull matlepirate/blog-hennebellemateo:1.0.0
docker pull matlepirate/hennebellemateo:1.0.0
```
