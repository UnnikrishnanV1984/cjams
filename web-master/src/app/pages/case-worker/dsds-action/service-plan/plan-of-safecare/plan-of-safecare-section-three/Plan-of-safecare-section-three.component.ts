import { Component, OnInit } from "@angular/core";
import { FormBuilder, FormGroup } from "@angular/forms";
import { CASE_STORE_CONSTANTS, CASE_TYPE_CONSTANTS } from "../../../../../case-worker/_entities/caseworker.data.constants";
import { AlertService, CommonHttpService, DataStoreService } from "../../../../../../@core/services";
import { AppUser } from "../../../../../../@core/entities/authDataModel";
import moment from "moment";
import { ActivatedRoute, Router } from "@angular/router";
import { SharedService } from "../../_service/shared-service";

@Component({
    selector: 'plan-of-safecare-three',
    templateUrl: './Plan-of-safecare-section-three.component.html',
    styleUrls: ['./Plan-of-safecare-section-three.component.scss'],
    standalone: false
})
export class PlanOfSafeCareThreeComponent implements OnInit {

  plansecthreeForm!: FormGroup;
  newbornformgroup!: FormGroup;
  parentformgroup!: FormGroup ;
  Caregiverformgroup!: FormGroup;
  showmember!: boolean;
  index: any;
  showdetail = false;
  selectedmember: any[] = [];
  isupdate: boolean = false;
  isupdatechild: boolean = false;
  editform: boolean = false;
  selected = '';
  selectedref = '';
  isAdoptionCase!: boolean;
  intakeserviceid = '';
  personList!: any[];
  personListFilter: any[] = [];
  selectedClientName: string = '';
  personDataList!: any[];
  childList: any[] = [];
  personListName: any;
  legalGuardian = '';
  user!: AppUser;
  candidacyRoles: string[] = ['CHILD', 'OTHERCHILD', 'AV'];
  senChildList!: boolean;
  senAge!: boolean;
  healthneedsandref!: any[];
  parentsneedsandref?: any[];
  parentCollectionList: any[] = [];
  allmemberList: any[] = [];
  viewstat: boolean = false;
  id: any;
  daNumber: any;
  deletetype: any;
  deleteObject: any;
  motherstatus: any;
  sectiononedata!: any[];
  showparentdd!: boolean;
  showparentdd1!: boolean;
  showparentdd2!: boolean;
  showcaregiverdd!: boolean;
  shownewborntxt!: boolean;
  deceasedstatus: any = '';
  declinemember: any = '';
  familymembervalue: any = '';
  showparentform:boolean =true
  poscChildList!: any[];
  checkforrequired: boolean =false;
  isViewMode: boolean = false;
  isMemberInitialized = true;

  constructor(
    private  _formBuilder: FormBuilder,
    private _datastore: DataStoreService,
    private _commonhttp: CommonHttpService,
    private _alert: AlertService,
    private _router: Router,
    private route: ActivatedRoute,
    private _sharedService: SharedService
  ) {
    this.id = this._datastore.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.daNumber = this._datastore.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
  }


  ngOnInit(): void {
    this.getsectiononedata();
    this.getnewbornandparentneed();
    this.initplansecthreeform();
    this.initnewbornform();
    this.initparentform();
    this.initcaregiverform();
    this.poscChildList = this._datastore.getData('poscChildList');
    const caseType = this._datastore.getData(CASE_STORE_CONSTANTS.CASE_TYPE);
    this.intakeserviceid = this._datastore.getData(CASE_STORE_CONSTANTS.CASE_UID);

    if (caseType === CASE_TYPE_CONSTANTS.ADOPTION) {
      this.isAdoptionCase = true;
    }
    this.getInvolvedPerson();


  }

  getsectiononedata() {
    const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
    const aa = JSON.parse(generateObjectReqId);
    const seconelength = Object.keys(aa.persondetails)
    if (seconelength.length > 0) {
      this.sectiononedata = aa.persondetails.data;
    }
  }

