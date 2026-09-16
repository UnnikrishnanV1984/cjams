CREATE OR REPLACE FUNCTION cjams.fn_personprogramarea_upd()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
if (NEW.programkey::VARCHAR) ='OOH' then


		insert into programupdatetrigger (	sourcesystem,
										statusflag ,
										cjamspid ,
										cisclientid ,
										casenumber ,
										programcasestatus,
										programcode ,
										effectivestartdate,
										effectiveenddate,
										headofhousehold,
										errorcode ,
										insertedon  ,
										insertedby ,
										updatedon ,
										updatedby)
		select  distinct
										'CJ',
										'READY',
										p.cjamspid,
										p.cisclientid,
										sc.servicecasenumber,
										sc.statustypekey,
										'OOH',
										isrcm.removaldate,
										pl.enddatetime,
										 case when isra.isheadofhousehold =true then 'Y' end,
										 0000,
										 now(),
										 'system',
										 now(),
										  'system'				 
										 from 
                  intakeservicerequest isr 
                   join intakeservicerequestactor isra on isra.intakeserviceid = isr.intakeserviceid 
                   join person p on p.personid = isra.personid
                   join personprogramarea ppa on ppa.personid=p.personid and ppa.activeflag=1 
				   join servicecase sc on sc.servicecaseid=isr.servicecaseid and sc.activeflag=1
				   join intakeservreqchildremoval isrcm on isrcm.intakeserviceid = isr.intakeserviceid  and isrcm.activeflag=1
				   join placement pl on pl.servicecaseid = isr.servicecaseid  and pl.activeflag=1 and pl.enddatetime is not null
                  
        where ppa.objectid=isr.servicecaseid::varchar and
                   isra.activeflag=1 and p.activeflag=1 
                  and ppa.programkey='OOH' and 
				  sc.servicecaseid::varchar=NEW.objectid
				  ;
					
                     
elseif (NEW.programkey::VARCHAR) ='GAP' then

       insert into programupdatetrigger (	sourcesystem,
										statusflag ,
										cjamspid ,
										cisclientid ,
										casenumber ,
										programcasestatus,
										programcode ,
										effectivestartdate,
										effectiveenddate,
										headofhousehold,
										errorcode ,
										insertedon  ,
										insertedby ,
										updatedon ,
										updatedby)
			select  distinct
										'CJ',
										'READY',
										p.cjamspid,
										p.cisclientid,
										sc.servicecasenumber,
										sc.statustypekey,
										'GAP',
										isrcm.removaldate,
										ppa.enddate,
										 case when isra.isheadofhousehold =true then 'Y' end,
										 0000,
										 now(),
										 'system',
										 now(),
										  'system'				 
										 from 
                  intakeservicerequest isr 
                   join intakeservicerequestactor isra on isra.intakeserviceid = isr.intakeserviceid 
                   join person p on p.personid = isra.personid
                   join personprogramarea ppa on ppa.personid=p.personid and ppa.activeflag=1 
				   join servicecase sc on sc.servicecaseid=isr.servicecaseid and sc.activeflag=1
				   left join intakeservreqchildremoval isrcm on isrcm.intakeserviceid = isr.intakeserviceid  and isrcm.activeflag=1
				
        where ppa.objectid=isr.servicecaseid::varchar and
                   isra.activeflag=1 and p.activeflag=1 
                  and ppa.programkey='GAP' and 
				  sc.servicecaseid::varchar=NEW.objectid
				  ;
		
                     
