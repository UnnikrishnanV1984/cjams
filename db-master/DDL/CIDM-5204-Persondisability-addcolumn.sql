ALTER table persondisability add column if not exists previouscondition boolean;
comment on column persondisability.previouscondition is 'To capture whether  previouscondition or not in  disability section in health tab';

ALTER table persondisability add column if not exists doesnotapply boolean;
comment on column persondisability.doesnotapply is 'To capture whether  existingcondition/previouscondition  doesnotapply  in  disability section in health tab';


ALTER table persondisability add column if not exists existingcondition boolean;
comment on column persondisability.existingcondition is 'To capture whether existingcondition or not in disability section in health tab';