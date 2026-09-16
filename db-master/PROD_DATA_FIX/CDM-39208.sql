/*
 * CDM-39208 - Case stuck at Screening
 * Customer Email ID:stephanie.cooke1@maryland.gov
 * Description - I202100314346:Case is old and is a screen out. It is stuck at intake. 
 * Remove the old intakes from the intake worker dashboard.
 * 
 */
	
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-39208'
where objectid in (
'I202000478294',
'I202100314346',
'I202100515141',
'I202000105831',
'I211010172911',
'I202100414742',
'I202100619702',
'I202100421776',
'I202100527030',
'I202100127176',
'I211010165778',
'I211010167387',
'I211010172215',
'I202100421809',
'I202000101835',
'I202000300228',
'I202000393249',
'I202000696246') 
	and activeflag = 1 ;
	
update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-39208'
where intakenumber in (
'I202000478294',
'I202100314346',
'I202100515141',
'I202000105831',
'I211010172911',
'I202100414742',
'I202100619702',
'I202100421776',
'I202100527030',
'I202100127176',
'I211010165778',
'I211010167387',
'I211010172215',
'I202100421809',
'I202000101835',
'I202000300228',
'I202000393249',
'I202000696246') 
	and activeflag = 1 ;
	
update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-39208'
where intakenumber in (
'I202000478294',
'I202100314346',
'I202100515141',
'I202000105831',
'I211010172911',
'I202100414742',
'I202100619702',
'I202100421776',
'I202100527030',
'I202100127176',
'I211010165778',
'I211010167387',
'I211010172215',
'I202100421809',
'I202000101835',
'I202000300228',
'I202000393249',
'I202000696246') 
	and activeflag = 1 ;
	
update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-39208'
where intakenumber in (
'I202000478294',
'I202100314346',
'I202100515141',
'I202000105831',
'I211010172911',
'I202100414742',
'I202100619702',
'I202100421776',
'I202100527030',
'I202100127176',
'I211010165778',
'I211010167387',
'I211010172215',
'I202100421809',
'I202000101835',
'I202000300228',
'I202000393249',
'I202000696246') 
	and activeflag = 1 ;
    