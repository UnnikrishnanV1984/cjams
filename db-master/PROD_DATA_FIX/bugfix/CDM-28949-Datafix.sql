/*
   Issue Description: CDM-28949
   Category/ Module  :Data fix for end date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Issue Description: User asked to revert AR Summary Status from Approve to Draft
*/

update caseassignment set 
enddate = null,
updatedby = 'CDM-28949', updatedon = now() where objectid='adb03980-7837-4cc0-9faa-fab051a2eca3';


update routing set activeflag = 0, updatedby = 'CDM-28949', updatedon = now()
where objectid='adb03980-7837-4cc0-9faa-fab051a2eca3';

UPDATE IntakeServiceRequestDispositionCode 
SET activeflag =0, 
updatedby = 'CDM-22793',
updatedon = now() 
WHERE 
intakeservicerequestdispositioncodeid = '9d4003e2-d536-4d4a-8d06-5022d72986da';


update routing set activeflag = 0, updatedby = 'CDM-28949', updatedon = now()
where objectid='9d4003e2-d536-4d4a-8d06-5022d72986da' and routingid='1ee8e39b-18d9-4e80-84df-47b5e010118b';



