-- CDM-10648 - change case worker name in YTP

update youthtransitionplan set updatedby = 'CDM-10648', updatedon = now(), summary_json = '
{
  "dob": "2002-03-21",
  "caseno": "3274366",
  "clientName": "MELODY HARRIS",
  "assessments": [],
  "participants": [
    {
      "type": "Involved person",
      "lastname": "HARRIS",
      "firstname": "MELODY",
      "relationship": "Child"
    },
    {
      "type": "Involved person",
      "lastname": "LICAVOLI",
      "firstname": "ANNA",
      "relationship": "Biological Mother"
    },
    {
      "type": "LDSS Staff",
      "lastname": "Seader",
      "firstname": "Rebecca ",
      "relationship": "Case Worker"
    },
    {
      "type": "LDSS Staff",
      "lastname": "Jones",
      "firstname": "Daevonya",
      "relationship": "Independent Living Coordinator"
    },
    {
      "type": "Involved person",
      "lastname": "Holmes",
      "firstname": "Margaret",
      "relationship": "Child''s Attorney"
    },
    {
      "type": "Involved person",
      "lastname": "Outing",
      "firstname": "Kevin ",
      "relationship": "Dept. Attorney"
    },
    {
      "type": "Involved person",
      "lastname": "Halpin",
      "firstname": "Jennifer",
      "relationship": "CASA"
    }
  ],
  "effectivedate": "",
  "caseworkername": "AMANDA BATES",
  "planfollowupdate": "",
  "transplancompleted": "",
  "primarypermanencytype": "APPLA"
}
' where youthtransitionplanid ='e66d7df0-ea44-4474-a8c3-72f14411dc63';