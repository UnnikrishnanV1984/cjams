insert into referencevalues(ref_key,referencetypeid,value_text,
description,teamtypekey,activeflag,displayorder,insertedby,insertedon) values('ARSM',46,'ARSummary','ARSummary','CW',1,4,'Admin',now())

insert into routingconfig(eventcode,targetrolekey,activeflag,insertedby,insertedon,updatedby,updatedon,
effectivedate,expirationdate,targetteamtypekey,sourcerolekey,old_id,routingstatustypekey) values
('ARSM','CWSP',1,'admin',now(),'admin',now(),now(),null,null,'CWCW',null,null)

insert into routingconfig(eventcode,targetrolekey,activeflag,insertedby,insertedon,updatedby,updatedon,
effectivedate,expirationdate,targetteamtypekey,sourcerolekey,old_id,routingstatustypekey) values
('ARSM','CWCW',1,'admin',now(),'admin',now(),now(),null,null,'CWSP',null,null)