  getnewbornandparentneed() {
    this.healthneedsandref = [{
      id: '1',
      label: "Exposure and Withdrawal",
      name: "exposurewithdrawl",
      referral: "exprefferal",
      referredto: "exprefferedto",
      refferraldate: "exprefferraldate",
      apptscheduled: "expapptscheduled",
      didnotattend: "expdidnotattend",
      comments: "expcomments",

    },

    {
      id: '2',
      label: "Developmental",
      name: "developmental",
      referral: "devrefferal",
      referredto: "devrefferedto",
      refferraldate: "devrefferraldate",
      apptscheduled: "devapptscheduled",
      didnotattend: "devdidnotattend",
      comments: "devcomments",

    },
    {
      id: '3',
      label: "Other Medical Conditions",
      name: "othermed",
      referral: "othermedrefferal",
      referredto: "othermedrefferedto",
      refferraldate: "othermedrefferraldate",
      apptscheduled: "othermedapptscheduled",
      didnotattend: "othermeddidnotattend",
      comments: "othermedcomments",

    },
    {
      id: '4',
      label: "Other Newborn Needs",
      name: "othernewbneeds",
      referral: "othnewbneedrefferal",
      referredto: "othnewbneedrefferedto",
      refferraldate: "othnewbneedrefferraldate",
      apptscheduled: "othneedmedapptscheduled",
      didnotattend: "othbneedmeddidnotattend",
      comments: "otherneedcomments",

    }
    ];

    this.parentsneedsandref = [
      {
        id: '1',
        label: "PADS Assessment",
        name: "aodassessment",
        consent: "aodconsentobtained",
        referral: "aodreferral",
        referredto: "refertoaod",
        referraldate: "aodrefdate",
        apptattended: "aodapptattend",
        reasonfornotattend: "aodreasnforattnd",
        comments: "aodcomments",

      },
      {
        id: '2',
        label: "Recovery Coach/Peer Mentor",
        name: "rcpmassessment",
        consent: "rcpmconsentobtained",
        referral: "rcpmreferral",
        referredto: "rcpmrefferedto",
        referraldate: "rcpmdateofref",
        apptattended: "rcpmapptattend",
        reasonfornotattend: "rcpmreasnforattnd",
        comments: "rcpmcomments",

      },
      {
        id: '3',
        label: "Substance Use Disorder Treatment Services",
        name: "subuseassessment",
        consent: "subuseconsentobtained",
        referral: "subusereferral",
        referredto: "subuserefferedto",
        referraldate: "subusedateofref",
        apptattended: "subuseapptattend",
        reasonfornotattend: "subusereasnforattnd",
        comments: "subusecomments",
      },
      {
        id: '4',
        label: "Mental Health Services",
        name: "mhsassessment",
        consent: "mhsconsentobtained",
        referral: "mhsreferral",
        referredto: "mhsrefferedto",
        referraldate: "mhsdateofref",
        apptattended: "mhsapptattend",
        reasonfornotattend: "mhsreasnforattnd",
        comments: "mhscomments",
      },
      {
        id: '5',
        label: "Parenting Skills/ Attachment/Bonding",
        name: "parskillassessment",
        consent: "parskillconsentobtained",
        referral: "parskillreferral",
        referredto: "parskillrefferedto",
        referraldate: "parskilldateofref",
        apptattended: "parskillapptattend",
        reasonfornotattend: "parskillreasnforattnd",
        comments: "parskillcomments",
      },
    ];
  }
  initparentform() {
    this.parentformgroup = this._formBuilder.group({
      personname: [''],
      personpid: [''],
      persondob: [''],
      personid: [''],
      aodassessment: [''],
      aodconsentobtained: [''],
      aodreferral: [''],
      refertoaod: [''],
      aodrefdate: [''],
      aodapptattend: [''],
      aodreasnforattnd: [''],
      aodcomments: [''],

      subuseassessment: [''],
      subuseconsentobtained: [''],
      subusereferral: [''],
      subuserefferedto: [''],
      subusedateofref: [''],
      subuseapptattend: [''],
      subusereasnforattnd: [''],
      subusecomments: [''],

      rcpmassessment: [''],
      rcpmconsentobtained: [''],
      rcpmreferral: [''],
      rcpmrefferedto: [''],
      rcpmdateofref: [''],
      rcpmapptattend: [''],
      rcpmreasnforattnd: [''],
      rcpmcomments: [''],

      mhsassessment: [''],
      mhsconsentobtained: [''],
      mhsreferral: [''],
      mhsrefferedto: [''],
      mhsdateofref: [''],
      mhsapptattend: [''],
      mhsreasnforattnd: [''],
      mhscomments: [''],

      parskillassessment: [''],
      parskillconsentobtained: [''],
      parskillreferral: [''],
      parskillrefferedto: [''],
      parskilldateofref: [''],
      parskillapptattend: [''],
      parskillreasnforattnd: [''],
      parskillcomments: [''],

      noService: [''],
      noServiceReason: [''],
    });
  }

