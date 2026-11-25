ER

forward-engg
    create database

Insert Statement
parent-child (contact - learner)
    is FK nullable?
    yes - then learner can be inserted without contact
    no - then learner cannot be inserted without contact

Delete

parent - child (user - learner)
if parent is deleted, does child record stay?
yes - ON delete SET NULL
no - ON delete cascade
in our ex, if user record is deleted, learner record is also deleted

Update

If u want to update foreign record , don't assign new foreign key,
update the same record.