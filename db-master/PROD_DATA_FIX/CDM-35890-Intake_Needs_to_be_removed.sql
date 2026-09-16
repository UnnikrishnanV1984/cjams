/*
 Issue Description: CDM-35890
 Category/ Module  : 
 Root cause: user want to remove the intake I231010846995
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
    updatedby = 'CDM-35890'
where
    intakenumber = 'I231010846995';

update
    intakedastatus
set
    activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-35890'
where
    intakenumber = 'I231010846995';