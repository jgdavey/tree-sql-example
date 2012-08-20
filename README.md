Example application for demonstrating tree SQL

Setup
-----

Obviously:

    bundle

Edit `config/database.yml` as needed, then run:

    rake db:setup db:test:prepare

Keep the tests passing:

    rake

SQL
---

After seeding the database, you can run `rails dbconsole` and play with
the following query:

```SQL
WITH RECURSIVE search_tree(id, name, path) AS (
  SELECT id, name, ARRAY[id]
  FROM categories
  WHERE parent_id IS NULL
UNION ALL
  SELECT categories.id, categories.name, path || categories.id
  FROM search_tree
  JOIN categories ON categories.parent_id=search_tree.id
  WHERE NOT categories.id = ANY(path)
)
SELECT * FROM search_tree
ORDER BY path
;
```
