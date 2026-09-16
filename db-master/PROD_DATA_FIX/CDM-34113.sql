/*
 * CDM-34113 - duplicate referral, please delete
 * Customer Email ID:patricia.linder@maryland.gov
 * Customer Name:Patricia Linder
 * Focus Area:Assignments
 * I231011116088:Duplicate referral. Another jurisdiction entered at the same time. This case needs to be deleted.
 * remove the Intake as it is a draft/in-progress.
 * 
 */

select routingid, objectid, activeflag , updatedby, updatedon 
	from routing
where objectid in ('I231011116088') 
	and activeflag = 1 ;
	
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34113'
where objectid in ('I231011116088') 
	and activeflag = 1 ;

select intakenumber, activeflag , updatedby, updatedon 
	from intakedastatus
where intakenumber in ('I231011116088') 
	and activeflag = 1 ;
	
update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34113'
where intakenumber in ('I231011116088') 
	and activeflag = 1 ;

select intakenumber, activeflag , updatedby, updatedon 
	from intakedastaging
where intakenumber in ('I231011116088') 
	and activeflag = 1 ;
	
update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34113'
where intakenumber in ('I231011116088') 
	and activeflag = 1 ;

select intakenumber, activeflag , updatedby, updatedon 
	from intakesnapshot
where intakenumber in ('I231011116088') 
	and activeflag = 1 ;
	
update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34113'
where intakenumber in ('I231011116088') 
	and activeflag = 1 ;