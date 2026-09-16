/*
Issue Description:251023081002:Unable to submit (resubmit) CJAMS timer overdue reason (previously submitted to supervisor and approved on 6/23/25), however need to resubmit due to dropdown for contact with alleged victim being left blank. Screen
Root cause: As per current system design, once the intake is restricted and no one can or will have an access to the referral. In the case level, there is a functionality to assign the restricted case to specific worker/supervisor.
User story B-219423 has been added to resolve this scenario and is still under review with SSA/Product Owner.Service # 202108506858
Fix provided: Data fix has been done to update the restricteditems table.
Data/Code fix ticket#:CJAMS-61039
Regression Impacts: N/A
Reason why no related code fix: N/A
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
--202108506858 
--f0a6a8a8-5d68-4db8-90ea-cac9da19dc4d	Adrianne James
INSERT INTO cjams.restricteditems
      (restricteditemsid, objecttypekey, objectid, accessuserid, description, isadd, isedit, isdelete, insertedby, updatedby, insertedon, updatedon, activeflag, roletypekey)
VALUES(gen_random_uuid(), 'SERVICE', '1a78737d-0b14-4429-886f-01ab83d9acdf', 'f0a6a8a8-5d68-4db8-90ea-cac9da19dc4d', NULL, false, false, false, 'CJAMS-61039', 'CJAMS-61039', now(), now(), 1,'CWCW');

--29b7efe0-14ea-4a35-9801-4ee8e851209b	Harry Morgan  
INSERT INTO cjams.restricteditems
(restricteditemsid, objecttypekey, objectid, accessuserid, description, isadd, isedit, isdelete, insertedby, updatedby, insertedon, updatedon, activeflag, roletypekey)
VALUES(gen_random_uuid(), 'SERVICE', '1a78737d-0b14-4429-886f-01ab83d9acdf', '29b7efe0-14ea-4a35-9801-4ee8e851209b', NULL, false, false, false, 'CJAMS-61039', 'CJAMS-61039', now(), now(), 1,'CWCW');
