update caseassignmentactor
set activeflag = 0,
    updatedby = 'CIDM-6756', 
    updatedon = now() 
where activeflag  = 1
    and caseassignmentid  
        in ( select caseassignmentid 
                from caseassignment 
             where activeflag = 1
                and responsibilitytypekey in ('family', 'administrative')
                and etl_userid is null 
                and old_id is null 
            ) ;