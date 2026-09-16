update intakeservreqchildremoval set primarycaregiverid = 1610497,primarycaregiveractorid = '042df8e1-5401-4b53-83a5-7150cd4cf0ac', updatedby = 'CDM-9663', updatedon = now() where removalid = 193924;
update intakeservicerequestactor i set activeflag = 1,updatedby = 'CDM-9663',updatedon = now() where intakeservicerequestactorid = '51365d96-a73a-42b0-a071-38b6654cc663' and activeflag = 0;	
