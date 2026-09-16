    /*
   Issue Description: CDM-40576 Incorrect Guardian Documented
   Category/ Module  :Title IV-E GAP
   Root cause: User error incorrect guardian documented ( Ruth Gorham / Provider ID 5027009) , Should be Darmay Tolliver / Provider ID 5030870 . 
               Also Relationship is DayCare ! Should Be Non-Relative Screen URL:
   Fix provided : Data fix has been promoted to update the Guardian information in Title IV-E GAP and relationship in permanency plan from Foster-parent to Non-relative.
   Pull request# for code fix: N/A
   Reason why no related code fix: User error and requested for data fix 
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

update gapeligibilityinfo set  primaryguardianrelationship = 'non-relative',
childguardianid = 5030870, childguardianname = 'Darmay Tolliver',
updatedby = 'CDM-40576', updatedon = now()
where client_id = '2114348' and activeflag =1;


update guardianship set primaryrelationshipkey = 'NORELTVE',
updatedby = 'CDM-40576', updatedon = now()
where gapid='30c0947a-9d9e-42b3-a40d-9d4c1633ce7c'; 
