/*
   Issue Description: CDM-36995

   Tables: 
      intakedastatus :: intakenumber
      routing :: objectid
      intakedastaging :: intakenumber
      intakesnapshot :: intakenumber
   Root cause: The Intake has no detail information in it. Removed the Intake # I211010193642 as requested.
   Fix provided: Data fix provided to remove intake.
   Pull request# for code fix: 
   Reason why no related code fix: 
*/

--Backup
select activeflag,updatedby,updatedon from intakedastatus where intakedastatusid='4dfdcb05-5b74-45e8-b369-b04771e275b1'::uuid and intakenumber = 'I211010193642' and activeflag = 1;

-- UPDATE cjams.intakedastatus
-- SET activeflag=1, updatedby='64c96a4e-6f52-499c-8190-4638decea2b2', updatedon='2021-09-23 12:28:10.919' 
-- WHERE intakedastatusid='4dfdcb05-5b74-45e8-b369-b04771e275b1'::uuid;

--Update
Update intakedastatus set 
updatedby = 'CDM-36995', updatedon = now(),
activeflag =0
WHERE intakedastatusid='4dfdcb05-5b74-45e8-b369-b04771e275b1'::uuid and intakenumber = 'I211010193642' 
and activeflag = 1;

--Backup
select updatedby,updatedon,activeflag,id,intakenumber from intakedastaging where id=2785199 and intakenumber='I211010193642' and activeflag = 1;

-- UPDATE cjams.intakedastaging
-- SET updatedby='64c96a4e-6f52-499c-8190-4638decea2b2', updatedon='2021-09-23 12:28:10.919', activeflag=1, intakenumber='I211010193642'
-- WHERE id=2785199 and intakenumber='I211010193642' and activeflag = 1;

--Update
Update intakedastaging set 
updatedby = 'CDM-36995', updatedon = now(),
activeflag =0
WHERE id=2785199 and intakenumber = 'I211010193642' and activeflag = 1;