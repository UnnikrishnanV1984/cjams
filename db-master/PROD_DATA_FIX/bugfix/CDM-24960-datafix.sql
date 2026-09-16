/*
    Issue Description: CDM-24960
    Category/ Module  : CPS-AR
    Fix: Case status set to "Completed" from "Closed".
*/

select 	intakeserviceid, intakeserreqstatustypeid, servicerequestnumber
from 	intakeservicerequest
where 	servicerequestnumber = '221020192280'
		and intakeserreqstatustypeid = '642f18b0-ef6e-4d4b-9871-acc0734f3f5a'
		and activeflag = 1;

update 	intakeservicerequest 
set 	intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8',
		updatedby = 'CDM-24960', 
		updatedon = now()
where 	servicerequestnumber = '221020192280'
		and intakeserreqstatustypeid = '642f18b0-ef6e-4d4b-9871-acc0734f3f5a'
		and activeflag = 1;