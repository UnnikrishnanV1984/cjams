/*
   Issue Description: CDM-38737
   Category/ Module  : SDM 
   Root cause: Need to update contacts from service case to CPS-AR.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update progressnote 
set entitytype='intakeservicerequest',entitytypeid='a6a48aae-9568-4ae8-9aae-e01520450d15',updatedby ='CDM-38737', updatedon =now()
where  witsid in(1285530,12855591,12859588,12859601,12859687,1260081) and activeflag= 1;


update progressnotedetail
set updatedby ='CDM-38737', updatedon =now()
where progressnoteid in ('1389264e-a7b6-4ff2-b2a8-3d9ed640a3ad','99408b0d-007f-4141-ab08-c877058ce635',
							'cd93ebc5-e849-4120-9767-99b5f2539f0e','7c0e4b11-d583-4621-a0a6-52e0b88ff2a0',
							'abb064e9-cfe8-4950-b4e8-1f418dd0821f','b342bf65-105e-4c08-a99c-8a8ee4de717c') and activeflag=1;


update contactparticipant
set updatedby ='CDM-38737', updatedon =now()
where progressnoteid in ('1389264e-a7b6-4ff2-b2a8-3d9ed640a3ad','99408b0d-007f-4141-ab08-c877058ce635',
							'cd93ebc5-e849-4120-9767-99b5f2539f0e','7c0e4b11-d583-4621-a0a6-52e0b88ff2a0',
							'abb064e9-cfe8-4950-b4e8-1f418dd0821f','b342bf65-105e-4c08-a99c-8a8ee4de717c') and activeflag=1;
	
