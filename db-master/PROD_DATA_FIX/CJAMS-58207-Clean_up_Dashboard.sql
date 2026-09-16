
/*
   Issue Description: CJAMS-58207
   Category/ Module  : 
   Root cause: user want to remove intake from pending dashboard
   Pull request# for code fix: 
   Reason why no related code fix: User Error
*/ 

-- No records found in routing table.
-- select * from routing where objectid in 
-- (
-- 'I241012820834', 
-- 'I241012648329',
-- 'I241012089668',
-- 'I241012072899',
-- 'I241012065042',
-- 'I231011157235'
-- )

update intakedastaging  set status='Complete', updatedby='CJAMS-58207', updatedon = now() where intakenumber in 
(
'I241012820834', 
'I241012648329',
'I241012089668',
'I241012072899',
'I241012065042',
'I231011157235'
) and activeflag = 1;