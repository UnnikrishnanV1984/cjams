/*
  Issue Description:  CDM-42466
   Category/ Module  : Intake
   Root cause: Intake is missing subtype values
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: NA
   Backup before update/ delete: NA
*/

--UPDATE Intake to CPS-IR

UPDATE intakedastaging
set updatedby = 'CDM-42466',
	updatedon = now(),
	jsondata = jsonb_set(
                jsonb_set(jsondata, '{sdm, screenOut, scrnout_description}', 'null'),
                '{sdm, isir}', 'true'
            )
WHERE intakenumber = 'I241013165811' and activeflag = 1;