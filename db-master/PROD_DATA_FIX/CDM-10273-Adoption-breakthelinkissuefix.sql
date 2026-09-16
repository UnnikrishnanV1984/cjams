update adoptionapplicabilityinfo set activeflag = 0 where adoptionapplicabilityid = '189d03a1-4c69-420a-998a-0c96488bdf2a' and activeflag = 1;

update adoptionapplicabilityinfo set eligiblesiblingsinfo = '[
  {
    "cjamspid": 3737062,
    "nameofsiblingchild": "CHARLES WERKHEISER",
    "siblingproviderid": 5084850,
    "dateofsiblingsadoptiondecree": null,
    "dateofsiblingsapplicablechildassessment": "2021-01-12T14:00:00",
    "dtofsiblingsadoptiondecree": null,
    "adpsiblingname": null,
    "siblingadoptionstatus": null
  },
  {
    "cjamspid": 3936152,
    "nameofsiblingchild": "SUMMER WERKHEISER",
    "siblingproviderid": "5084850",
    "dateofsiblingsadoptiondecree": null,
    "dateofsiblingsapplicablechildassessment": "2021-02-08T16:31:51.981472",
    "dtofsiblingsadoptiondecree": null,
    "adpsiblingname": null,
    "siblingadoptionstatus": null
  }
]' where clientid = 4194660 and removalid = 189385 and activeflag = 1;

-- CDM-10099
update adoptionapplicabilityinfo set siblinginformationcheck = true where clientid = 2894449 and activeflag = 1;