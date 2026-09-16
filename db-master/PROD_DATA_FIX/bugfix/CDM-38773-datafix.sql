/* 
    Issue Description: CDM-38773
  Category/ Module  : Assignments
  Root cause: There is change in worker name and date due to data migration
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/

update intakedastaging set insertedby='01983d08-cfb4-4a3d-acfa-2d722be117a0',updatedby='01983d08-cfb4-4a3d-acfa-2d722be117a0',
insertedon='2017-07-05 12:27:42.000', updatedon='2017-07-05 12:35:17.000', intakeuser='01983d08-cfb4-4a3d-acfa-2d722be117a0'
where intakenumber ='CW9903085';
update intakeservicerequest set updatedby='01983d08-cfb4-4a3d-acfa-2d722be117a0' where servicerequestnumber='CW9903085';

update intakedastatus set insertedby='01983d08-cfb4-4a3d-acfa-2d722be117a0',updatedby='01983d08-cfb4-4a3d-acfa-2d722be117a0',
insertedon='2017-07-05 12:27:42.000', updatedon='2017-07-05 12:35:17.000',submitteddate='2017-07-05 12:35:17.000'
where intakenumber ='CW9903085';