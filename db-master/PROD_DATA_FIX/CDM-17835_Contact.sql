/*
   Issue Description: CDM-17835 Unable to access contact
   Category/ Module  : Contact (remove) 
   Root cause: Created another contact later, since the first one failed to open bcoz the particicpants activeflag=0 inserted).
   Pull request# for code fix: 
   Reason why no related code fix:  
   Status of the code fix if already submitted and expected prod fix date: 
*/

 UPDATE cjams.meetingrecordingactor set activeflag =0, updatedon = now(), updatedby = 'CDM-17835' WHERE  meetingrecordingid = '3e3c64b4-3366-46bc-820b-63e8cd3adce8';
 UPDATE cjams.meetingparticipants set activeflag =0, updatedon = now(), updatedby = 'CDM-17835' WHERE  meetingrecordingid = '3e3c64b4-3366-46bc-820b-63e8cd3adce8';
 UPDATE cjams.meetingfimdetails set activeflag =0, updatedon = now(), updatedby = 'CDM-17835' WHERE  meetingrecordingid = '3e3c64b4-3366-46bc-820b-63e8cd3adce8';
 UPDATE cjams.meetingrecording set activeflag =0, updatedon = now(), updatedby = 'CDM-17835' WHERE  meetingrecordingid = '3e3c64b4-3366-46bc-820b-63e8cd3adce8';
 