
/*
   Issue Description: CDM-18134
   Category/ Module  : Removing gap agreement rate
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update gapagreementrate set activeflag =0, updatedby = 'CDM-18134', updatedon = now() where gapagreementrateid = '32d06bcb-1043-4058-ac9a-6e80ce850b6b';
