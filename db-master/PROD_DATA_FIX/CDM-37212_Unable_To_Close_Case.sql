/*
 Issue Description: CDM-37212 - Unable to close case
 2020034904761:The case worker and supervisor have both tried to close this case and when they go to hit the Add button on the decision screen, the box fades and nothing happens. 
 Category/ Module : Intake
 Root cause: There are three duplicate review records out of which status of the latest one is approved and rest of the two has review status.
			 Per code, Add button is disabled if there are any records with review status. 
 Fix: Since these are duplicate records, the two old records with review status are softdeleted to allow user to close the case.
 Pull request# for code fix: 
 Reason why no related code fix: 
 Status of the code fix if already submitted and expected prod fix date: 

 */

	update servicecasedisposition 
			set activeflag = 0,
			    updatedon = now(),
			    updatedby = 'CDM-37212'
			where servicecasedispositionid in ('741e537c-e914-4116-a5a7-18985cdcfe93','fa515bb5-0807-4cc5-b399-75e74eeae852')
				and activeflag = 1;;
			
	update routing 
		set activeflag = 0,		
			updatedon = now(),
			updatedby = 'CDM-37212'
		where objectid in ('741e537c-e914-4116-a5a7-18985cdcfe93','fa515bb5-0807-4cc5-b399-75e74eeae852')
			and activeflag = 1;