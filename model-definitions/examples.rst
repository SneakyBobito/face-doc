Examples of models
==================

.. note::

    For readability purposes all following classes have public properties, but you are free to use protected properties
    with getter/setter

A table with no references
--------------------------

The following example defines a entity named ``user`` linked to the database table ``user`` and to the php class ``User``

.. multi-code-block::

    .. code-block:: user&_Definition:php

        [

            "name"     => "user",
            "sqlTable" => "user",
            "class"    => "User",

            "elements" => [

                "id" => [
                    "identifier" => true,
                    "sql"  => [
                        "columnName" => "id",
                        "isPrimary"  => "true",
                    ]
                ],

                "firstname" => [
                    "sql"  => [
                        "columnName" => "firstname"
                    ]
                ],

                "lastname" => [
                    "sql"  => [
                        "columnName" => "lastname",
                    ]
                ],

                "email" => [
                    "sql"  => [
                        "columnName" => "email",
                    ]
                ],

            ]

        ]


    .. code-block:: User&_Class:php

        Class User {

            public $id;
            public $firstname;
            public $lastname;
            public $email;

        }

    .. code-block:: Query&_Example:php

        // find all the users
        $query = User::selectBuilder();

        $users = Face\ORM::execute($query, $pdo);

        foreach($users as $user){

            echo $user->id . ' ' . $user->firstname . ' ' . $user->lastname;

        }


Add a has many reference
------------------------

We will add some ``articles`` to the ``user``

.. multi-code-block::

    .. code-block:: user&_Definition:php

        [

            "name"     => "user",
            "sqlTable" => "user",
            "class"    => "User",

            "elements" => [

                "id" => [
                    "identifier" => true,
                    "sql"  => [
                        "columnName" => "id",
                        "isPrimary"  => "true"
                    ]
                ],
                "firstname" => [
                    "sql"  => [
                        "columnName" => "firstname"
                    ]
                ],
                "lastname" => [
                    "sql"  => [
                        "columnName" => "lastname",
                    ]
                ],
                "email" => [
                    "sql"  => [
                        "columnName" => "email",
                    ]
                ],


                "Articles" => [

                    "entity"    => "article",
                    "relation"  => "hasMany",
                    "relatedBy" => "user",

                    "sql" => [
                        "join"  => ["id"=>"user_id"],
                    ]

                ],

            ]

        ]



    .. code-block:: article&_Definition:php

        [

            "name"     => "article",
            "sqlTable" => "article",
            "class"    => "Article",

            "elements" => [

                "id" => [
                    "identifier" => true,
                    "sql"  => [
                        "columnName" => "id",
                        "isPrimary"  => "true"
                    ]
                ],
                "title" => [
                    "sql"  => [
                        "columnName" => "title"
                    ]
                ],
                "content" => [
                    "sql"  => [
                        "columnName" => "content",
                    ]
                ],

                "User" => [

                    "entity"    => "user",
                    "relation"  => "belongsTo",
                    "relatedBy" => "Articles",

                    "sql" => [
                        "join"  => ["user_id"=>"id"],
                    ]

                ],

            ]

        ]



    .. code-block:: User&_Class:php

        Class User {

            public $id;
            public $firstname;
            public $lastname;
            public $email;

            public $Articles;

        }

    .. code-block:: Article&_Class:php

        Class Article {

            public $id;
            public $title;
            public $content;

            public $User;

        }


    .. code-block:: Query&_Example:php

        // find all the users and their articles
        $query = User::selectBuilder()
            ->join("Articles");

        $users = Face\ORM::execute($query, $pdo);

        foreach($users as $user){

            echo $user->id . ' ' . $user->firstname . ' ' . $user->lastname;

            foreach($user->Articles as $article){
                echo $article->id . ' ' . $article->title;
            }

        }


Add a has many to many reference
--------------------------------

Some ``users`` have liked an ``article``

.. multi-code-block::

    .. code-block:: user&_Definition:php

        [

            "name"     => "user",
            "sqlTable" => "user",
            "class"    => "User",

            "elements" => [

                "id" => [
                    "identifier" => true,
                    "sql"  => [
                        "columnName" => "id",
                        "isPrimary"  => "true"
                    ]
                ],
                "firstname" => [
                    "sql"  => [
                        "columnName" => "firstname"
                    ]
                ],
                "lastname" => [
                    "sql"  => [
                        "columnName" => "lastname",
                    ]
                ],
                "email" => [
                    "sql"  => [
                        "columnName" => "email",
                    ]
                ],


                "Articles" => [

                    "entity"    => "article",
                    "relation"  => "hasMany",
                    "relatedBy" => "user",

                    "sql" => [
                        "join"  => ["id"=>"user_id"],
                    ]

                ],

                "LikedArticles" => [

                    "entity"   => "article",
                    "relation" => "hasManyThrough",
                    "relatedBy"=> "Likers",

                    "sql" => [

                        "join" => ["id" => "user_id"],
                        "throughTable" => "user_likes_article"

                    ]
                ]

            ]

        ]



    .. code-block:: article&_Definition:php

        [

            "name"     => "article",
            "sqlTable" => "article",
            "class"    => "Article",

            "elements" => [

                "id" => [
                    "identifier" => true,
                    "sql"  => [
                        "columnName" => "id",
                        "isPrimary"  => "true"
                    ]
                ],
                "title" => [
                    "sql"  => [
                        "columnName" => "title"
                    ]
                ],
                "content" => [
                    "sql"  => [
                        "columnName" => "content",
                    ]
                ],

                "User" => [

                    "entity"    => "user",
                    "relation"  => "belongsTo",
                    "relatedBy" => "Articles",

                    "sql" => [
                        "join"  => ["user_id"=>"id"],
                    ]

                ],

                "Likers" => [

                    "entity"   => "user",
                    "relation" => "hasManyThrough",
                    "relatedBy"=> "LikedArticles",

                    "sql" => [

                        "join" => ["id" => "article_id"],
                        "throughTable" => "user_likes_article"

                    ]
                ]

            ]

        ]



    .. code-block:: User&_Class:php

        Class User {

            public $id;
            public $firstname;
            public $lastname;
            public $email;

            public $Articles;

            public $LikedArticles;

            public function likes($articleId){

                foreach ($this->LikedArticles as $likedArticle) {
                    if ($likedArticle->id == $articleId) {
                        return true;
                    }
                }

                return false;

            }

        }

    .. code-block:: Article&_Class:php

        Class Article {

            public $id;
            public $title;
            public $content;

            public $User;

        }


    .. code-block:: Query&_Example:php

        // Check if the user likes a given article
        $query = User::selectBuilder()
            ->join("Articles")
            ->where("user.id=:user_id");

        $users = Face\ORM::execute($query, $pdo);

        $user = $users[0];

        echo $user->likes(2) ? "He likes" : "He doesn't like";