elseif (NEW.programkey::VARCHAR) ='AXYS' then

        insert into programupdatetrigger (	sourcesystem,
										statusflag ,
										cjamspid ,
										cisclientid ,
										casenumber ,
										programcasestatus,
										programcode ,
										effectivestartdate,
										effectiveenddate,
										headofhousehold,
										errorcode ,
										insertedon  ,
										insertedby ,
										updatedon ,
										updatedby)
			select  distinct
										'CJ',
										'READY',
										p.cjamspid,
										p.cisclientid,
										sc.servicecasenumber,
										sc.statustypekey,
										'AXYS',
										ppa.startdate,
										ppa.enddate,
										 case when isra.isheadofhousehold =true then 'Y' end,
										 0000,
										 now(),
										 'system',
										 now(),
										  'system'				 
										 from 
                  intakeservicerequest isr 
                   join intakeservicerequestactor isra on isra.intakeserviceid = isr.intakeserviceid 
                   join person p on p.personid = isra.personid
                   join personprogramarea ppa on ppa.personid=p.personid and ppa.activeflag=1 
				   join servicecase sc on sc.servicecaseid=isr.servicecaseid and sc.activeflag=1
				
        where ppa.objectid=isr.servicecaseid::varchar and
                   isra.activeflag=1 and p.activeflag=1 
                  and ppa.programkey='AXYS' and 
				  sc.servicecaseid::varchar=NEW.objectid;	
				  
elseif (NEW.programkey::VARCHAR) ='IL' then

        insert into programupdatetrigger (	sourcesystem,
										statusflag ,
										cjamspid ,
										cisclientid ,
										casenumber ,
										programcasestatus,
										programcode ,
										effectivestartdate,
										effectiveenddate,
										headofhousehold,
										errorcode ,
										insertedon  ,
										insertedby ,
										updatedon ,
										updatedby)
			select  distinct
										'CJ',
										'READY',
										p.cjamspid,
										p.cisclientid,
										sc.servicecasenumber,
										sc.statustypekey,
										'IL',
										ppa.startdate,
										ppa.enddate,
										 case when isra.isheadofhousehold =true then 'Y' end,
										 0000,
										 now(),
										 'system',
										 now(),
										  'system'				 
										 from 
                  intakeservicerequest isr 
                   join intakeservicerequestactor isra on isra.intakeserviceid = isr.intakeserviceid 
                   join person p on p.personid = isra.personid
                   join personprogramarea ppa on ppa.personid=p.personid and ppa.activeflag=1 
				   join servicecase sc on sc.servicecaseid=isr.servicecaseid and sc.activeflag=1
				
        where ppa.objectid=isr.servicecaseid::varchar and
                   isra.activeflag=1 and p.activeflag=1 
                  and ppa.programkey='IL'  and f_age(dob::date,now()::date)>=18 and f_age(dob::date,now()::date)<=21
				  and  sc.servicecaseid::varchar=NEW.objectid;

