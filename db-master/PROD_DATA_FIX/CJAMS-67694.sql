
/*
Issue Description: CJAMS-67694 -to update the LRR reason value on the CPS IR # 261023716219
Category/Module: Case Management
Root cause: 261023716219:Request correction of Over Due Reason. Contact with Alleged Victim Completed: "Child out of the jurisdiction / ROA pending - Family is out of State. For Contact with Initial Contact Caregiver Attempted or Completed: remove the existing reason from database, also to update caseworker comments
and Contact Date as : 05/09/2026 for Contact ID: 16228088
Fix provided: Data fix has been promoted to update cpsresponsetimeractions table and also update the Contact Date as : 05/09/2026 for Contact ID: 16228088 from backend
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: Data fix 
*/
update cpsresponsetimeractions
set cpsresponsetimerreason1 = 'VCOJ',
    cpsresponsetimerreason2 = 'VROJ',
    cpsresponsetimerreason7 = null,
    caseworkercomments='The initial report did not provide a complete address or accurate phone number for the alleged victim and ICC. The report indicated the alleged victim and ICC reside in Atlanta, Georgia. Worker obtained phone number and successfully contacted ICC within response time and obtained the family''s current address. Worker contacted law enforcement in Georgia and requested a child welfare check within response time. Law enforcement completed welfare check with alleged victim and ICC the same day but outside of the response time.',
    updatedon = now(),
    updatedby = 'CJAMS-67694'
where cpsresponsetimeractionsid = '6b1c19cb-db01-4eeb-8a2b-2d7bf7a8eb3d'
and intakeserviceid='5f11652c-26be-438c-af2d-116b6a53e41b';

update progressnote set contactdate = '2026-05-09 00:00:00', starttime='2026-05-09 12:00:00', endtime= '2026-05-09 13:00:00',
updatedby ='CJAMS-67694', updatedon =now()
where progressnoteid='5e17b6f3-fa2f-4ae7-8a3b-ca472f69c5de';

select * from cjams.cpsresponsetimerupdate
( '5f11652c-26be-438c-af2d-116b6a53e41b'::uuid,
'CJAMS-67694'::character varying
);