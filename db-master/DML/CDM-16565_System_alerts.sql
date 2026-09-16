/*
   Issue Description: CDM-16565
   Category/ Module  : Alerts from Other counties
   Root cause:Receiving alerts from other counties
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/






update usernotification set activeflag = 0, updatedby = 'CDM-16565', updatedon = now() where usernotificationid in ('7f4ccde7-d05d-443a-98c1-d2ddc95cf7ff', '6ddcf388-6b3b-4d2d-8130-5f5d49a7dd41', '75b7281a-e6e8-4931-9652-d8f846429b5e');