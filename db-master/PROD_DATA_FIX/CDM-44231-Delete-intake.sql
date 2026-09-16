/*
 Issue Description:CDM-44231
 Category/ Module:delete intake
 Root cause: delete
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/

        UPDATE intakedastatus
        SET activeflag = 0, updatedon= now(), updatedby = 'CDM-44231'
        WHERE intakenumber = 'I251013220368' AND activeflag = 1;


        UPDATE intakedastaging
        SET activeflag = 0, updatedon= now(), updatedby = 'CDM-44231'
        WHERE intakenumber = 'I251013220368' AND activeflag = 1;



        


