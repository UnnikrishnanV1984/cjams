/*
   Issue Description: CDM-27479
   Category/ Module  :  Removing placement end date
   Root cause: user requested to remove the date to proceed with GAP 
   Pull request# for code fix: 7304
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   need to do data fix.
*/

select intakeservreqchildremovalid, alternateid, startdatetime, starttime, enddatetime, enddatetime, 
    exitreasontypekey, exittypekey, isvoided, updatedby, updatedon 
from cjams.placement 
where placementid = 'dcd5e286-b022-4a50-82e5-2d62517039b2'
    and activeflag = 1 ;
    
update cjams.placement  
set enddatetime = null, 
    endtime = null, 
    exitreasontypekey = null,
    exittypekey = null,
    updatedon = now(), 
    updatedby = 'CDM-27479'
where placementid = 'dcd5e286-b022-4a50-82e5-2d62517039b2'
    and activeflag  = 1 ;

update cjams.placementrevision  
set exitdate = null, 
    exittime = null, 
    exitreasontypkey = null,
    exittypekey = null,
    updatedon = now(), 
    updatedby = 'CDM-27479'
where placementid = 'dcd5e286-b022-4a50-82e5-2d62517039b2'
    and ( exitdate is not null or exittime is not null ) ;
    
update cjams.intakeservreqchildremoval
set exitdate = Null,
    returndate = Null,
    returntime = Null,
    removalexitreason = NULL,
    updatedby = 'CDM-27479',
    updatedon = now()
where removalid = 252482
    and activeflag = 1 ;