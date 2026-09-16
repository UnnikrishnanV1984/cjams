/*
   Issue Description: CDM-29720
   Category/ Module  : POSC section 8 
   Root cause: signatures are copied form other case
   Pull request# for code fix: 8415
   Reason why no related code fix: 
    requested a data fix and code fix to resolve

*/
update safecareplan set signatures = '{
  "showcourtvalue": null,
  "showcontactvalue": null,
  "signatureitemsFormArray": [
    {
      "signaturevalue": null,
      "signaturedate": null,
      "declinemember": null
    },
    {
      "signaturevalue": null,
      "signaturedate": null,
      "declinemember": null
    }
  ],
  "ldsssign": null,
  "ldssdate": null,
  "supervisorsign": "",
  "supervisordate": ""
}' ,
updatedon = now()
where safecareplanid = '66c4f6af-a215-468a-a523-9f4d5533e8c4';