/*
 * CDM-34973 - Intake referral duplicated in error
 * Customer Email ID:theresa.kleppinger@maryland.gov
 * Customer Name:Theresa Kleppinger
 * Description - I231011389906:Worker created a duplicate referral in error. 
 * remove the Intake # I231011389906
 *
 */

update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34973'
where objectid in ('I231011389906') 
	and activeflag = 1 ;

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34973'
where intakenumber = 'I231011389906';

update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34973'
where intakenumber = 'I231011389906';	