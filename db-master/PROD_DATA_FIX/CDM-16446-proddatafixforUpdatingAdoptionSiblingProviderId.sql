/*
   Issue Description: CDM-16446
   Category/ Module  : Data fix for Adoption Provider Info
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

/*
[
  {
    "nameofsiblingchild": "BROOKE BIANCHI",
    "siblingadoptionstatus": null,
    "siblingproviderid": "5094506",
    "dateofsiblingsadoptiondecree": null,
    "dateofsiblingsapplicablechildassessment": "2021-08-18T17:38:44.235Z"
  }
]

*/


update adoptionapplicabilityinfo set eligiblesiblingsinfo = '[
  {
    "nameofsiblingchild": "BROOKE BIANCHI",
    "siblingadoptionstatus": null,
    "siblingproviderid": "5094506",
    "dateofsiblingsadoptiondecree": null,
    "dateofsiblingsapplicablechildassessment": "2021-08-18T17:38:44.235Z"
  }
]', updatedby = 'CDM-16446', updatedon = now() 
where clientid = 4489486 and removalid = 199936 and activeflag = 1;