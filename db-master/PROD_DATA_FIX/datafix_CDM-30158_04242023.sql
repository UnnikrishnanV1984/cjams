-- CDM-30158 - Case closure
/*
-- Issue Description: 
   This provider cannot be closed until all outstanding purchase authorizations (3278102)
   
-- Provider ID: 5007433	(EMILY PINKNEY) - Local Department Home
-- Case ID: 3278102 
-- Client ID: 1465188 (JANEYA SHERISE BROWN) - db85c2cd-a846-4748-9525-335d66f22daa
-- Auth ID: 740607 - 05/06/2020 To 05/21/2020 - $127.92 - Transportation assistance (Paid) 
-- Paymnet ID: 1930660	Date: 01/16/2020

-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Root cause: Data migration issue (the Authorization payment was generated in MD CHESSIE)
-- Fix Provided: Datafix has been promoted to fix the routing data and update Purchase Authorization as approved.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing 
where routingid = 'deea9a28-1e19-4ac2-af0e-d200244c5372' ;

update routing
set routingstatustypeid = 43,
	remarks = 'Approved',
	activeflag = 1,
	updatedby = 'CDM-30158',
	updatedon = now()
where routingid = 'deea9a28-1e19-4ac2-af0e-d200244c5372' ;

select authorization_id, 
	sprvsr_approval_status_cd,
	sprvsr_approval_dt,
	ads_approval_status_cd,
	ads_approval_dt,
	funding_approval_status_cd, 
	funding_approval_dt, 
	payment_approval_status_cd,
	payment_approval_dt,
	update_ts, 
	update_user_id
from tb_service_purchase_authorization 
where authorization_id = 740607
	and delete_sw = 'N' ;

update tb_service_purchase_authorization
set funding_approval_status_cd = '3047', 
	funding_approval_dt = '2020-01-03'::date, 
	payment_approval_status_cd = '3047',
	payment_approval_dt ='2020-01-16'::date,
	update_ts = now(), 
	update_user_id = 'CDM-30158'
where authorization_id = 740607
	and delete_sw = 'N' ;
	
-- After
select activeflag, routingstatustypeid, remarks,  updatedby, updatedon
from routing 
where objectid = '740607'
	and eventcode  in ( 'PCAUTHR', 'PCAUTH' )
order by insertedon desc ;