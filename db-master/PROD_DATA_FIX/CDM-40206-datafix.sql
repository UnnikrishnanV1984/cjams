/*
   Issue Description: CDM-40206
   Category/ Module  : Placement
   Root cause: user requested to remove the living arrangement
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

update placement 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-40206' 
where placementid ='97c8a889-2854-4045-9aa2-4ff789d0e4cf' and activeflag = 1;

update placementrevision
set activeflag = 0, updatedon = now(), updatedby = 'CDM-40206'
where placementid ='97c8a889-2854-4045-9aa2-4ff789d0e4cf' and activeflag = 1;

update livingarrangement 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-40206' 
where placementid ='97c8a889-2854-4045-9aa2-4ff789d0e4cf' and activeflag = 1;

update routing 
set activeflag = 0, updatedon = now(), updatedby = 'CDM-40206'
where objectid  ='97c8a889-2854-4045-9aa2-4ff789d0e4cf' and activeflag = 1;