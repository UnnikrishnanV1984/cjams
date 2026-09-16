/*
   Issue Description: CDM-37475

   https://cw.cjams.mdthink.maryland.gov/#/pages/case-worker/58e3b3ac-1dba-4924-ae44-e9abdfd08735/3168600/dsds-action/sc-placements/list
   
   Category/ Module  :  
   Root cause: Removing incorrect living arrangement as user entered incorrect living arrangement for 2/21/24.
   Fix provided: Data fix has provided to remove the living arrangement record as requested.
   Pull request# for code fix: 
   Reason why no related code fix: 

   -- placementid: "c32fa613-9045-4347-948c-2bfbc85bbd3e"
*/

-- Backup
select activeflag,updatedby,updatedon from placement where placementid = 'c32fa613-9045-4347-948c-2bfbc85bbd3e' and activeflag = 1;
-- UPDATE cjams.placement
-- SET activeflag=1, updatedby='ef3032b3-2f5a-4b48-8b27-c33cf654abf6', updatedon='2024-02-27 09:20:43.795' where placementid = 'c32fa613-9045-4347-948c-2bfbc85bbd3e' and updatedby = 'CDM-37475';

--Update
UPDATE
    cjams.placement
SET
    activeflag = 0,
    updatedby = 'CDM-37475',
    updatedon = now()
WHERE
    placementid = 'c32fa613-9045-4347-948c-2bfbc85bbd3e'
    and activeflag = 1;


-- Backup
select activeflag,updatedby,updatedon from placementrevision WHERE placementid = 'c32fa613-9045-4347-948c-2bfbc85bbd3e' and activeflag = 1;
-- UPDATE cjams.placementrevision
-- SET activeflag=1, updatedby='ef3032b3-2f5a-4b48-8b27-c33cf654abf6', updatedon='2024-02-27 09:20:43.795'  WHERE placementid = 'c32fa613-9045-4347-948c-2bfbc85bbd3e' and updatedby = 'CDM-37475';

--Update
UPDATE
    cjams.placementrevision
SET
    activeflag = 0,
    updatedby = 'CDM-37475',
    updatedon = now()
WHERE
    placementid = 'c32fa613-9045-4347-948c-2bfbc85bbd3e'
    and activeflag = 1;


-- Backup
select activeflag,updatedby,updatedon from livingarrangement WHERE placementid = 'c32fa613-9045-4347-948c-2bfbc85bbd3e' and activeflag = 1;
-- UPDATE cjams.livingarrangement
-- SET activeflag=1, updatedby='ef3032b3-2f5a-4b48-8b27-c33cf654abf6', updatedon='2024-02-27 09:20:43.795'  WHERE placementid = 'c32fa613-9045-4347-948c-2bfbc85bbd3e' and updatedby = 'CDM-37475';

--Update
UPDATE
    cjams.livingarrangement
SET
    activeflag = 0,
    updatedby = 'CDM-37475',
    updatedon = now()
WHERE
    placementid = 'c32fa613-9045-4347-948c-2bfbc85bbd3e'
    and activeflag = 1;


-- Backup
select activeflag,updatedby,updatedon from routing where objectid='c32fa613-9045-4347-948c-2bfbc85bbd3e' and activeflag = 1;
-- UPDATE cjams.routing
-- SET activeflag=1, updatedby='ef3032b3-2f5a-4b48-8b27-c33cf654abf6', updatedon='2024-02-27 09:20:43.795' where objectid='c32fa613-9045-4347-948c-2bfbc85bbd3e' and updatedby = 'CDM-37475';
-- UPDATE cjams.routing
-- SET activeflag=1, updatedby='ef3032b3-2f5a-4b48-8b27-c33cf654abf6', updatedon='2024-02-27 09:20:43.795' where objectid='c32fa613-9045-4347-948c-2bfbc85bbd3e' and updatedby = 'CDM-37475';

--Update
UPDATE
    cjams.routing
SET
    activeflag = 0,
    updatedby = 'CDM-37475',
    updatedon = now()
where
    objectid = 'c32fa613-9045-4347-948c-2bfbc85bbd3e'
    and activeflag = 1;