    onParentValueChage() {
        let valueExists = false;
        Object.keys(this.parentformgroup.controls).forEach(controler => {
        let ctrl = ['personname', 'personpid', 'persondob', 'personid','noService', 'noServiceReason']
            if (!ctrl.includes(controler)) {
                let value = this.parentformgroup.controls[controler].value
                if (value) {
                    valueExists = true;
                }
            }
        });

        if (valueExists) {
            this.parentformgroup.get('noService')?.disable();
            this.parentformgroup.get('noServiceReason')?.disable();
        } else {
            this.parentformgroup.get('noService')?.enable();
            this.parentformgroup.get('noServiceReason')?.enable();
        }
    }
  
  onPatientFormReferal(event: any) {
    if(event.target.checked) {
        Object.keys(this.parentformgroup.controls).forEach(controler => {
            if(!['noService', 'noServiceReason'].includes(controler)){
                this.parentformgroup.get(controler)?.disable();
            }
        });
    } else {
        Object.keys(this.parentformgroup.controls).forEach(controler => {
            if(!['noService', 'noServiceReason'].includes(controler)){
                this.parentformgroup.get(controler)?.enable();
            }
        });
    }
  }

  initcaregiverform() {
    this.Caregiverformgroup = this._formBuilder.group({
      caregivername: [''],

    })
  }
  initplansecthreeform() {
    this.plansecthreeForm = this._formBuilder.group({
      familymember: [''],
      personid: ['']


    });
    const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
    const secThreedata = JSON.parse(generateObjectReqId);
    this.isViewMode = secThreedata.isViewMode;
    this.allmemberList = secThreedata.healthneedsdetails.memberform ? secThreedata.healthneedsdetails.memberform : [];
  }
  initnewbornform() {
    this.newbornformgroup = this._formBuilder.group({
      personname: [''],
      personpid: [''],
      persondob: [''],
      personid: [''],
      newborndropdwn: [''],
      exposurewithdrawl: [''],
      exprefferal: [''],
      exprefferedto: [''],
      exprefferraldate: [''],
      expapptscheduled: [''],
      expdidnotattend: [''],
      expcomments: [''],
      developmental: [''],
      devrefferal: [''],
      devrefferedto: [''],
      devrefferraldate: [''],
      devapptscheduled: [''],
      devdidnotattend: [''],
      devcomments: [''],
      othermed: [''],
      othermedrefferal: [''],
      othermedrefferedto: [''],
      othermedrefferraldate: [''],
      othermedapptscheduled: [''],
      othermeddidnotattend: [''],
      othermedcomments: [''],
      othernewbneeds: [''],
      othnewbneedrefferal: [''],
      othnewbneedrefferedto: [''],
      othnewbneedrefferraldate: [''],
      othneedmedapptscheduled: [''],
      othbneedmeddidnotattend: [''],
      otherneedcomments: [''],

      noService: [''],
      noServiceReason: [''],
    });

  }

    onNewBornValueChage() {
        let valueExists = false;
        Object.keys(this.newbornformgroup.controls).forEach(controler => {
            let ctrl = ['personname', 'personpid', 'persondob', 'personid', 'noService', 'noServiceReason']
            if (!ctrl.includes(controler)) {
                let value = this.newbornformgroup.controls[controler].value
                if (value) {
                    valueExists = true;
                }
            }
        });

        if (valueExists) {
            this.newbornformgroup.patchValue({
                noService: '',
                noServiceReason: '',
            });
            this.newbornformgroup.get('noService')?.disable();
            this.newbornformgroup.get('noServiceReason')?.disable();
        } else {
            this.newbornformgroup.get('noService')?.enable();
            this.newbornformgroup.get('noServiceReason')?.enable();
        }
    }

    onNewBornFormReferal(event: any) {
        if (event.target.checked) {
            Object.keys(this.newbornformgroup.controls).forEach(controler => {
                if (!['personname', 'personpid', 'persondob', 'personid', 'noService', 'noServiceReason'].includes(controler)) {
                    this.newbornformgroup.get(controler)?.setValue('');
                    this.newbornformgroup.get(controler)?.disable();
                }
            });
        } else {
            Object.keys(this.newbornformgroup.controls).forEach(controler => {
                if (!['personname', 'personpid', 'persondob', 'personid', 'noService', 'noServiceReason'].includes(controler)) {
                    this.newbornformgroup.get(controler)?.enable();
                }
            });
        }
    }

