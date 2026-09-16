/*
Issue Description:CJAMS-59517 3 parents for relations
Category/Module: Relationship
Root cause: Update relationship call was not happening correctly due to code error and it has been resolved as the part of CIDM-10513 to correct the actor relationship.
            Data fix is need to correct the relationship of 4024616 as Biological mother relationship moved from cjamspid 4206221 to 1709651.
Fix provided: Data fix is done to correct the duplicate relationship issue.
Data/Code fix ticket#:CJAMS-59517
Regression Impacts: N/A
Is Code fix Required?: yes
Code fix ticket#: CIDM-10513
Reason why no related code fix: N/A
*/

update actorrelationship
set activeflag = 0,
    updatedby = 'CJAMS-59517',
    updatedon = now()
where person1id=(select personid from person where cjamspid=4206221)
and person2id=(select personid from person where cjamspid=4024616) 
and servicecaseid='1fa6cf9c-4729-4bef-93d6-2ce2256e16df'
and activeflag = 1;