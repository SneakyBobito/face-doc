Overview
========


Face doesn't try to be a full featured ORM, he just does try to be good at gettig datas from the DB as you asked him to do.
He is enough modular and configurable that's why he will adapt to your code, even if your code changes in the future.


The few lines bellow explain Face's philosophy


What Face does
--------------

* Face is an ORM for Sql using php5.4 traits
* Face is adaptable to your code
* Face is easy to configure and easy to use
* Face retrieves your data from the DB, including join and other sql statements
* Face provides an user friendly API for sql that is easy to use and easy to understand 
* Face also understands SQL like called FaceQL
* Face care about performances and tries to save the number of queries sent to the DB Server
* Face also tries to save resources and to be fast
* Face let you know what it does with a profiler


What Face does not
------------------

* Face doesn't try to overload your code
* Face doesn't want to be a full featured ORM that will do all the job
* Face doesn't want to be a little ORM that only set datas into a StdClass
* Face doesn't doesn't try to put all your data and models under a complex layer of functionnalities
* Face doesn't want load more datas that you asked him to do
* Face doesn't try to hide you what he does
* Face doesn't need you to put public properies, you may use protected or private properties


Why Face ?
----------

Yes, there are already a bunch of ORM for PHP, but only a few are really ok.
Some of them try to do all the job, they become complexe and are pain for the resources consumption, also they are complexe to set up and they are definitively not adapted for little projects.
Some others are minimalistics, they are not greed for the server but they are so minimalistic that you still have a lot of work to do.
Also most of them want you to extend your entity classes with their one classes. 


 Face : neither a full and complexe AllInOne ORM, nor a minimalistic ORM that can't join data together. Face uses faces to understand how your entities are done, faces are implemented by one and only one trait that once configured will give a face to your entity. Once your object has a face, Face ORM will be able to play with it. Your object wont have to inherit any EntityBaseClass.

