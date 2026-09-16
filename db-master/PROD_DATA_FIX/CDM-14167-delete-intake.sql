update intakedastaging set
activeflag = 0,
updatedon = now(),
updatedby = 'CDM-14167'
where intakenumber = 'I211010165737';

update intakedastatus set
activeflag = 0,
updatedon = now(),
updatedby = 'CDM-14167'
where intakenumber = 'I211010165737';

update intakesnapshot set
activeflag = 0,
updatedon = now(),
updatedby = 'CDM-14167'
where intakenumber = 'I211010165737';