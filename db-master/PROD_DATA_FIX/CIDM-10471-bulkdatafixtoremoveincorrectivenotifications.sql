/*
   Issue Description: CIDM-10471
   Category/ Module  : Prod data fix to remove incorrect ive notification
   Root cause:  CDM-44363 
   Pull request# for code fix: https://source.mdthink.maryland.gov/projects/DHSCJAMS/repos/cjams_welfare_api/pull-requests/3318/overview
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update cjams.usernotification u set activeflag = 0, updatedby = 'CIDM-10471', updatedon = now()
from intakeservreqchildremoval ir 
where ir.intakeservreqchildremovalid =  u.entityid and ir.activeflag = 1 and u.activeflag = 1 and (select max(ifa.dateagencylostlegalresponsibility)::date  
						from tb_ive_fostercare_audit ifa
						where ifa.eligibility_period_id 
							in (select eligibility_period_id   
									from tb_client_eligibility tce, 
										tb_eligibility_period tep
								where tce.eligibility_id  = tep.eligibility_id 
									and tce.delete_sw = 'N'                    
								and tep.delete_sw = 'N'
								and tce.removal_id = ir.removalid
							) 
) is null and u.old_id = 'IVEPH0' ;


update usernotificationmap set activeflag = 0, updatedby = 'CIDM-10471', updatedon = now()
where usernotificationid in (select usernotificationid from usernotification where updatedby = 'CIDM-10471' and activeflag = 0)
and activeflag = 1;