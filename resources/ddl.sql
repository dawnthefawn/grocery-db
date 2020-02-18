CREATE TYPE "Locations" AS ENUM (
  'Fridge',
  'Pantry'
);

CREATE TYPE "used_reasons" AS ENUM (
  'Went_bad',
  'Used_up',
  'Spilled'
);

CREATE TABLE "Items" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "base_name" varchar UNIQUE NOT NULL,
  "default_unit" varchar NOT NULL DEFAULT 'count'
);

CREATE TABLE "Types" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "type_name" varchar NOT NULL
);

CREATE TABLE "Groceries" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "item_id" int NOT NULL,
  "type_id" int,
  "quantity" float NOT NULL DEFAULT 1,
  "unit" varchar NOT NULL DEFAULT 'count',
  "price" money,
  "QPU" float,
  "shelf_life_days" int
);

CREATE TABLE "Quisines" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "quisine" varchar NOT NULL,
  "parent1_id" int,
  "parent2_id" int
);

CREATE TABLE "Steps" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "direction" varchar NOT NULL
);

CREATE TABLE "Recipes" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "dish_name" varchar NOT NULL,
  "quisine_id" int NOT NULL,
  "estimated_time" datetime
);

CREATE TABLE "Ingredients" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "recipe_id" int NOT NULL,
  "grocery_id" int NOT NULL,
  "quantity" float NOT NULL,
  "unit" varchar DEFAULT 'count'
);

CREATE TABLE "Recipe_Steps" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "recipe_id" int NOT NULL,
  "step_id" int NOT NULL,
  "order" int NOT NULL DEFAULT 1
);

CREATE TABLE "Users" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "name" varchar NOT NULL
);

CREATE TABLE "User_Recipes" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "user_id" int NOT NULL,
  "recipe_id" int NOT NULL,
  "rating" bool NOT NULL
);

CREATE TABLE "User_Quisines" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "user_id" int NOT NULL,
  "quisine_id" int NOT NULL,
  "rating" bool NOT NULL
);

CREATE TABLE "Dietary_Restrictions" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "name" varchar NOT NULL
);

CREATE TABLE "Dietary_Restrictions_Groceries" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "dietary_restriction_id" int NOT NULL,
  "grocery_id" int NOT NULL
);

CREATE TABLE "Users_Dietary_Restrictions" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "dietary_restriction_id" int NOT NULL,
  "user_id" int NOT NULL,
  "restriction_type" int NOT NULL
);

CREATE TABLE "Power_Queries" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "user_id" int,
  "query" varchar NOT NULL
);

CREATE TABLE "substitutions" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "ingredient_id" int NOT NULL,
  "substituted_ingredient_id" int NOT NULL
);

CREATE TABLE "Notes" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "note" varchar NOT NULL,
  "user_id" int
);

CREATE TABLE "Recipes_Notes" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "recipe_id" int NOT NULL,
  "note_id" int NOT NULL
);

CREATE TABLE "Inventory" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "location" Locations,
  "purchase_date" datetime NOT NULL,
  "grocery_id" int NOT NULL,
  "purchased_by_user_id" int NOT NULL,
  "quantity_remaining" float,
  "purchase_price" money,
  "used_date" datetime,
  "used_reason" used_reasons
);

CREATE TABLE "Cooking_history" (
  "id" SERIAL PRIMARY KEY NOT NULL,
  "meal_date" datetime NOT NULL,
  "recipe_id" int NOT NULL,
  "user_id" int NOT NULL
);

ALTER TABLE "Groceries" ADD FOREIGN KEY ("item_id") REFERENCES "Items" ("id");

ALTER TABLE "Groceries" ADD FOREIGN KEY ("type_id") REFERENCES "Types" ("id");

ALTER TABLE "Quisines" ADD FOREIGN KEY ("parent1_id") REFERENCES "Quisines" ("id");

ALTER TABLE "Quisines" ADD FOREIGN KEY ("parent2_id") REFERENCES "Quisines" ("id");

ALTER TABLE "Recipes" ADD FOREIGN KEY ("quisine_id") REFERENCES "Quisines" ("id");

ALTER TABLE "Ingredients" ADD FOREIGN KEY ("recipe_id") REFERENCES "Recipes" ("id");

ALTER TABLE "Ingredients" ADD FOREIGN KEY ("grocery_id") REFERENCES "Groceries" ("id");

ALTER TABLE "Recipe_Steps" ADD FOREIGN KEY ("recipe_id") REFERENCES "Recipes" ("id");

ALTER TABLE "Recipe_Steps" ADD FOREIGN KEY ("step_id") REFERENCES "Steps" ("id");

ALTER TABLE "User_Recipes" ADD FOREIGN KEY ("user_id") REFERENCES "Users" ("id");

ALTER TABLE "User_Recipes" ADD FOREIGN KEY ("recipe_id") REFERENCES "Recipes" ("id");

ALTER TABLE "User_Quisines" ADD FOREIGN KEY ("user_id") REFERENCES "Users" ("id");

ALTER TABLE "User_Quisines" ADD FOREIGN KEY ("quisine_id") REFERENCES "Quisines" ("id");

ALTER TABLE "Dietary_Restrictions_Groceries" ADD FOREIGN KEY ("dietary_restriction_id") REFERENCES "Dietary_Restrictions" ("id");

ALTER TABLE "Dietary_Restrictions_Groceries" ADD FOREIGN KEY ("grocery_id") REFERENCES "Groceries" ("id");

ALTER TABLE "Users_Dietary_Restrictions" ADD FOREIGN KEY ("dietary_restriction_id") REFERENCES "Dietary_Restrictions" ("id");

ALTER TABLE "Users_Dietary_Restrictions" ADD FOREIGN KEY ("user_id") REFERENCES "Users" ("id");

ALTER TABLE "Power_Queries" ADD FOREIGN KEY ("user_id") REFERENCES "Users" ("id");

ALTER TABLE "substitutions" ADD FOREIGN KEY ("ingredient_id") REFERENCES "Ingredients" ("id");

ALTER TABLE "substitutions" ADD FOREIGN KEY ("substituted_ingredient_id") REFERENCES "Ingredients" ("id");

ALTER TABLE "Notes" ADD FOREIGN KEY ("user_id") REFERENCES "Users" ("id");

ALTER TABLE "Recipes_Notes" ADD FOREIGN KEY ("recipe_id") REFERENCES "Recipes" ("id");

ALTER TABLE "Recipes_Notes" ADD FOREIGN KEY ("note_id") REFERENCES "Notes" ("id");

ALTER TABLE "Inventory" ADD FOREIGN KEY ("grocery_id") REFERENCES "Groceries" ("id");

ALTER TABLE "Inventory" ADD FOREIGN KEY ("purchased_by_user_id") REFERENCES "Users" ("id");

ALTER TABLE "Cooking_history" ADD FOREIGN KEY ("recipe_id") REFERENCES "Recipes" ("id");

ALTER TABLE "Cooking_history" ADD FOREIGN KEY ("user_id") REFERENCES "Users" ("id");