elseif (NEW.programkey::VARCHAR) ='IHSFP' then

        insert into programupdatetrigger (	sourcesystem,
										statusflag ,
										cjamspid ,
										cisclientid ,
										casenumber ,
										programcasestatus,
										programcode ,
										effectivestartdate,
										effectiveenddate,
										headofhousehold,
										errorcode ,
										insertedon  ,
										insertedby ,
										updatedon ,
										updatedby)
			select  distinct
										'CJ',
										'READY',
										p.cjamspid,
										p.cisclientid,
										sc.servicecasenumber,
										sc.statustypekey,
										'IHSFP'||'/'||ppa.subprogramkey,
										(select  max(insertedon) from routing
                                         where eventcode='SRVC' and fromroleid='CWSP' and toroleid='CWCW' and activeflag=1 and objectid=sc.servicecaseid::varchar),
										ppa.enddate,
										 case when isra.isheadofhousehold =true then 'Y' end,
										 0000,
										 now(),
										 'system',
										 now(),
										  'system'				 
										 from 
                  intakeservicerequest isr 
                   join intakeservicerequestactor isra on isra.intakeserviceid = isr.intakeserviceid 
                   join person p on p.personid = isra.personid
                   join personprogramarea ppa on ppa.personid=p.personid and ppa.activeflag=1 
				   join servicecase sc on sc.servicecaseid=isr.servicecaseid and sc.activeflag=1
				
        where ppa.objectid=isr.servicecaseid::varchar and
                   isra.activeflag=1 and p.activeflag=1 
                  and ppa.programkey='IHSFP' and ppa.subprogramkey in ('CS','IFPS','SFCI')  
                   and  sc.servicecaseid::varchar=NEW.objectid;				  


  insert into programupdatetrigger (	sourcesystem,
										statusflag ,
										cjamspid ,
										cisclientid ,
										casenumber ,
										programcasestatus,
										programcode ,
										effectivestartdate,
										effectiveenddate,
										headofhousehold,
										errorcode ,
										insertedon  ,
										insertedby ,
										updatedon ,
										updatedby)
			select  distinct
										'CJ',
										'READY',
										p.cjamspid,
										p.cisclientid,
										sc.servicecasenumber,
										sc.statustypekey,
										'IHSFP'||'/'||ppa.subprogramkey,
										(select  max(insertedon) from routing
                                         where eventcode='SRVC' and fromroleid='CWSP' and toroleid='CWCW' and activeflag=1 and objectid=sc.servicecaseid::varchar),
										ppa.enddate,
										 case when isra.isheadofhousehold =true then 'Y' end,
										 0000,
										 now(),
										 'system',
										 now(),
										  'system'				 
										 from 
                  intakeservicerequest isr 
                   join intakeservicerequestactor isra on isra.intakeserviceid = isr.intakeserviceid 
                   join person p on p.personid = isra.personid
                   join personprogramarea ppa on ppa.personid=p.personid and ppa.activeflag=1 
				   join servicecase sc on sc.servicecaseid=isr.servicecaseid and sc.activeflag=1
				
        where ppa.objectid=isr.servicecaseid::varchar and
                   isra.activeflag=1 and p.activeflag=1 
                  and ppa.programkey='IHSFP' and ppa.subprogramkey in ('IFC','SFCC')  
				  and  sc.servicecaseid::varchar=NEW.objectid;
				  
				  
elseif (NEW.programkey::VARCHAR) ='ADP' then

        insert into programupdatetrigger (	sourcesystem,
										statusflag ,
										cjamspid ,
										cisclientid ,
										casenumber ,
										programcasestatus,
										programcode ,
										effectivestartdate,
										effectiveenddate,
										headofhousehold,
										errorcode ,
										insertedon  ,
										insertedby ,
										updatedon ,
										updatedby)
			select  distinct
										'CJ',
										'READY',
										p.cjamspid,
										p.cisclientid,
										sc.servicecasenumber,
										sc.statustypekey,
										'ADP',
										(select  max(insertedon) from routing
                                         where eventcode='ADPC' and fromroleid='CWCW' and toroleid='CWSP' and activeflag=1 and objectid=sc.servicecaseid::varchar),
										(select  max(insertedon) from routing
                                         where eventcode='SRVC' and fromroleid='CWSP' and toroleid='CWCW' and activeflag=1 and objectid=sc.servicecaseid::varchar),
										 case when isra.isheadofhousehold =true then 'Y' end,
										 0000,
										 now(),
										 'system',
										 now(),
										  'system'				 
										 from 
                  intakeservicerequest isr 
                   join intakeservicerequestactor isra on isra.intakeserviceid = isr.intakeserviceid 
                   join person p on p.personid = isra.personid
                   join personprogramarea ppa on ppa.personid=p.personid and ppa.activeflag=1 
				   join servicecase sc on sc.servicecaseid=isr.servicecaseid and sc.activeflag=1
				--  join adoptioncase ac on ac.servicecaseid=sc.servicecaseid and ac.activeflag=1

        where ppa.objectid=sc.servicecaseid::varchar and
                   isra.activeflag=1 and p.activeflag=1 
                  and ppa.programkey='ADP' 
                   and  sc.servicecaseid::varchar=NEW.objectid;			
				  
END IF;-- 


return new;
END;

$function$
;

 drop trigger IF EXISTS  tr_personprogramarea_update on  cjams.personprogramarea ;

 create trigger tr_personprogramarea_update 
 after insert on cjams.personprogramarea 
 for each row execute procedure fn_personprogramarea_upd();