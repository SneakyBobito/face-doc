Overview
========


Face doesn't try to be a full featured ORM, he just does try to be good at gettig datas from the DB as you asked him to do.
He is enough modular and configurable that's why he will adapt to your code, even if your code changes in the future.


Here is a quick overview of what face is


What Face does
--------------

* Face is an ORM using php5.4 traits for Sql databases
* Face is adaptable to your code
* Face is easy to configure and easy to use
* Face retrieves your data from the DB, and more than ever with join statements
* Face gives an easy to write and easy to understand sql query API
* Face tryes to save the number of queries sent to the DB Server
* Face let you know what it does


What Face does not
------------------

* Face doesn't try to overload your code
* Face doesn't want to be a full featured ORM that will do all the job
* Face doesn't want to be a little ORM that only puts data in a StdClass
* Face doesn't doesn't try to persist all your data under a complex layer of functionnalities
* Face doesn't load more datas that you asked him to do
* Face doesn't try to hide you what he does
* Face doesn't need you to put public properies, you may use protected or private properties


Why Face ?
----------

Yes, there are already a bunch of ORM for PHP, but only a few are really ok.
Some of them try to do all the job, they become complexe and are pain for the resources consumption, also they are complexe to set up and they are definitively not adapted for little projects.
Some others are minimalistics, they are not greed for the server but they are so minimalistic that you still have a lot of work to do.
Also most of them want you to extend your entity classes with their one classes. 


And there is Face, neither a full and complexe AllInOne ORM, nor a minimalistic ORM that can't join data together. Face uses faces to understand how your entities are done, faces are implemented by one and only one trait that once configured will give a face to your entity. Once your object has a face, Face ORM will be able to play with it. Your object wont have to inherit any EntityBaseClass or to use painfull programing nightmare Annotations.

