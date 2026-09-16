/*
   Issue Description: CDM-22997
   Category/ Module  : Please delete the contact in Brittany Seidle (case #- 3148488).
    The contact date and time is 6/1/2022 at 3:32PM. It was entered incorrectly.
   Root cause: user wants to delete the contact note
*/


update ProgressNote set activeflag = 0, updatedon = now(),
updatedby = 'CDM-22997' where progressnoteid= 'd6f79050-056f-44cb-8bd4-24b0750309b5';


update progressnotedetail set activeflag = 0, updatedon = now(),
updatedby = 'CDM-22997' where progressnotedetailid= '7433926c-6778-4449-b9e5-3bef0f2f7f4e';