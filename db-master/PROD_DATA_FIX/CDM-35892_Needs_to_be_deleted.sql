/*
 Issue Description: CDM-35892
 Category/ Module  : 
 Root cause: user want to remove the intake I231011472240
 Pull request# for code fix: 
 Reason why no related code fix: 
 Status of the code fix if already submitted and expected prod fix date: 
 Need to do data fix
 */
update
    intakedastaging
set
    activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-35892'
where
    intakenumber = 'I231011472240'
    and activeflag = 1;

update
    intakedastatus
set
    activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-35892'
where
    intakenumber = 'I231011472240'
    and activeflag = 1;