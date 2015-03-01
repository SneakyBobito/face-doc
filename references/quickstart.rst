Quick Start
===========

Lets see how to use face. The below examples are just quick step to discover Face, they dont explain why or how it works.
TODO : detailled section


For these examples, we need a sql database. You may import the sample .sql file that we made just for you : TODO lemons.sql

Configure Face
--------------

You said configure ? Why ? Face doesn't need any specific configuration. 

It just will work with a PDO object and some entities that you configured for your DB.


Installation
------------

Use composer with the package "face/face": "dev-master"

For detailled informations : TODO : link to installation page



Creating your Entity
--------------------

For this example we are going to play with a Tree object. This tree has an id and an age. That's all.

Look at the Tree entity :

.. code-block:: php

    <?php
    class Tree {

        protected $id;
        protected $age;

        public function getId() {
            return $this->id;
        }

        public function setId($id) {
            $this->id = $id;
        }

        
        use \Face\Traits\EntityFaceTrait;
        
        public static function __getEntityFace() {
            return [
                "elements"=>[
                    "id"=>[
                        "identifier"=>true,
                        "sql"=>[
                            "isPrimary" => true
                        ]
                    ],
                    "age"=>[],
                ]
                
            ];
        }
        
    }


Retrieve the entity from the Database
-------------------------------------

Let's assume we have a mysql database with a table "tree" with 2 columns : "age" and "id" :

.. code-block:: php

    <?php
     
     // remove this line if Tree is loadable by autoloader
    include "Tree.php";

    // create a pdo object that will be able to connect to the database
    // for new commers more informations at : http://fr2.php.net/manual/en/class.pdo.php
    $pdo = new PDO('mysql:host=localhost;dbname=db-test', 'root', 'root');

    // Create a query for Tree
    $fQuery= Face\ORM::Query("Tree");
    // execute the query and get the trees
    $trees=  Face\ORM::execute($fQuery, $pdo)->getInstance("Tree");

    foreach ($trees as $tree){
        echo "tree #".$tree->getId()." - age : ".$tree->getAge()."<br/>" ;

    }

That's all ? Yes that's all, for a simple query like this, you only two lines in addition of the PDO instantiation and the foreach loop that displays datas !



Join elements together
----------------------

A tree is cool, but alone it is sick, dont you prefer a lemon tree ? 

Firstly update the Tree class : add lemons

.. code-block:: php
    
    <?php
    class Tree {

        protected $id;
        protected $age;

        // Add some lemons (dont forget to add them to the face like shown bellow)
        protected $lemons=array();

        public function getId() {
            return $this->id;
        }

        public function getLemons() {
            return $this->lemons;
        }


        
        use \Face\Traits\EntityFaceTrait;
        
        public static function __getEntityFace() {
            return [
                "elements"=>[
                    "id"=>[
                        "identifier"=>true,
                        "sql"=>[
                            "isPrimary" => true
                        ]
                    ],
                    "age"=>[],

                    // Lemons also live in the face
                    "lemons"=>[
                        "type"      => "entity",
                        "class"     => "Lemon",
                        "relation"  => "hasMany",
                        "relatedBy" => "tree",
                        "sql"   =>[
                            "join"  => ["id"=>"tree_id"]
                        ]
                    ],


                ]
                
            ];
        }
        
    }

Now we need to create the Lemon class :

.. code-block:: php

    class Lemon {

        public $id;
        public $tree_id;
     
        public $tree;

        public function getId() {
            return $this->id;
        }

        public function getTree_id() {
            return $this->tree_id;
        }

        public function getTree() {
            return $this->tree;
        }


        use \Face\Traits\EntityFaceTrait;

        public static function __getEntityFace() {
            return [
                "elements"=>[
                    "id"=>[
                        "identifier"=>true,
                        "sql"=>[
                            "isPrimary" => true
                        ]
                    ],
                    "tree_id"=>[],
                    "tree"=>[
                        "type"      => "entity",
                        "class"     =>  "Tree",
                        "relatedBy" => "lemons",
                        "sql"   =>[
                            "join"  => ["tree_id"=>"id"]
                        ]
                    ],
                ]
                
            ];
        }
        
    } 


Query the lemons and the tree together !
Oh and wait, we also only want Trees that have less than 6 years 

.. code-block:: php

    <?php
     
     // remove these 2 lines if Tree and Lemon aro loadable by autoloader
    include "Tree.php";
    include "Lemon.php";

    // create a pdo object that will be able to connect to the database
    $pdo = new PDO('mysql:host=localhost;dbname=db-test', 'root', 'root');

    // Create a query for Tree object
    $fQuery= Face\ORM::Query("Tree");
    // join lemons
    $fQuery->join("lemons")
           ->where("~age < 6");

    // execute the query
    $trees= Face\ORM::execute($fQuery, $pdo)->getInstance("Tree");

    // check the results
    foreach ($trees as $tree){
        echo "tree #".$tree->getId()." - age : ".$tree->getAge()."<br/>" ;

        foreach ($tree->getLemons() as $lemon){
            echo " | lemon #". $lemon->getId()."<br/>" ;
        }

    }

As you see, when your lemon is configured you just have one line to add that joins the lemons and the trees together, and one line to explain the where clause

