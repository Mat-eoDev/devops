db = db.getSiblingDB("blog_db");

db.createCollection("posts", {
  validator: {
    $jsonSchema: {
      bsonType: "object",
      required: ["titre", "auteur", "vues"],
      properties: {
        titre: {
          bsonType: "string",
          description: "doit etre un string"
        },
        auteur: {
          bsonType: "string",
          description: "doit etre un string"
        },
        vues: {
          bsonType: "int",
          minimum: 0,
          description: "doit etre un entier"
        }
      }
    }
  },
  validationAction: "error"
});

db.posts.insertMany([
  {
    titre: "Pourquoi mass effect 2 est le meilleur jeu",
    auteur: "Mateo",
    vues: NumberInt(42)
  },
  {
    titre: "Top 5 des distros linux pour debuter",
    auteur: "Mateo",
    vues: NumberInt(156)
  },
  {
    titre: "Mon setup homelab avec un vieux pc",
    auteur: "Karim",
    vues: NumberInt(89)
  },
  {
    titre: "Tuto wireguard en 10 min",
    auteur: "Enzo",
    vues: NumberInt(230)
  },
  {
    titre: "Les certifs en cyber ca vaut le coup ou pas",
    auteur: "Karim",
    vues: NumberInt(315)
  }
]);

print("init ok - 5 articles inseres");