  getInvolvedPerson() {
    let inputRequest = {};
    const isServiceCase = this._datastore.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
    if (isServiceCase || this.isAdoptionCase) {
      inputRequest = {
        objectid: this.intakeserviceid,
        objecttypekey: 'servicecase',
        includecaregiver: true,
        personids: this.poscChildList.map(item => item.personid)
      };
    } else {
      inputRequest = {
        intakeserviceid: this.intakeserviceid
      };
    }
    const payload = {
      method: 'get',
      count: -1,
      page: 1,
      limit: 100,
      nolimit: true,
      where: inputRequest
    };


    this._commonhttp.getPagedArrayList(payload, 'People/getpersondetail?filter').subscribe(
      response => {
        this.personList = response.data;
        this.personListFilter = response.data;
        if (response.data && response.data.length) {
          this.checkPersonDetail(response);
        }

      });
  }
  checkPersonDetail(response: any) {
    response.data.forEach((person: any) => {
      this.personDataList && this.personDataList.push({ 'name': this.getFullName(person) });
      let obj;
      if (person.roles) {
        person.roles.some((role: any) => {
          if (this.candidacyRoles.includes(role.intakeservicerequestpersontypekey)) {
            obj = {
              'id': person.cjamspid,
              'personid': person.personid,
              'name': this.getFullName(person),
              'candidacy': null,
              'programarea': person.programarea,
              'ishousehold': person.ishousehold
            };
            this.childList.push(obj);
            return true;
          }
          if (role.intakeservicerequestpersontypekey === 'LG') {
            this.legalGuardian = this.getFullName(person);
          }
        });
      }
    });
    if (this.user && this.user.user && this.user.user.userprofile && this.user.user.userprofile.displayname) {
      this.personDataList.push({ 'name': this.user.user.userprofile.displayname });
    }
    if (this.personDataList && this.personDataList.length) {
      this.personListName = this.personDataList[0].name;
    }
  }
  getFullName(person: any) {
    const nameKeys = ['prefx', 'firstname', 'middlename', 'lastname', 'suffix'];
    let name = '';
    nameKeys.forEach(key => {

      if (person && person.hasOwnProperty(key)) {
        if (person[key] && person[key] != 'null') {
          name = name + person[key] + ' ';

        }
      }
    });

    return name;
  }

