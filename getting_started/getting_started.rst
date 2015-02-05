Getting Started
===============

This getting started will learn you the very basics of Face.
It's nothing more than a starting point that will show you how the library works by the examples.


Requirements
------------

This guide requires you to have the minimum knowledge of a relational database. In addition you should prepare :

 - A mysql database (for the early development, Face only supports mysql, however more are planned thanks to the flexibility of PDO)
 - A set of sql schema ready in the database : :download:`schema.sql <../resources/getting_started_schema.sql>`.
 - The Face library ready for use (check the installation guide)

First Step : Get data from the database
---------------------------------------

The schema required for this guide is the following :

.. image:: ../resources/getting_started_schema.png

In this first step we are going to query some articles from the database

Create a model for articles
^^^^^^^^^^^^^^^^^^^^^^^^^^^

We will create our first class aimed to act as a model for the article table :

.. code-block:: php

   <php

   class Article {

     use \Face\Traits\EntityFaceTrait;

     protected $id;

     protected $title;
     protected $articleContent;
     protected $authorId;


     public function getId(){
      return $this->id;
     }

     public function getTitle(){
      return $this->title;
     }

     public function getArticleContent(){
      return $this->articleContent;
     }

     public function getAuthorId(){
      return $this->authorId;
     }

     public function setId($id){
      $this->id = $id;
     }

     public function getTitle($title){
      $this->title = $title;
     }

     public function getArticleContent($articleContent){
      $this->articleContent = $articleContent;
     }

     public function getAuthorId($authorId){
      $this->authorId = $authorId;
     }
   }


.. note::

   Actually the model is basically an exact representation of the database with one property per database column
   Writing them may be very annoying. We will see latter how to generate them automatically


.. note::

   As you can see we use the trait ``\Face\Traits\EntityFaceTrait``. This trait is the base of every Face entity.
   It brings custom and ready to use methods to deal with the library.


Now our model is ready, but we still need to map it with the database. Let's create the model definition.

Create a file named for instance ``models.php`` with the following content :



.. code-block:: php

 <?php

  return [
     [
        "name"=> "article",
        "class"=> "Artcle",
        "sqlTable"=>"article",

        "elements"=>[

            "id"=>[
                "identifier"=>true,
                "sql"=>[
                    "columnName"=> "id",
                    "isPrimary" => true
                ]
            ],

            "title"=>[
                "identifier"=>true,
                "sql"=>[
                    "columnName"=> "title"
                ]
            ],

            "articleContent"=>[
                "identifier"=>true,
                "sql"=>[
                    "columnName"=> "articleContent"
                ]
            ],

            "authorId"=>[
                "identifier"=>true,
                "sql"=>[
                    "columnName"=> "authorId"
                ]
            ],

        ]
     ]
  ];


We are done ! Our model and our mapping are ready. We are ready to deal with the database now.


Query Articles from the database
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. note::

   In this section we will use the model class we just created. This class needs to be available in your application.
   If you are not familiar with autoloading, please take a look at the dedicated guide : loading models [TODO LINK]


