/*
Issue Description:Can you please grant me and my supervisor, Tara Newcomer, access to a restricted case in Cecil County (251023112280 ).
Root cause: As per current system design, once the intake is restricted and no one can or will have an access to the referral. In the case level, there is a functionality to assign the restricted case to specific worker/supervisor.
User story B-219423 has been added to resolve this scenario and is still under review with SSA/Product Owner.Service # 251023112280  
Fix provided: Data fix has been done to update the restricteditems table.
Data/Code fix ticket#:CJAMS-61588
Regression Impacts: N/A
Reason why no related code fix: N/A
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
--251023112280   
--d0517441-7a44-4858-84b4-7965fda851bd	Erin Volz
INSERT INTO cjams.restricteditems
      (restricteditemsid, objecttypekey, objectid, accessuserid, description, isadd, isedit, isdelete, insertedby, updatedby, insertedon, updatedon, activeflag, roletypekey)
VALUES(gen_random_uuid(), 'Servicerequest', 'a90b0ff9-ea2e-4ddd-930a-cda237a81b9e', 'd0517441-7a44-4858-84b4-7965fda851bd', NULL, false, false, false, 'CJAMS-61588', 'CJAMS-61588', now(), now(), 1,'CWCW');

--34aa88ee-492f-4b39-800a-9fa0d8b5cef8	Tara Newcomer 
INSERT INTO cjams.restricteditems
(restricteditemsid, objecttypekey, objectid, accessuserid, description, isadd, isedit, isdelete, insertedby, updatedby, insertedon, updatedon, activeflag, roletypekey)
VALUES(gen_random_uuid(), 'Servicerequest', 'a90b0ff9-ea2e-4ddd-930a-cda237a81b9e', '34aa88ee-492f-4b39-800a-9fa0d8b5cef8', NULL, false, false, false, 'CJAMS-61588', 'CJAMS-61588', now(), now(), 1,'CWCW');