/*
Issue: Service log routed to unavailable finance worker
Root cause: user error,Requested to reassign the Purchase Authorization # 4239307 to the Supervisor role so all Finance supervisor will be able to approved it.
Fix provided: Data fix has been done to reassign the Purchase Authorization # 4239307 to the Supervisor role so all Finance supervisor will be able to approved it.
Data/Code fix ticket#: CJAMS-66631
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: user error.
*/




update routing set eventcode = 'PCAUTHR',tosecurityusersid = null, updatedby='CJAMS-66631',updatedon=now()
where routingid = 'ef7f924f-360a-465d-818e-8c79c302e4df' and activeflag=1;