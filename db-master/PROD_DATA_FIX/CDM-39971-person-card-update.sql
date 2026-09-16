/*
    Issue description: CDM-29971
    -- Category/Module: Person
    -- Root cause: Child over 18 cannot update.
    -- Pull request: N/A
    -- Reason why no related fix: N/A
    -- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update cjams.person
set priorlegalguardianship = 0,
    everbeenadoptedflag = 0,
    intercountryadoption = 0,
    updatedby = 'CDM-40029',
    updatedon = now()
where activeflag = 1 and cjamspid = 200660576;