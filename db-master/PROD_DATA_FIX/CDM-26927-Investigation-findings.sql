/*
   Issue Description: CDM-26927
   Category/ Module  :  the child (Zoey Cooper) is not identified as Alleged Victim in the Person tab but
    the child name is appeared in the Investigation Findings tab.
   Root cause: user wants to Close the case 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



update Investigationallegationmaltreators set activeflag =0, updatedby = 'CDM-26927',
		updatedon = now() where investigationallegationid='ebda0761-e284-4d21-b35f-0d798e855549';
