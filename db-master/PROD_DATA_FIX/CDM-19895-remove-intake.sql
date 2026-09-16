/*
-- CDM-19895 - 

-- Issue Description: Duplicate intake
-- Root cause: Data fix
-- Pull request#: N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update intakedastaging set activeflag = 0, updatedby = 'CDM-19895', updatedon = now()
where intakenumber = 'I221010232111' and id = '3468105';

update intakedastatus set activeflag = 0, updatedby = 'CDM-19895', updatedon = now()
where intakenumber = 'I221010232111';
