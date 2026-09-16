
/*
    Issue description: CDM-40063
    -- Category/Module: Living Arrangement (Case Management)
    -- Root cause: User error/request
    -- Pull request: N/A
    -- Reason why no related fix: N/A
    -- Status of the code fix if already submitted and expected prod fix date: N/A
*/     
        
update placement
set activeflag = 0, updatedby = 'CDM-40063', updatedon = now()
where placementid = 'c7d082a2-0bf0-4679-8e06-82d3fb1ad336' and activeflag = 1;

update placementrevision
set activeflag = 0, updatedby = 'CDM-40063', updatedon = now()
where placementid = 'c7d082a2-0bf0-4679-8e06-82d3fb1ad336' and activeflag = 1;

update livingarrangement
set activeflag = 0, updatedby = 'CDM-40063', updatedon = now()
where placementid = 'c7d082a2-0bf0-4679-8e06-82d3fb1ad336' and activeflag = 1;

update routing
set activeflag = 0, updatedby = 'CDM-40063', updatedon = now()
where objectid = 'c7d082a2-0bf0-4679-8e06-82d3fb1ad336' and activeflag = 1;
            


update placement
set activeflag = 0, updatedby = 'CDM-40063', updatedon = now()
where placementid = 'e14a7ed4-0981-4e9f-ac15-c39222a0b8bf' and activeflag = 1;

update placementrevision
set activeflag = 0, updatedby = 'CDM-40063', updatedon = now()
where placementid = 'e14a7ed4-0981-4e9f-ac15-c39222a0b8bf' and activeflag = 1;

update livingarrangement
set activeflag = 0, updatedby = 'CDM-40063', updatedon = now()
where placementid = 'e14a7ed4-0981-4e9f-ac15-c39222a0b8bf' and activeflag = 1;

update routing
set activeflag = 0, updatedby = 'CDM-40063', updatedon = now()
where objectid = 'e14a7ed4-0981-4e9f-ac15-c39222a0b8bf' and activeflag = 1;
            

