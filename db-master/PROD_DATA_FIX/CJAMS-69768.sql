/*
Issue Description: CJAMS-69768 Approval Que
Category/Module: Purchase Authorization
Root cause: Funding Approval queue shows a purchase authorization only to the one user it is routed to, so the seven authorizations routed to Sean Rogers cannot be approved by anyone else while he is out on extended leave.
Fix provided: Data fix to release the seven pending authorizations to the county Funding Approval queue by routing them to the team instead of a single user, so any finance worker or financial supervisor in the county can approve them.
Below are the list of AuthID that have been released to the team queue
4474124
4474134
4474146
4474148
4474182
4474788
4474878
Data/Code fix ticket#: CJAMS-69768
Regression Impacts: NA
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Expected behaviour, user is on extended leave and data fix is needed to release her records
*/

update routing
set eventcode = 'PCAUTHR',
	tosecurityusersid = null,
	updatedby = 'CJAMS-69768',
	updatedon = now()
where objectid in ('4474124','4474134','4474146','4474148','4474182','4474788','4474878')
	and eventcode = 'PCAUTH'
	and tosecurityusersid = 'c4887fe8-b548-4137-a9b5-cfd72ee21fa9'
	and routingstatustypeid = 40
	and activeflag = 1;