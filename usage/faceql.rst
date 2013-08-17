FaceQL
===========


Face gives an easy way to query the database with the some QueryBuilders (for instance the SelectBuilder).

This builder is helpful for all basic operations, but it is limited by the api and some cases may not be covered by the QueryBuilder.

That's why Face provides an SQL-like language to query you database like if you were using SQL.


Introduction
------------------

FaceQL is really similar to SQL. The major part of the query is just basic SQL. But when you write a FaceQL query,
the FaceQL parser needs to know what is the base model used for the query.

Also FaceQL still uses the one-face-centralized model,
then instead of using table names and column names you will use element names to name the columns and tables.

For instance the following queries are similar :

.. code-block:: php

    <?php

    $sql = "SELECT * FROM tree WHERE tree.age>:age";

    $queryBuilder = Tree::faceQueryBuilder()->where("~age>:age");

    $faceQL = "SELECT::* FROM::Tree WHERE ~age>:age";




The main difference is that the first one (``$sql``) is not understandable and not processable by the face hydrater.


The main advantage of FaceQL versus the QueryBuilder is that FaceQL offers 100% flexibility and it covers most of the common operations

Example of a more complex FaceQL query :

.. code-block:: php

    <?php

    $sql =
       "SELECT * FROM tree "
      ."JOIN lemon ON lemon.tree_id = tree.id "
      ."WHERE lemon.mature = 1"
      ."GROUP BY lemon.id "
      ."HAVING count(lemon.id) > 5";

    $faceQL =
       "SELECT::* FROM::Tree "
      ."JOIN::lemons "
      ."WHERE ~lemons.mature = 1"
      ."GROUP BY ~lemons.id "
      ."HAVING count(~lemons.id) > 5";


Using the parser
----------------------

Obviously you have to pass your FaceQL query through a parser.

This parser will return a QueryString object that is executable exactly like a query built from the SelectBuilder :

.. code-block:: php

    <?php

    $fql=\Face\Sql\Query\FaceQL::parse(

        "SELECT::* FROM::Tree ".
        "JOIN::lemons ".
        "WHERE ~id=:id"

    )->bindValue("id",1,PDO::PARAM_INT);


    $trees = Face\ORM::execute($fql, $pdo);

    foreach($trees as $tree){
        // ... do some stuffs
    }



UPDATE DELETE INSERT
----------------------


Right now FaceQL is being tested, a kind of alpha test.

Update delete and insert will be provided in a very few times.