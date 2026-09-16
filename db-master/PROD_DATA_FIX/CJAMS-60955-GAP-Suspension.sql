/*
Issue Description:CJAMS-60955 GAP suspension
Category/Module: GAP Suspension 
Root cause: 3234847:GAP subsidy suspension cannot be approved due to the previously approved post date GAP Suspension in the system.
            Code fix has already been done for this issue as the part of CDM-44449 .This will be available in the next minor release.
            We need to provide temporary data fix so that user can approve the latest suspension.
Steps to be followed for this Data fix:
1. Developer will provide a data fix to remove the already approved suspension so that the latest suspension can be approved.
2. Once the data fix is deployed in prod the user will not be able to see the old approved Suspension.
3. Post the approval of the suspension we will do a data fix again to bring back the old approved suspension.
Fix provided: Data fix has been done remove the old approval record for the approval flow to work as expected.
Post the approval from user please re-open this ticket to bring back the old approved records to active state.
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: CDM-44449
Reason why no related code fix: N/A
*/

-- Bringing back all these three records post the approval of GAP suspension.

update gapsuspension
set activeflag = 1,
    updatedby = 'CJAMS-60955',
    updatedon = now()
where gapsuspensionid = '016dd785-1e28-4e3a-a724-202f328d337b'
and   gapid = '7ac5422c-085e-47c0-942a-25e5ed124d8c'      
and activeflag = 0;

update gapsuspensionrevision
set activeflag = 1,
    updatedby = 'CJAMS-60955',
    updatedon = now()
where suspensionid = '016dd785-1e28-4e3a-a724-202f328d337b'
and   gapsuspensionrevisionid = 'c1571c79-ad5a-4404-b231-6d3b7abd935f'      
and activeflag = 0; 

update routing
set activeflag = 1,
    updatedby = 'CJAMS-60955',
    updatedon = now()
where objectid = '016dd785-1e28-4e3a-a724-202f328d337b'
and routingid = '517479e6-44d6-4f1b-9336-d220e51ea776'
and activeflag = 0;


-- We will bring back all these three records post the approval.
-- Below scripts were executed in stage-3 to deactivate the old approval record and now will will revert this changes.
-- Post the Code fix deployment this type of data fix is not needed.
 
-- update gapsuspension
-- set activeflag = 0,
--     updatedby = 'CJAMS-60955',
--     updatedon = now()
-- where gapsuspensionid = '016dd785-1e28-4e3a-a724-202f328d337b'
-- and   gapid = '7ac5422c-085e-47c0-942a-25e5ed124d8c'      
-- and activeflag = 1;

-- update gapsuspensionrevision
-- set activeflag = 0,
--     updatedby = 'CJAMS-60955',
--     updatedon = now()
-- where suspensionid = '016dd785-1e28-4e3a-a724-202f328d337b'
-- and   gapsuspensionrevisionid = 'c1571c79-ad5a-4404-b231-6d3b7abd935f'      
-- and activeflag = 1; 

-- update routing
-- set activeflag = 0,
--     updatedby = 'CJAMS-60955',
--     updatedon = now()
-- where objectid = '016dd785-1e28-4e3a-a724-202f328d337b'
-- and routingid = '517479e6-44d6-4f1b-9336-d220e51ea776'
-- and activeflag = 1;
