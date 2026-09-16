/*
   Issue Description: CDM-39884 GAP subsidy.Please delete the rejected subsidy rate.
   Category/ Module  : GAP Subsidy
   Root cause: User requested to delete the rejected subsidy rate.
   Case - 3237422
   CJAMS PID# : 3625570
   Fix provided : Data fix has been promoted to delete the rejected GAP subsidy rate.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/

update gapagreementrate
set activeflag = 0,
	updatedby = 'CDM-39884',
	updatedon = now()
where gapagreementrateid in ('ecd51fd6-1029-4890-aabb-8e2c8b953be2','af15f792-6655-4751-b6bd-bffe58da3943')
	and activeflag  = 1 ;

update gapratesrevision
set activeflag = 0,
	updatedby = 'CDM-39884',
	updatedon = now()
where gaprateid in ('ecd51fd6-1029-4890-aabb-8e2c8b953be2','af15f792-6655-4751-b6bd-bffe58da3943')
	and activeflag  = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CDM-39884',
	updatedon = now()
where objectid in ('ecd51fd6-1029-4890-aabb-8e2c8b953be2','af15f792-6655-4751-b6bd-bffe58da3943')
	and activeflag  = 1 ;