  getClientNameList(id: any, list: any) {

    if (this.plansecthreeForm.getRawValue().familymember === null || this.plansecthreeForm.getRawValue().familymember === '') {
      this.plansecthreeForm.patchValue({
        personid: null
      })
      return;
    }

    const selectPersonList = list.find((f: { personid: any; }) => f.personid === id);
    this.selectedClientName = selectPersonList?.fullname || '';
    if (this.selected == 'Parent') {
      this.checkdeclinemember(this.selectedClientName);
    }

    this.setfamilymembervalue(this.selectedClientName);
    this.newbornformgroup.patchValue({
      persondob: moment(selectPersonList.dob).format('MM-DD-YYYY'),
      personname: selectPersonList.fullname,
      personpid: selectPersonList.cjamspid,
      personid : selectPersonList.personid

    });
    this.parentformgroup?.patchValue({
      persondob: moment(selectPersonList.dob).format('MM-DD-YYYY'),
      personname: selectPersonList.fullname,
      personpid: selectPersonList.cjamspid,
      personid : selectPersonList.personid,
    });
    this.onParentValueChage();
  }
  checkdeclinemember(personname: any) {
    this.sectiononedata.forEach((obj) => {
      if (obj.personName === personname) {
        this.declinemember = obj.declinemember;
      }

    })
  }
  setfamilymembervalue(personname: any) {

    this.sectiononedata.forEach((obj) => {
      if (obj.personName === personname) {
        this.familymembervalue = obj.familymember;
      }

    })


  }
    validateparentformgroup(data: any) {
        if(
           !data.aodassessment &&
           !data.rcpmassessment &&
           !data.subuseassessment &&
           !data.mhsassessment &&
           !data.parskillassessment &&
           !data.noService
            ) {
                return false;
        }
        if (
            (data.aodconsentobtained && !data.aodassessment) ||
            (data.rcpmconsentobtained && !data.rcpmassessment) ||
            (data.subuseconsentobtained && !data.subuseassessment) ||
            (data.mhsconsentobtained && !data.mhsassessment) ||
            (data.parskillconsentobtained && !data.parskillassessment)
        ) {
            return false;
        }
        return true;
    }
    saveparentform() {
        this.checkforrequired = true

        let data  = this.parentformgroup.getRawValue();
        
        if (this.parentformgroup.valid && this.validateparentformgroup(data)) {
            const parentobj = {
                "id": this.allmemberList.length == 0 ?
                    this.allmemberList.length + 1 : this.allmemberList[this.allmemberList.length - 1].id + 1,
                "familymember": this.plansecthreeForm.controls['familymember'].value,
                "familymembervalue": this.familymembervalue,
                "personname": this.parentformgroup.controls['personname'].value,
                "personid": this.parentformgroup.controls['personid'].value,
                "persondob": this.parentformgroup.controls['persondob'].value,
                "declinemember": this.declinemember,
                "data": data,

            }
            if (this.isupdate) {
                this.allmemberList.splice(this.index, 1);

            }
            this.allmemberList.push(parentobj);


            const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
            const aa = JSON.parse(generateObjectReqId);
            const sectionobj = {
                "sectionThree": {
                    "memberform": this.allmemberList
                }
            }
            aa.healthneedsdetails = sectionobj.sectionThree;
            localStorage.setItem('generateObjectReq', JSON.stringify(aa));
            this.showmember = false;
            this.memberReset();
        }
        else {
            this._alert.error('Please fill atleast one of the Needs and Referrals');
        }
    }
    validatenewbornformp(data: any) {
        if(
           !data.exposurewithdrawl &&
           !data.developmental &&
           !data.othermed &&
           !data.othernewbneeds &&
           !data.aodassessment &&
           !data.noService
            ) {
                return false;
        }
        return true;
    }
  savenewbornform() {
    this.checkforrequired = true;
    let data  = this.newbornformgroup.getRawValue();
    if(this.newbornformgroup.valid && this.validatenewbornformp(data)){
      const newbornobj = {
      // "id" : this.allmemberList.length == 0 ? 
      // this.allmemberList.length + 1:this.allmemberList[this.allmemberList.length - 1].id + 1,
      "familymember": this.plansecthreeForm.controls['familymember'].value,
      "familymembervalue": this.familymembervalue,
      "personname": this.newbornformgroup.controls['personname'].value,
      "persondob": this.newbornformgroup.controls['persondob'].value,
      "personid": this.newbornformgroup.controls['personid'].value,
      "data": this.newbornformgroup.getRawValue(),

    }
    if (this.isupdatechild) {
      this.allmemberList.splice(this.index, 1);
    }
    this.allmemberList.push(newbornobj);

    const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
    const aa = JSON.parse(generateObjectReqId);
    const sectionobj = {
      "sectionThree": {
        "memberform": this.allmemberList
      }
    }
    aa.healthneedsdetails = sectionobj.sectionThree;
    localStorage.setItem('generateObjectReq', JSON.stringify(aa));
    this.memberReset();
    this.showmember=false;
  }
  else{
    this._alert.error('Please fill atleast one of the Needs and Referrals');
  }


  }


  editMember(member: any, viewstatus: any, index: any) {
    if(this.isViewMode && viewstatus=='edit'){
      return;
    }
    this.showmember =true;
    this.index = index;
    this.familymembervalue = member.familymembervalue;
    this.showparentform =false;
    if (viewstatus === 'view') {
      this.newbornformgroup.disable();
      this.parentformgroup?.disable();
      this.plansecthreeForm.disable();

    }
    else {
      this.newbornformgroup.enable();
      this.plansecthreeForm.controls['familymember'].disable();
      this.plansecthreeForm.controls['personid'].disable();

    }
    const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
    const section3: any = JSON.parse(generateObjectReqId);
    this.selectedmember = section3.healthneedsdetails.memberform;
    this.selected = this.selectedmember[index].familymember;
     this.plansecthreeForm.patchValue({
      familymember: this.selectedmember[index].familymember
     
    });
    this.plansecthreeForm.patchValue({personid:this.selectedmember[index].personname});
    if(this.selectedmember[index].data.personpid !== '') {
      this.getClientNameList(this.selectedmember[index].personid,this.personListFilter);
      this.selectedClientName =this.selectedmember[index].personname
      this.plansecthreeForm.patchValue({personid:this.selectedmember[index].personname});

    }
   
    
    if (this.selected === 'Parent' || this.selected === "Caregiver") {
      this.isupdate = true;
      const parentdata = this.selectedmember[index].data
      this.parentformgroup?.patchValue(parentdata);
    }
    if (this.selected === 'Newborn') {
      this.isupdatechild = true;
      const newborndata = this.selectedmember[index].data
      this.newbornformgroup.patchValue(newborndata);
    }
  }


