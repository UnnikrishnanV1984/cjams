/*
   Issue Description: CDM-39459
   Category/ Module  :Contact notes
   Root cause:Accidently marked a monthly visit(contact) as an attempted visit instead of a completed visit, therefore it has been flagged and appears as a missed visit
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update progressnote set contactstatus='true', updatedby='CDM-39459', updatedon=now()
where progressnoteid='113f6e63-fdad-4700-a15a-b78506b7bf4e' and witsid='12968533' and activeflag=1;