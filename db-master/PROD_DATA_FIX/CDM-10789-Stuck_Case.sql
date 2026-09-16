
update intakedastaging set activeflag = 1, updatedby = 'CDM-10789', updatedon = now() where intakenumber = 'I202100517603' and id = '1107441';

update intakedastatus set activeflag = 0, updatedby = 'CDM-10789', updatedon = now() where intakenumber = 'I202100517603';