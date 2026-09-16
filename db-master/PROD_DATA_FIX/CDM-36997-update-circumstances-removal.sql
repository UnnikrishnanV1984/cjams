/*
   Issue Description: CDM-36997
   Category/ Module  :  Child Removal
   Root cause: User requested to update circumstances for child removal
   Resolution:provided data fix to update circumstances
   Pull request# for code fix: 
   Reason why no related code fix: 
*/

select * from intakeservreqchildremoval_history rh 
where rh.rowtype = 'REVISION' and rh.intakeservreqchildremovalid = '58527f6b-be5b-4baa-ba11-39acea38bf7d' 
order by updatedon desc limit 1;

update intakeservreqchildremoval_history
			set removalcircumstances = '{
			   "abandonment":false,
			   "caretakeralcoholuse":false,
			   "caretakerdruguse":false,
			   "caretakersignificantimpairment":false,
			   "caretakerignificantimpphysical":false,
			   "childalcoholuse":false,
			   "childbehaviorproblem":true,
			   "childdruguse":false,
			   "childrequestedplacement":false,
			   "deathofcaretaker":false,
			   "diagnosedcondition":true,
			   "domesticviolence":false,
			   "failuretoreturn":false,
			   "familyconflict":false,
			   "homelessness":false,
			   "inadequateaccesstomhs":false,
			   "inadequateaccesstomedicalservices":false,
			   "inadequatehousing":false,
			   "incarcerationofcaretaker":false,
			   "medicalneglect":false,
			   "neglect":false,
			   "parentalimmigration":false,
			   "physicalabuse":false,
			   "prenatalalcoholexposure":false,
			   "prenataldrugexposure":false,
			   "psychologicalemotionalabuse":false,
			   "publicagencytitleive":false,
			   "runaway":false,
			   "sexualabuse":false,
			   "sextrafficking":false,
			   "tribaltitleive":false,
			   "voluntaryrelinquishment":false,
			   "whereaboutsunknown":false
			}',
			updatedby = 'CDM-36997',
			updatedon = now()
where intakeservreqchildremovalhistoryid  = '3e8ef7a2-5eea-463e-9eac-930b4f013ac3';

update intakeservreqchildremoval r
set removalcircumstances = (select rh.removalcircumstances from intakeservreqchildremoval_history rh 
where rh.intakeservreqchildremovalhistoryid = '3e8ef7a2-5eea-463e-9eac-930b4f013ac3'),
updatedby = 'CDM-36997',
updatedon = now()
where intakeservreqchildremovalid = '58527f6b-be5b-4baa-ba11-39acea38bf7d';
