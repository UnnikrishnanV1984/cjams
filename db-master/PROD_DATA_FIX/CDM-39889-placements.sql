/*
  Issue Description:  CDM-39889
   Category/ Module:  Placement
   Root cause: PLacement showing with end dated
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

UPDATE cjams.placement
SET enddatetime=null,exittypekey=null, endtime=null, updatedby = 'CDM-39889', updatedon = now()
WHERE placementid='bf3eb8d9-4844-4c7d-ac06-a4a001e2de9d' and personid = '9a08e7bd-8590-44c1-a14c-38b2eb6c7a51';

UPDATE cjams.placementrevision
SET exitdate=null,exittime=null, enddate = null, endtime=null, exittypekey = null, updatedby = 'CDM-39889', updatedon = now()
WHERE placementid='bf3eb8d9-4844-4c7d-ac06-a4a001e2de9d';