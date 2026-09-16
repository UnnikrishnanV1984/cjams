    /*
    Issue Description: Need data fix to create a placement with placement
    structure as Formal Kinship Care with the detail information as mentioned below.
    Category/Module: Support
    Root cause: user could not abe to create a Backdate Formal Kinship placement
    Fix provided: DB queries to create new record in routing  and placement table.
    Data/Code fix ticket#: CJAMS-58220
    Regression Impacts: N/A
    Is Code fix Required?: No
    Code fix ticket#: N/A
    Reason why no related code fix: Support
    Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
    Backup before update/ delete:Query:
    delete from routing where insertedby = 'CJAMS-58220';
    delete from placementrevision where insertedby = 'CJAMS-58220';
    delete from livingarrangement where placementid = (select placementid from placement where insertedby = 'CJAMS-58220');
    delete from placement where insertedby = 'CJAMS-58220';
    */
    insert into placement 
    (placementid,intakeservicerequestactorid ,startdatetime ,enddatetime ,remarks,activeflag,effectivedate,insertedby,insertedon,
    updatedby,updatedon,exitreasontypekey,exittypekey,isvoided,intakeservreqchildremovalid,servicecaseid,placementtypekey,
    service_id,starttime,endtime,providersentdate,responseacceptedkey,isssaapproval,altproviderid,personid,overunderflag,
    paymentheaderid,ratestructureid,voidapprovaldate,primaryrelationship,leastrestrictiveplacement,ischildplacedoutside,
    placementluggage,plluggagepurchased)
    values
    (gen_random_uuid(),'bfbd168d-a210-4b19-a835-009f93101d83','2023-11-15 10:00:00.000',null,'Hailey has been placed with her grandmother',1,'2023-11-15 10:00:00.000','CJAMS-58220',
    now(),'CJAMS-58220',now(),null,null,null,'8ebe8fb2-84e1-4731-a054-d4cc0ff0b04c','7473f837-534c-4545-9367-5f9f6a393a5d','PRPL','8','10:00:00.000',null,'2023-11-15 10:00:00.000',
    '4612',0,6176481,'546c03f6-df98-482e-bd49-b63ee8975adf','0',null,null,null,'Relative',
    'Hailey is with family', true, true, false);

    insert into placementrevision
    (placementrevisionid, placementid, transactiondate, entrydate, entrytime, approvalstatustypkey, isoriginal, insertedby, insertedon,
    updatedby, updatedon, activeflag, isvoided, requestedby, requesteddate, approvedby, approvaldate, approveddate, status,
    leastrestrictiveplacement, placementluggage, plluggagepurchased)
    values
    (gen_random_uuid(), (select placementid from placement where insertedby  = 'CJAMS-58220'), '2023-11-15 10:00:00.000',
    '2023-11-15 10:00:00.000','10:00', '3045', 0, 'CJAMS-58220', now(), 'CJAMS-58220', now(),0,0,
    '46362254-be94-41ce-8b6b-4898090e8027', now(), 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e', null, now(),
    'Approved', 'Hailey is with family', true, false);

    insert into placementrevision
    (placementrevisionid, placementid, transactiondate, entrydate, entrytime, approvalstatustypkey, isoriginal, insertedby, insertedon,
    updatedby, updatedon, activeflag, isvoided, requestedby, requesteddate, approvedby, approvaldate, approveddate, status,
    leastrestrictiveplacement, placementluggage, plluggagepurchased)
    values
    (gen_random_uuid(), (select placementid from placement where insertedby  = 'CJAMS-58220'), '2023-11-15 10:00:00.000',
    '2023-11-15 10:00:00.000','10:00', '3047', 1, 'CJAMS-58220', now(), 'CJAMS-58220', now(),1, 0,
    '46362254-be94-41ce-8b6b-4898090e8027', now(), 'e27575b1-783d-4b26-a4ad-0985f8ad4d6e',now(),
    '2023-11-15 10:00:00.000', 'Approved', 'Hailey is with family', true, false);

    insert into routing 
    (routingid,eventcode,fromsecurityusersid,tosecurityusersid,teamid,fromroleid,toroleid,objectid,routingstatustypeid,
    activeflag,insertedby,insertedon,updatedby ,updatedon ,isreviewrequest,remarks,routeddescription,servicerequestnumber,objecttypekey)
    values
    (gen_random_uuid(),'PLTR','46362254-be94-41ce-8b6b-4898090e8027','e27575b1-783d-4b26-a4ad-0985f8ad4d6e',
    '0856e3c0-82d7-48fd-b8e2-7c8f6823e0bc','CWCW',	'CWSP',(select placementid   from placement where insertedby  = 'CJAMS-58220')
    ,15,0,'CJAMS-58220',now(),'CJAMS-58220',now(),true,null,null,'221030018822','Servicecase');

    insert into routing 
    (routingid,eventcode,fromsecurityusersid,tosecurityusersid,teamid,fromroleid,toroleid,objectid,routingstatustypeid,
    activeflag,insertedby,insertedon,updatedby ,updatedon ,isreviewrequest,remarks,routeddescription,servicerequestnumber,objecttypekey)
    values
    (gen_random_uuid(),'PLTR','46362254-be94-41ce-8b6b-4898090e8027','e27575b1-783d-4b26-a4ad-0985f8ad4d6e',
    '0856e3c0-82d7-48fd-b8e2-7c8f6823e0bc','CWCW', 'CWSP',(select placementid   from placement where insertedby  = 'CJAMS-58220')
    ,16,1,'CJAMS-58220',now(),'CJAMS-58220',now(),true,null,null,'221030018822','Servicecase');


    insert into routing 
    (routingid,eventcode,fromsecurityusersid,tosecurityusersid,teamid,fromroleid,toroleid,objectid,routingstatustypeid,
    activeflag,insertedby,insertedon,updatedby ,updatedon ,isreviewrequest,remarks,routeddescription,servicerequestnumber,objecttypekey)
    values
    (gen_random_uuid(),'PLTR','46362254-be94-41ce-8b6b-4898090e8027',null,
    null,'CWCW', 'IVESV',(select placementid   from placement where insertedby  = 'CJAMS-58220')
    ,16,1,'CJAMS-58220',now(),'CJAMS-58220',now(),true,null,null,'221030018822','Servicecase');

    update prov.tb_provider set vacancy_no = vacancy_no - 1, update_ts = now(), update_user_id = 'CJAMS-58220'
    where provider_id = 6176481 and delete_sw = 'N' ;