--CDM-7034

UPDATE personprogramarea SET objecttypekey = 'servicerequest' , entityid = 'CW2956320',
updatedby = 'CDM-7034', updatedon = now() WHERE programkey = 'CPS' AND personprogramid = '052b648a-09a9-4104-b970-2647bda2d1d7';

--CDM-3636 - change team name
UPDATE team SET teamname = 'Family Preservation Unit 1', updatedby = 'CDM-3636', updatedon = now() WHERE 
countyid = '1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b' AND teamname = 'Family Preservation 1' AND activeflag =1;

UPDATE team SET teamname = 'Family Preservation Unit 2', updatedby = 'CDM-3636', updatedon = now() WHERE 
countyid = '1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b' AND teamname = 'Family Preservation 2' AND activeflag =1;

UPDATE team SET teamname = 'Family Preservation Unit 3', updatedby = 'CDM-3636', updatedon = now() WHERE 
countyid = '1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b' AND teamname = 'Family Preservation 3' AND activeflag =1;

UPDATE team SET teamname = 'Family Preservation Unit 4', updatedby = 'CDM-3636', updatedon = now() WHERE 
countyid = '1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b' AND teamname = 'Family Preservation 4' AND activeflag =1;

--CDM-7198 - remove case from to be assigned
UPDATE routing SET activeflag = 0, updatedby = 'CDM-7198', updatedon = now() WHERE routingid = '39e794d9-821e-4ca8-a9d5-dcb996152327';

--'CDM-7190 child removal end date
UPDATE intakeservreqchildremoval SET removalexitreason= 'REUNIF', exitdate = '2020-09-03 09:00:00', updatedon = now(), 
updatedby = 'CDM-7190' WHERE removalid =  197018 AND activeflag = 1;
-- living arrangement update
UPDATE livingarrangement SET livingenddate = '2020-09-03 00:00:00', updatedby = 'CDM-7190', updatedon = now() 
WHERE livingid = '5ad0f8e3-15e2-458d-af13-2fbcbfaa1123';

--CDM-7190 - Placement end date
UPDATE placement pl SET pl.enddatetime = '2020-09-03 09:00:00', pl.updatedon = now(), 
pl.updatedby = 'CDM-7190' FROM person p WHERE p.personid = pl.personid
AND pl.activeflag = 1 AND enddatetime IS NULL AND pl.placementtypekey = 'LA'
AND p.cjamspid IN (4324535);

--UPDATE livingarrangement SET livingenddate = '2020-09-03 09:00:00', updatedon = now(), updatedby = 'CDM-7190' 
--WHERE activeflag = 1 AND placementid = 'cb238e38-63bd-4005-aa73-68fb173f884c' AND livingenddate IS NULL;

--CDM-7533 living situation reference values
UPDATE referencevalues SET teamtypekey = 'CW', updatedon = now(), updatedby = 'CDM-7533' WHERE referencetypeid = 19 AND teamtypekey = 'AS';

--CDM - 4002 person record is updated
UPDATE intakeservicerequestactor SET isprimary = FALSE, updatedby = 'CDM-4002', 
updatedon = now() WHERE intakeservicerequestactorid = 'eb7cc214-aa1a-451e-b898-90cd87825d4a' AND activeflag = 1 ;

UPDATE personrole SET ishouseholdmember = 1, updatedby = 'CDM-4002', updatedon = now() WHERE personroleid = '21a2337f-9ee8-4c6a-9e83-adf3f91507c7' ;

--CDM-7351 - person program assignment

UPDATE personprogramarea SET personid = '00765531-f370-4848-88de-0cf6cfe79c55', updatedon = now() WHERE 
personprogramid = '99de133f-abb5-412a-ab4e-d5fddc8d4634' AND activeflag = 1; 

-- CDM-7117 - YTP approval record is inactivate
UPDATE routing SET activeflag = 0, updatedby = 'CDM-7117', updatedon = now() WHERE  
routingid = '5b02266e-9d0a-4842-918c-92b9a6924d09' AND activeflag = 1 ;

--CDM-6943 - person assignment records are inactivated if case is inactivated -- expected update count 170 
UPDATE personprogramarea ppa SET activeflag = 0, updatedby = 'CDM-6943', 
updatedon = now() FROM intakeservicerequest ir 
WHERE ppa.entityid = ir.servicerequestnumber 
AND ppa.activeflag = 1 AND enddate IS NULL AND ir.activeflag = 0 AND ir.etl_userid IS NULL ;

