/*
   Issue Description: CDM-30783
   Category/ Module  : Agreement Rate
   Root cause: As requested by user
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE cjams.adoptioncaserevision
SET activeflag=0,
    updatedby='CDM-30783',
    updatedon=now()
WHERE adoptionagreementrateid='28e71449-aa49-4a1d-b112-83ff7eaaee67'
  AND adoptionagreementid='bbff113e-7906-4226-ad74-7f781c5abd02';