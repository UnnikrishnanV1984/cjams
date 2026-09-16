/*
 Issue Description:CDM-18964
 Category/ Module: Placements
 Root cause: getplacementbyservicecase
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
  
update cjams.placement 
set activeflag = 0, updatedby = 'CDM-18964', updatedon = now()  
 where placementid = '58c6a11b-70b3-4033-9143-0148a90ac23b';

update cjams.placementrevision 
set activeflag = 0, updatedby = 'CDM-18964', updatedon = now()    
 where placementid = '58c6a11b-70b3-4033-9143-0148a90ac23b';
 
 