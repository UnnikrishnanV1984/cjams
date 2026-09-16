/* 
    Issue Description: CJAMS-58268
   Category/ Module  : Hospitalization
   Root cause: User requested update ER visit date and overstay details
   Fix provided: Promoted database script to update ER visit and overstay details
   Pull request# for code fix: 
   Reason why no related code fix: User Error
*/


update personhospitalization 
set Hospital_ERexamination = true,
	Hospital_examStartDate='2023-04-11 00:00:00.000',
	Hospital_Overstay =false,
	Hospital_LengthOfOverstay = null,
	updatedon = now(), 
	updatedby ='CJAMS-58268'
where hospitalizationid  ='15927a90-b73f-43c2-bfe7-6608ffeb2fff' and activeflag =1