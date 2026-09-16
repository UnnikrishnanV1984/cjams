-- CDM-24152 - Program Assignment
/*
-- Issue Description: 
   The CPS AR Case is having wrong CPS-IR program assignment and CPS-AR program assignment start dates are wrong
 
-- CPS-AR: 221020237310 - 842ffa01-c58b-4c1e-898b-711edae2d4a2

-- Category/ Module: Child Removals (Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Client ID: 200938760 (Seth Pease) - acef7968-fb5a-439d-a754-71d86b5ed0dd
-- Delete
-- CPS-IR 2022-07-25 To Current - 639e0b0a-705f-4a88-9527-0ed20542aaab
select entityid, startdate, enddate, programkey, subprogramkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '639e0b0a-705f-4a88-9527-0ed20542aaab' 
	and activeflag = 1 ;

update personprogramarea
set startdate = enddate,
	activeflag = 0, 
	updatedby = 'CDM-24152',
	updatedon = now() 		
where personprogramid = '639e0b0a-705f-4a88-9527-0ed20542aaab' 
	and activeflag = 1 ;

-- Update Start Date as 2022-07-25 and Entityid = 221020237310
-- CPS-AR 2022-08-02 To Current - 72b41c44-a96b-4db3-b992-136dab2ca042
select entityid, startdate, enddate, programkey, subprogramkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '72b41c44-a96b-4db3-b992-136dab2ca042'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2022-07-25 14:43:27',
	entityid = '221020237310', 
	updatedby = 'CDM-24152',
	updatedon = now() 		
where personprogramid = '72b41c44-a96b-4db3-b992-136dab2ca042' 
	and activeflag = 1 ;


-- Client ID: 200938780 (Ellowyn Pease) - 35d4068f-47c9-431f-9ac2-2aa5f81de0f0
-- Update Start Date as 2022-07-25 and Entityid = 221020237310
-- CPS- AR	2022-08-02 1To Current - 98081140-9a14-4aca-9257-185c960291e1
select entityid, startdate, enddate, programkey, subprogramkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = '98081140-9a14-4aca-9257-185c960291e1'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2022-07-25 14:57:25',
	entityid = '221020237310', 
	updatedby = 'CDM-24152',
	updatedon = now() 		
where personprogramid = '98081140-9a14-4aca-9257-185c960291e1' 
	and activeflag = 1 ;

-- Client ID: 200938765 (Marianne Pease) - a634e5a9-ec85-41ad-ba08-046c3058e5c7
-- Update Start Date as 2022-07-25 and Entityid = 221020237310
-- CPS-AR - 2022-08-02 To Current - dbaaf49d-4e6b-4fae-9d41-cc2b93bfbee5	
select entityid, startdate, enddate, programkey, subprogramkey, updatedby, updatedon, activeflag, objectid, objecttypekey 
	from personprogramarea 
where personprogramid = 'dbaaf49d-4e6b-4fae-9d41-cc2b93bfbee5'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2022-07-25 14:39:21',
	entityid = '221020237310', 
	updatedby = 'CDM-24152',
	updatedon = now() 		
where personprogramid = 'dbaaf49d-4e6b-4fae-9d41-cc2b93bfbee5' 
	and activeflag = 1 ;
