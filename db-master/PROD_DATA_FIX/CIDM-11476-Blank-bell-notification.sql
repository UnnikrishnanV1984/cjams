/*
Issue: CIDM-11476 Blank Bell Notification
       Bulk data fix needed to delete empty user notifications from the DB that has been generated without any subject and body but just the person name in the subject.
Category/Module: User Notifications
Root cause: This is happening due to the old code that calls updateservicecase SP during the child removal entry and exit flow. This is inserting duplication record into routing and also into usernotification tables.
Supervisor is receiving a blank bell notification with no case information.
This is Fixed as the part of CDM-44821
Fix provided: Bulk data fix needed to delete empty user notifications from the DB that has been generated without any subject and body but just the person name in the subject.
Data/Code fix ticket#: CIDM-11476
Regression Impacts: N/A
Is Code fix Required?: YES
Code fix ticket#: CDM-44821
Reason why no related code fix: N/A
*/



update usernotificationmap set activeflag = 0, updatedby  = 'CIDM-11476', updatedon  = now()
where usernotificationid in 
(
    select usernotificationid 
        from usernotification as u 
    where activeflag  = 1
        and teamtypekey  = 'CW'
        and body 
            in (
            select lastname || ', ' || firstname 
                from userprofile u 
            where activeflag  = 1
            ) 
) ;


update usernotification set activeflag = 0 , updatedby  = 'CIDM-11476', updatedon  = now()
where activeflag  = 1
    and teamtypekey  = 'CW'
    and body 
        in (
        select lastname || ', ' || firstname 
            from userprofile u 
        where activeflag  = 1
        ) ;