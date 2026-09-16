/*
   Issue Description: CDM-18089
   Category/ Module  : Contact (remove) 
   Root cause: Created another contact later, since the first one failed to open.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

 UPDATE cjams.meetingrecordingactor set activeflag =0, updatedon = now(), updatedby = 'CDM-18089' WHERE  meetingrecordingid = 'b0ba2497-d4b1-42f5-9f03-6edc94229064';
 UPDATE cjams.meetingparticipants set activeflag =0, updatedon = now(), updatedby = 'CDM-18089' WHERE  meetingrecordingid = 'b0ba2497-d4b1-42f5-9f03-6edc94229064';
 UPDATE cjams.meetingfimdetails set activeflag =0, updatedon = now(), updatedby = 'CDM-18089' WHERE  meetingrecordingid = 'b0ba2497-d4b1-42f5-9f03-6edc94229064';
 UPDATE cjams.meetingrecording set activeflag =0, updatedon = now(), updatedby = 'CDM-18089' WHERE  meetingrecordingid = 'b0ba2497-d4b1-42f5-9f03-6edc94229064';

 