/*
   Issue Description: CDM-30763
   Category/ Module  : contact notes
   Root cause: User requested to change the contact type to initial face to face
   Pull request# for code fix: 8796
   Reason why no related code fix: 
    requested a data fix to resolve
*/
update progressnote set progressnotetypeid = 'b83d8c25-f7db-4816-87f4-35a657790ad4', updatedon = now(),
updatedby = 'CDM-30763'
where progressnoteid in ('998eadc8-9985-4b28-8abb-de54ee6db732', '6cae07f2-4ce2-41f5-b3db-5179cd09d2fc');
