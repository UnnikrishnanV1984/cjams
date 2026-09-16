/*
  Issue Description: CDM-41331
   Category/ Module  :Child removal
   Root cause: User requested to remove removal exit date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 1
*/

update intakeservreqchildremoval 
	set exitdate = null,
    removalexitreason = NULL,
    returntransts = NULL,
	    updatedby ='CDM-41331',
		updatedon =now() 
	where intakeservreqchildremovalid in ('f4b5cf11-682e-4774-9798-3c89aa115991','c962bddf-4b1a-48eb-9110-b1dea9b4404d','65b57406-deb9-490c-a38e-c485870c02d1') and activeflag =1;

update tb_client_eligibility
	set end_dt = null,
		update_user_id = 'CDM-41331',
		update_ts = now()
	where removal_id in ('252651','252649','252652');

update personprogramarea
	set enddate = null,
		updatedby ='CDM-41331',
		updatedon =now()
	where personprogramid in ('72dbcb9b-ede1-49f7-9b86-2f36bc69d63f','909533d8-1e35-4a2b-b842-5a73df264647','4c229001-4c24-46d1-88a4-7938f5a790da')and activeflag =1;


