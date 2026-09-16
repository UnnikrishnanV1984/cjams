/*
   Issue Description: CDM-39335
   Category/ Module  : case timeline
   Root cause:I241012460951 needs to be deleted from my dashboard as it is a duplicate report.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE IntakeDAStaging 
SET activeflag = 0,
    updatedby = 'CDM-39335',
    updatedon = now()
WHERE intakenumber in ('I241012460951') and activeflag=1;

UPDATE intakedastatus 
SET activeflag = 0,
    updatedby = 'CDM-39335',
    updatedon = now()
WHERE intakenumber in ('I241012460951') and activeflag=1;


--Deleted the particular case I241012460951 from the system
