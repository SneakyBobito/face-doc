Generation
==========


The hardest work when you use an orm is to prepare the models that you have already prepared in your database.

Obviously Face is not an exception, you will have to map your model classes with your database.

We are aware that it is a repetitive work and that's why we try to place a constant effort to avoid this work.

Face offers a tool that will generate your models for you : `Face-Embryo`_.

Embryo will generate  some .php files for you and Face will use these php files.
In this way you can start a project even if you have only weak knowledge of Face. You just will have to know how to write queries.

We really encourage you to use Embryo. It will help to start your projects faster.

.. note::

    For the moment Embryo only works with MySQL.

.. note::

    If you are using one of our framework skeleton, then embryo is already embeded into the skeleton and ready for use. Please refer to the appropriate section

Install Embryo
--------------

Embryo installation was tested under Debian. You will maybe have to adapt the following to your distro/OS.

Before generating your models you need a mysql database ready for use. It means that all your table are ready and primary keys and foreign keys are present.

Now download or clone the sources from github : https://github.com/laemons/face-embryo at the root of your project

.. code-block:: php

    cd root/of/your/project
    git clone https://github.com/laemons/face-embryo.git
    // cd to ./face-embryo and run install composer dependancies


Generate from database
----------------------

Embryo is ready, now create a directory named `models` at the root of your application.

You can to generate your models :

.. code-block:: php

    php face-embryo/embryo models -u user -p password -d database generate -o ./models


Replace "user" by the username of the database, "password" by the password of the user and "database" by the name of the database where your tables live.
The option "-o"  means "output", it is the where the models will be generated.

After typing this command you will be prompted for "yes or no" everytime a foreign key exists.
In fact embryo needs to know if your relation is hasOne or hasMany. Most of time it will be "hasMany", if so just leave blank and press enter or else write "n" and press enter.

You can check all has been generating : look at the `models` dir, you should have some .php files matching with your db tables.

.. note::

    support for namespaces is under construction



.. _Face-Embryo: https://github.com/laemons/face-embryo
