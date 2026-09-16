/*
   Issue Description:CDM-33782
   Category/ Module  : intake 
   Root cause: due to securityuserid issue 
  Fix Provided; Did data fix and removed that record
*/

update cjams.intaketransfers set activeflag =0, updatedby ='CDM-33782', updatedon = now()
where intaketransferid ='476f137f-7130-4f5c-9855-17ab785bd153';