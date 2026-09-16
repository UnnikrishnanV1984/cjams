/*
 * CDM-35044 - Break the Link error
 * Customer Email ID:nicole.cousler@maryland.gov
 * Customer Name:Nicole Cousler
 * Focus Area:Permanency Plan
 * Description - 3202528:Trying to break the link in adoption case; however, error message is popping up that information is missing when 
 * everything that can be filled out has been. 
 * data fix to remove the Child Removal & OOH Program Assignment end date.
 * Client Name : JAVONTAY AUSTIN
 * CJAMS PID# : 4408666
 * Provider ID# : 5096169 (Cj Phippin)
*/


--select activeflag, returntransts, removalid, * from cjams.intakeservreqchildremoval where intakeservreqchildremovalid = '8472f353-864e-4560-98cf-3eb82819e4e8';
update cjams.intakeservreqchildremoval
set exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	returntransts = NULL,
	updatedby = 'CDM-35044',
	updatedon = now()
where removalid = 200028
	and activeflag = 1 ;

--select activeflag ,* from cjams.personprogramarea where personprogramid = 'fcbabd70-c08a-4d93-a475-653c4eae781e';
update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-35044',
	updatedon = now()
where personprogramid = 'fcbabd70-c08a-4d93-a475-653c4eae781e'
	and activeflag = 1 ;


update cjams.tb_client_eligibility
set end_dt = Null,
	update_user_id = 'CDM-35044',
	update_ts = now()
where removal_id =  200028
	and delete_sw = 'N' ;
