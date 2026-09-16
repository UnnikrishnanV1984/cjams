/*
   Issue Description: CDM-16039
   Category/ Module  :  CPS AR Case is closed , but Program areas not end dated.
   Root cause: N/A
   Pull request# for code fix: 
   Reason why no related code fix: 
    user requested end date program areas
*/

update personprogramarea 
set
enddate = '2021-07-12 00:00:00',
updatedby = 'CDM-16039',
updatedon = now()
where personprogramid in ('3a3fb24b-0319-4d7f-ae66-32d058a6e5fe', 'c3a8ebc6-e3c8-498c-bd99-098c37018d62',
'83f838fc-b7bb-45d2-aa1c-5a4c33d86324','3e8a62a5-0493-43fb-b4d3-1193fb4ec607');