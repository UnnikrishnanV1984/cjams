/*
   Issue Description: CDM-38087 CW intake #I241012095396
   Category/ Module  : Delete intake
   Root cause: user wants to delete intake I241012095396 as it was created by mistake
   Status of the code fix if already submitted and expected prod fix date: Need to do data fix
   Fix Provided: Data fix has been promoted to delete the intake #I241012095396
*/
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-38087'
where objectid = 'I241012095396';

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-38087'
where intakenumber = 'I241012095396';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-38087'
where intakenumber = 'I241012095396';

update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-38087'
where intakenumber = 'I241012095396';