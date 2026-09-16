
/*
   Issue Description: CDM-19338
   Category/ Module  : Removing Investigation and maltreatment findings
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update investigationmaltreatment set activeflag = 0, updatedby = 'CDM-19338', updatedon = now() where  maltreatmentid in ('97755b78-7546-41ce-9371-b014f5c82e61','5dcf1ac2-18a3-4f55-8261-aebf8442613e',
'27462227-556f-4da7-9ae9-990223448a13','36d79548-aa95-405b-99c9-936105e67ab3','0cbee197-3528-44a9-b06c-2ddd4e9ca4a7','5bd09453-8ff6-4247-a3a9-4af7031d0057',
'2ff1153b-fb54-48bb-99fd-b35ececbe80a','78181b79-83f6-4dac-a195-47dd0657bf77','2fb1bfe0-49bd-4147-8eb3-f9f17475520a','348dd43c-f559-4598-9386-25ecc10180be','4bbf46e0-9551-4a62-aba8-815a83fca082','9bd449aa-ceda-45b7-9af1-d0b7efb9d996');
 
update Investigationallegation set activeflag = 0, updatedby = 'CDM-19338', updatedon = now() where  maltreatmentid in ('97755b78-7546-41ce-9371-b014f5c82e61','5dcf1ac2-18a3-4f55-8261-aebf8442613e',
'27462227-556f-4da7-9ae9-990223448a13','36d79548-aa95-405b-99c9-936105e67ab3','0cbee197-3528-44a9-b06c-2ddd4e9ca4a7','5bd09453-8ff6-4247-a3a9-4af7031d0057',
'2ff1153b-fb54-48bb-99fd-b35ececbe80a','78181b79-83f6-4dac-a195-47dd0657bf77','2fb1bfe0-49bd-4147-8eb3-f9f17475520a','348dd43c-f559-4598-9386-25ecc10180be','4bbf46e0-9551-4a62-aba8-815a83fca082','9bd449aa-ceda-45b7-9af1-d0b7efb9d996');
 