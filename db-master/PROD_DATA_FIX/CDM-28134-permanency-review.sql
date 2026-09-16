/*
   Issue Description: CDM-28134
   Category/ Module  : Deleting permanency plan from dashboard
   Root cause: 
   Pull request# for code fix: It's a data fix 
*/

update routing 
        set activeflag = 0,updatedon = now(), updatedby = 'CDM-28134'
       where objectid  = '93ddf075-8ed3-4357-8133-62513de3a405'
      and routingid = '1818cb78-f3b4-4dfa-925d-573b61e47d7a';