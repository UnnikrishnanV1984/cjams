/*
   Issue Description: CJAMS-63417
   Category/ Module  : Ending program structure
   Root cause: Data fix to remove the adoption program assignment end date & the Reason for End.
    Client ID: 3372566 (ARHYANNA JOHNSON)
    Adoption Agreement End Date: 09/17/2027
   Fix provided: Data fix to remove the adoption program assignment end date & the Reason for End.
   Pull request#
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
 Need to do data fix
*/


update personprogramarea
  set enddate = null, 
      endreasonkey = 3400,
      updatedby = 'CJAMS-63417', 
      updatedon = now()
where personprogramid = '69f2a426-1673-475f-92f4-e3d423e51a71' 
  and personid = 'e9975cbb-2c89-4a4a-97e6-75f2aa219d29'
  and activeflag = 1 ;