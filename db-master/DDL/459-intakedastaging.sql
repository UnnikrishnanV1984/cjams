update cjams.intakedastaging 
set activeflag = 0 
where intakenumber in (
'I202000256629',
'I202000256643',
'I202000556848',
'I202000356677',
'I202000356682',
'I202000356685' ) and activeflag = 1;



