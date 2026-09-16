/*
 Issue Description: CJAMS-58685
 User requested to do a data fix to add 2nd parent Signature missing reason under child removal for both childs
For Winter - The father was not engaged with the child at the time the VPA occurred
For Thomas - There is currently not an identified 2nd parent
 Category/ Module: Child Removal
 Root cause: User requested to do a data fix to add 2nd parent Signature missing reason under child removal for both childs Winter and Thomas.
 Pull request# 	N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/

--For Winter

update intakeservreqchildremoval
set parent2comments = 'The father was not engaged with the child at the 
time the VPA occurred.',
   updatedby = 'CJAMS-58685',
   updatedon = now()
where intakeservreqchildremovalid = '52d0b80f-865a-48b1-b1de-3260aa9a0af9'
and activeflag = 1;

--For Thomas

update intakeservreqchildremoval
set parent2comments = 'There is currently not an identified 2nd parent.',
    updatedby = 'CJAMS-58685',
    updatedon = now()
where intakeservreqchildremovalid = '04f3174d-1ddc-4e6d-b0b5-c2cac34b34fe'
and activeflag = 1;

