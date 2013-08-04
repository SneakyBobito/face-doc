Face Core
===========


Although Face offers a generator to start your project, it is important to know how it works.

This section describes the core of face.


Class and Database
------------------

Face is an ORM, it will map **Classes** with Database **Tables** and **Properties** with **Columns**

Begin the example with the following : in the database we have a Table named ``tree``. This table has 2 columns :
``id`` and ``age`` ; ``id`` is an auto-incremented primary key and ``age`` is simply the age of the tree.

We will have the following class matching to the db :

.. code-block:: php

    <?php

    class Tree{

        protected $id;
        protected $age;

        /** getters and setters

        ....

        */


    }


This is a basic Tree class with properties matching to the database table.




Map your class with a table
..........................

Now we have to say to face how to read the tree class : we will use the  trait ``EntityFaceTrait``, it's what allows face to access to your class.
When you use this trait you will have to implement the method ``__getEntityFace``.

See :

.. code-block:: php

    <?php

    class Tree{

        protected $id;
        protected $age;

        /** getters and setters

        ....

        */

        // we use the EntityFaceTrait, this is the core of face.
        // without it Face cant work with the class.
        use \Face\Traits\EntityFaceTrait;

        // when we sue the EntityFaceTrait, then we have to implement the following function
        public static function __getEntityFace() {
            return [
                "sqlTable"=>"tree"
            ];
        }

    }


The method ``__getEntityFace`` returns an array. This array explains your class. As you can see we specified the ``sqlTable`` key with the value ``tree``.
It means that the class is mapped with the table ``tree``.



Map your properties with columns
................................

At this point, face knows that the tree class is mapped with the sql table "tree". But any column is mapped. Indeed we also have to explain which columns are mapped.

The following example shows how you can map the **properties** with the **columns** :

.. code-block:: php

    <?php

    class Tree{

        protected $id;
        protected $age;

        /** getters and setters

        ....

        */

        use \Face\Traits\EntityFaceTrait;

        public static function __getEntityFace() {
            return [
                "sqlTable"=>"tree",

                // Add some elements
                "elements"=>[

                    "id"=>[
                        "property"=>"id",
                        "sql"=>[
                            "columnName" => "id",
                            "isPrimary"  => true,
                        ],
                    ],

                    "age"=>[
                        "property"=>"age",
                        "sql"=>[
                            "columnName" => "age",
                        ],
                    ]

                ]
            ];
        }

    }

We added the key ``elements``. This is the list of mapped properties.

There is a few things to know :

 * Each element must match with a valid property of the class.
 * Each element has an unique name. The name is specified by the key.
 * Element name has the same naming conventions that variable : it must begins by a ``letter`` or an ``underscore`` and con contain only ``letters`` ``number`` or ``underscore``



Foreign Keys
............

Obviously Face supports very well your foreign keys. That's why he was born.

Let's use a second table in the database : the ``lemon`` table. This table has 2 columns : ``id`` and ``tree_id``. Then we will have the following class :


.. code-block:: php

    <?php

    class Lemon {

        protected $id;
        protected $tree_id;

        /** getters and setters

        ....

        */

        use \Face\Traits\EntityFaceTrait;

        public static function __getEntityFace() {
            return [

                "sqlTable"=>"lemon",

                "elements"=>[
                    "id"=>[
                        "sql"=>[
                            "isPrimary" => true
                        ]
                    ],
                    "tree_id",
            ];
        }

    }

In this example you may have noticed that we only specified  ``tree_id`` as a string.

It is not a mistake, this is convenient shortcuts.

It is identical to :

.. code-block:: php

                "id"=>[
                    "property"=>"id",
                    "sql"=>[
                        "columnName" => "id",
                        "isPrimary" => true,
                    ]
                ],
                "tree_id"[
                    "property"=>"tree_id",
                    "sql"=>[
                        "columnName" => "tree_id",
                    ]
                ],

Now we have a Lemon class and we want to link it to the Tree.

We have to modify the ``Tree`` class by adding a ``Lemons`` property then we will say to face how to join the classes together.


.. code-block:: php


    <?php

    class Tree{

        protected $id;
        protected $age;

        // ADD A LEMON PROPERTY
        // (contrary to the usual naming convention, we capitalize the first letter of a variable, that's allow us to now if it is a SQL column or a related entity )
        protected $Lemons;

        /** getters and setters

        ....

        */

        use \Face\Traits\EntityFaceTrait;

        public static function __getEntityFace() {
            return [

                "sqlTable"=>"tree",

                "elements"=>[

                    "id"=>[
                        "sql"=>[
                            "isPrimary"  => true,
                        ],
                    ],

                    "age",

                    // ADD THE LEMON ELEMENT
                    "Lemons"=>[
                        "class"     => "Lemon",
                        "relation"  => "hasMany",
                        "sql"   =>[
                            "join"  => ["id"=>"tree_id"]
                        ]
                    ]

                ]
            ];
        }

    }

We added the ``Lemons`` elements. We can explain the array by the following :

`"Tree has an element named 'Lemons' that references to the class 'Lemon'. Each tree hasMany 'Lemons' and we can join them with the columns 'tree.id' and 'lemon.tree_id'."`

We can retrieve trees from the db and join Lemons.


Reverse the relation : find the parent from a child !
.....................................................

From now we can do the following :

.. code-block:: php


    <?php

    // we have retrieved some trees from the db. $tree is one of them
    $tree->getLemons();


But in some cases it is really convenient to be able to do this :

.. code-block:: php


    <?php

    // we would like to get the parent from the child
    $lemon->getTree();


This is real advantage of Face, it can do relations in both directions  in the same time : Parent => Children & Child => Parent



How to proceed ?

It's very straightforward ! We have to add a ``Tree`` property on the ``Lemon`` (like we did add the lemons property on the tree):


.. code-block:: php

    <?php

    class Lemon {

        protected $id;
        protected $tree_id;

        // ADD THE PROPERTY
        protected $Tree

        /** getters and setters

        ....

        */

        use \Face\Traits\EntityFaceTrait;

        public static function __getEntityFace() {
            return [

                "sqlTable"=>"lemon",

                "elements"=>[
                    "id"=>[
                        "sql"=>[
                            "isPrimary" => true
                        ]
                    ],

                    "tree_id",

                    // ADD THE TREE ELEMENT
                    "Tree"=>[
                        "class"     => "Tree",
                        "relatedBy" => "Lemons",
                        "relation"  => "belongsTo",
                        "sql"   => [
                            "join"  => ["tree_id"=>"id"]
                        ]
                    ]
            ];
        }

    }

We just added a ``Tree`` element.

You can see a new key named ``related``. This key allows to explain which element of the other class refers to this one.

In this example we are saying that the class ``Lemon`` is referenced on the class ``Tree`` by the element named "Lemons".

Now we are going to do the same on the tree. Add the key ``relatedBy`` on the ``Lemons`` element :


.. code-block:: php

    "Lemons"=>[
        "class"     => "Lemon",
        "relatedBy" => "Tree",
        "relation"  => "hasMany",
        "sql"   =>[
            "join"  => ["id"=>"tree_id"]
        ]
    ]