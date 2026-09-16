/*
Issue Description: CJAMS-68664-Need to delete household members
Category/ Module: Persons tab
Root cause: User data entry error - the person CJAMS PID# 204984580 (Hollie Evans) was added twice to
            case 261023834864 an hour apart, and the user has requested both entries be removed
Fix provided: Data fix has been done to remove the person CJAMS PID# 204984580 from case 261023834864.
              Both duplicate person entries have been deactivated across actor, intakeservicerequestactor,
              personrole, personroletype, actorrelationship and personprogramarea
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error
*/





update cjams.actor
set
    activeflag = 0,
    updatedby = 'CJAMS-68664',
    updatedon = now ()
where
    personid = '08aef4cc-9af6-40b5-8490-aebd2c64a37c'
    and actorid ='e8c4546d-a07a-4042-a4fc-66fca077aa51'
    and activeflag = 1;

update cjams.intakeservicerequestactor
set
    activeflag = 0,
    updatedby = 'CJAMS-68664',
    updatedon = now ()
where
    personid = '08aef4cc-9af6-40b5-8490-aebd2c64a37c'
    and intakeservicerequestactorid ='04eb70bd-a920-4b1c-a9f6-93cefb81982c'
    and activeflag = 1;

update cjams.personrole
set
    activeflag = 0,
    updatedby = 'CJAMS-68664',
    updatedon = now ()
where
    personid = '08aef4cc-9af6-40b5-8490-aebd2c64a37c'
    and personroleid ='f2fc7fec-4086-45c1-aedd-b455b0139d92'
    and activeflag = 1;

update cjams.personroletype
set
    activeflag = 0,
    updatedby = 'CJAMS-68664',
    updatedon = now ()
where
    personroleid ='f2fc7fec-4086-45c1-aedd-b455b0139d92'
    and personroletypeid ='0236bef5-8dfa-4549-8d66-6b5ef33ccde0'
    and activeflag = 1;


update cjams.personprogramarea
set
    activeflag = 0,
    updatedby = 'CJAMS-68664',
    updatedon = now ()
where
    personid = '08aef4cc-9af6-40b5-8490-aebd2c64a37c'
    and personprogramid ='417f81b4-acaf-46bd-b239-2f888a8046a4'
    and activeflag = 1;