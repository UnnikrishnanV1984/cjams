/*
   Issue Description: CIDM-4009
   Category/ Module  : Placement 
   Root cause: 
   Pull request# for code fix: 4380
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update placementrevision p set entrytime = null, updatedon = now(), updatedby = 'CIDM-4009' where entrytime = 'Invalid date';

update placementrevision p set exittime = null, updatedon = now(), updatedby =  'CIDM-4009'  where exittime = 'Invalid date';

update placement p set starttime = null, updatedon = now(), updatedby =  'CIDM-4009'  where starttime = 'Invalid date';

update placement p set endtime = null, updatedon = now(), updatedby =  'CIDM-4009'  where endtime = 'Invalid date';