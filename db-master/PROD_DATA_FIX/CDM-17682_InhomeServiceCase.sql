/* Issue Description:CDM-17682 In home service case issue
   Category/ Module  : Person Program Assignment
   Root cause: Multiple cases for child, and entered in wrong case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 

*/
 

select * FROM personprogramarea ppa 		   
	WHERE ppa.personid = '69afa274-9006-4c79-ac41-a278f508acb3' AND ppa.activeflag =1 and ppa.sourcetype = 'CW'
and personprogramid in ('47ad9327-d333-42c8-8066-64fb658db866', '856afb53-dfd2-4005-81c1-15c641322226');

update personprogramarea ppa
set ppa.enddate = '2021-09-29 00:00:00', ppa.updatedon =now(), ppa.updatedby = 'CDM-17682'
WHERE ppa.personid = '69afa274-9006-4c79-ac41-a278f508acb3' AND ppa.activeflag =1 and ppa.sourcetype = 'CW'
and ppa.personprogramid in ('47ad9327-d333-42c8-8066-64fb658db866', '856afb53-dfd2-4005-81c1-15c641322226');

--update this table to display end date in history lines
select * from auditlog where logtypekey = 'PRGMAREA' and logid in ('990c798a-ad54-448a-8dab-bde07ce49312','deec6f37-84bb-433f-9e9b-db8c91616239');

update auditlog 
set metadata = '{"personprogramid":"47ad9327-d333-42c8-8066-64fb658db866","personid":"69afa274-9006-4c79-ac41-a278f508acb3","startdate":"2021-08-12T00:00:00","enddate":"2021-09-29T00:00:00","insertedon":"2021-08-12T13:29:54.294518","insertedby":"ba51d587-d94f-4b54-8225-78af2eab1214","updatedon":"2021-08-12T13:29:54.294518","updatedby":"ba51d587-d94f-4b54-8225-78af2eab1214","activeflag":1,"datavalidflag":null,"clientmergeid":null,"endreasonkey":null,"ifpsatriskflag":null,"old_id":null,"programkey":"CPS","subprogramkey":"IR","objecttypekey":"servicerequest","objectid":"67d61368-e535-4f37-9996-48773f21382f","entityid":"211020131555","alternateid":3982892,"datatransferflag":"A","datasentdate":null,"etl_userid":null,"etl_load_date":null,"sourcetype":"CW"}',
updatedon =now(), updatedby = 'CDM-17682'
where logid = '990c798a-ad54-448a-8dab-bde07ce49312';

update auditlog 
set metadata = '{"personprogramid":"856afb53-dfd2-4005-81c1-15c641322226","personid":"69afa274-9006-4c79-ac41-a278f508acb3","startdate":"2021-04-26T00:00:00","enddate":"2021-09-29T00:00:00","insertedon":"2021-04-26T15:15:44.440252","insertedby":"ba51d587-d94f-4b54-8225-78af2eab1214","updatedon":"2021-04-26T15:15:44.440252","updatedby":"ba51d587-d94f-4b54-8225-78af2eab1214","activeflag":1,"datavalidflag":null,"clientmergeid":null,"endreasonkey":null,"ifpsatriskflag":null,"old_id":null,"programkey":"CPS","subprogramkey":"AR","objecttypekey":"servicerequest","objectid":"3e600fbd-ba73-4ef3-853c-ce8619d2d06b","entityid":"202101160104417","alternateid":3807241,"datatransferflag":"A","datasentdate":null,"etl_userid":null,"etl_load_date":null,"sourcetype":"CW"}',
updatedon =now(), updatedby = 'CDM-17682'
where logid = 'deec6f37-84bb-433f-9e9b-db8c91616239';