  confirmDelete(type: any, item: any, index: any) {
    if(this.isViewMode){
      return;
    }
    this.deletetype = type;
    this.deleteObject = item;
    this.index = index;
    (<any>$('#delete-popup')).modal('show');
  }

  deleteItem() {

    this.allmemberList.splice(this.index, 1);
    const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
    const aa = JSON.parse(generateObjectReqId);
    const sectionobj = {
      "sectionThree": {
        "memberform": this.allmemberList
      }
    }
    aa.healthneedsdetails = sectionobj.sectionThree;
    localStorage.setItem('generateObjectReq', JSON.stringify(aa));

  }
  memberReset() {
    this.isupdate = false;
    this.isupdatechild = false;
    this.selected = '';
    this.selectedClientName = ''
    this.familymembervalue = '';
    this.showparentform = true;
    this.plansecthreeForm.reset();
    this.parentformgroup?.reset();
    this.newbornformgroup.reset();
    this.plansecthreeForm.enable();
    this.parentformgroup?.enable();
    this.newbornformgroup.enable();
    this.checkforrequired =false;
    this.isMemberInitialized = true;
  }
  familymemberchange(e: any) {
    this.selectedClientName = ''
    const personListFilter1 = this.personList.filter((plf) => {
      return this.sectiononedata?.some((sonedate) => {
        return sonedate.personid === plf.personid;
      })
    })
    if (e.value == 'Parent') {
      this.showparentdd = true;
      this.showcaregiverdd = false;
      this.personListFilter = personListFilter1.filter((obj) => {
        return obj.userroles.toLowerCase().includes('parent');
      });

      if (this.personListFilter.length > 0) {
        const res1 = this.allmemberList.filter(f => f.familymember.includes('Parent'));
        if (res1.length > 0) {
          const res = this.personListFilter.filter(entry1 => !res1.some(entry2 => entry1.fullname === entry2.personname));
          this.personListFilter = res;
        }
      }
    } else if (e.value == 'Caregiver') {
      this.showcaregiverdd = true;
      this.showparentdd = false;
      this.personListFilter = personListFilter1.filter((obj) => {
        return (obj.iscaregiver === true || obj.userroles.toLowerCase().includes('caregiver') || obj.userroles.toLowerCase().includes('legal guardian'));
      });

      if (this.personListFilter.length > 0) {
        const res1 = this.allmemberList.filter(f => f.familymember.includes('Caregiver'));
        if (res1.length > 0) {
          const res = this.personListFilter.filter(entry1 => !res1.some(entry2 => entry1.fullname === entry2.personname));
          this.personListFilter = res;
        }
      }

    } else {
      this.otherfamilymemberchange(personListFilter1);
    }
  }

  otherfamilymemberchange(personListFilter1: any) {
    this.showcaregiverdd = false;
    this.showparentdd = false;
    this.personListFilter = personListFilter1.filter((obj: any) => {
      return obj.userroles.toLowerCase().includes('child');
    });

    if (this.personListFilter.length > 0) {
      const res1 = this.allmemberList.filter(f => f.familymember.includes('Newborn'));
      if (res1.length > 0) {
        const res = this.personListFilter.filter(entry1 => !res1.some(entry2 => entry1.fullname === entry2.personname));
        this.personListFilter = res;
      }
    }
  }

  saveSectionDetail() {
    const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
    const aa = JSON.parse(generateObjectReqId);
    const sectionobj = {
      "sectionThree": {
        "memberform": this.allmemberList
      }
    }
    aa.healthneedsdetails = sectionobj.sectionThree;
    localStorage.setItem('generateObjectReq', JSON.stringify(aa));
    const url = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/service-plan/plan-of-safecare' + '/section-four'
    this._router.navigate([url], { relativeTo: this.route });
    this._sharedService.emitChange("SectionFour");

    this.memberReset();
  }
  goToPrevious() {
    const url = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/service-plan/plan-of-safecare' + '/section-two'
    this._router.navigate([url], { relativeTo: this.route });
    this._sharedService.emitChange("SectionTwo");
  }

}