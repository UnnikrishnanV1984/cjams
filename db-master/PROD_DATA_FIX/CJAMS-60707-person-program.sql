/* 
    Issue Description: CJAMS-60707
   Category/ Module  : Program area
   Root cause: User Request, Person (3356536)DAVID Plank-NEWMAN  was added on 05/23/2025 in the CPS case251023060085 
   and it's not available in the corresponding intake. SSA Approved to change the start date of the CPS Alternative 
   Response program assignment from "7/3/2025" to "5/16/2025" and added the Sub Program Area as "Alternative Response" for the client DAVID Plank-NEWMAN. 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    void the rejected provider placement from backend
*/
update personprogramarea 
set subprogramkey = 'AR',
	startdate = '2025-05-16',
	updatedon = now(),
	updatedby = 'CJAMS-60707'
where personprogramid = '0cf88dd3-35bf-4989-a0aa-c308fb1f5a9e' 
	and personid = '1e3d0e30-1017-4c24-afac-7d322b80fdc3'
	and activeflag =1;

--Update log info for the startdate too.
update auditlog 
set metadata = '{"personprogramid":"0cf88dd3-35bf-4989-a0aa-c308fb1f5a9e","personid":"1e3d0e30-1017-4c24-afac-7d322b80fdc3","startdate":"2025-05-16T00:00:00","enddate":"2025-07-03T20:22:27.793168","insertedon":"2025-07-03T20:12:46","insertedby":"5acd963b-8744-43a4-b27a-af10ce986bc7","updatedon":"2025-07-03T20:22:27.793168","updatedby":"5acd963b-8744-43a4-b27a-af10ce986bc7","activeflag":1,"datavalidflag":null,"clientmergeid":null,"endreasonkey":null,"ifpsatriskflag":0,"old_id":null,"programkey":"CPS","subprogramkey":null,"objecttypekey":"servicerequest","objectid":"9ffd63bf-4327-41ca-bf48-d49790f86e5b","entityid":"251023060085","alternateid":6128194,"datatransferflag":"U","datasentdate":null,"etl_userid":null,"etl_load_date":null,"sourcetype":"CW"}',
updatedon =now(), updatedby = 'CJAMS-60707'
where logid = 'c6f192cf-3c81-4152-9a7f-eeabbb045601';