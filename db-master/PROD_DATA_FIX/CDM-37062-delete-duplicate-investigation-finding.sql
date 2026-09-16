/*
-- Issue Description: CDM-37062 Delete duplicate investigation finding
-- Category/ Module: Inverstigation Finding  (Case Management) 
-- Root cause: User error
---Fix Provided: Datafix has been provided for deleting the duplicate investigation Findings
*/

--Backup
-- investigationallegationid in ('24ac9163-5baf-4d77-981d-8f11c9ba6d27','e50d9734-c61b-4fb7-98d5-07378abd3475')
select * from investigationallegation 
where 
investigationallegationid in ('24ac9163-5baf-4d77-981d-8f11c9ba6d27') and activeflag=1;
-- UPDATE cjams.investigationallegation
-- SET activeflag=1, updatedby='3951e1ee-e5bf-42a6-a01e-c68b9238a722', updatedon='2024-01-31 09:32:40.000' 
-- WHERE investigationallegationid='24ac9163-5baf-4d77-981d-8f11c9ba6d27'::uuid;

--Update
update
   investigationallegation
set
   activeflag = 0,
   updatedby = 'CDM-37062',
   updatedon = now()
where
   investigationallegationid='24ac9163-5baf-4d77-981d-8f11c9ba6d27'::uuid  and activeflag=1;

--Backup
select activeflag,updatedby,updatedon from investigationmaltreatment 
where maltreatmentid ='8817a6ca-b03d-4e6d-8766-5fbcead5f953' and activeflag=1;
-- UPDATE cjams.investigationmaltreatment
-- SET activeflag=1, updatedby='3951e1ee-e5bf-42a6-a01e-c68b9238a722', updatedon='2024-01-31 09:32:40.000' 
-- where maltreatmentid ='8817a6ca-b03d-4e6d-8766-5fbcead5f953';

update
   investigationmaltreatment
set
   activeflag = 0,
   updatedby = 'CDM-37062',
   updatedon = now()
where maltreatmentid ='8817a6ca-b03d-4e6d-8766-5fbcead5f953' and activeflag=1;

-- --Backup
-- select activeflag, updatedby, updatedon
-- 	from investigationfinding
-- where investigationallegationid in ('24ac9163-5baf-4d77-981d-8f11c9ba6d27')
-- 	and activeflag = 1 ;

-- --Update
-- update investigationfinding
-- set activeflag = 0,
-- 	updatedon = now(), 
-- 	updatedby = 'CDM-37062'	
-- where investigationallegationid in ('24ac9163-5baf-4d77-981d-8f11c9ba6d27')
-- 	and activeflag = 1 ;

--Backup
select activeflag, updatedby, updatedon from investigationallegationmaltreators
where investigationallegationid in ('24ac9163-5baf-4d77-981d-8f11c9ba6d27')
	and activeflag = 1 ;
	
-- UPDATE cjams.investigationallegationmaltreators
-- SET activeflag=1, updatedby='3951e1ee-e5bf-42a6-a01e-c68b9238a722', updatedon='2024-01-31 09:32:40.000' 
-- where investigationallegationid in ('24ac9163-5baf-4d77-981d-8f11c9ba6d27') and activeflag = 1;

update investigationallegationmaltreators
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-37062'	
where investigationallegationid in ('24ac9163-5baf-4d77-981d-8f11c9ba6d27')
	and activeflag = 1 ;