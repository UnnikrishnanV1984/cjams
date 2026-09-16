import { Component, Injector} from "@angular/core";
import { FormArray, FormBuilder, FormControl, FormGroup, Validators } from "@angular/forms";
import { CASE_STORE_CONSTANTS, CASE_TYPE_CONSTANTS } from "../../../../../case-worker/_entities/caseworker.data.constants";
import { AlertService, AuthService, CommonHttpService, DataStoreService } from "../../../../../../@core/services";
import { AppUser } from "../../../../../../@core/entities/authDataModel";
import moment from "moment";
import { ActivatedRoute, Router } from "@angular/router";
import { SharedService } from "../../_service/shared-service";


@Component({
    selector: 'plan-of-safecare-sectionone',
    templateUrl: './plan-of-safecare-section-one.component.html',
    styleUrls: ['./plan-of-safecare-section-one.component.scss'],
    standalone: false
})

export class PlanofSafecareSectionOneComponent {

    planseconeForm!: FormGroup;
    memberForm!: FormGroup;
    isAdoptionCase!: boolean;
    intakeserviceid = '';
    personList!: any[];
    personListFilter!: any[];
    senChildList!: any[];
    selectedClientName: string = '';
    personDataList: any[] = [];
    childList: any[] = [];
    personListName: any;
    legalGuardian = '';
    user!: AppUser;
    showmember!: boolean;
    candidacyRoles: string[] = ['CHILD', 'OTHERCHILD', 'AV'];
    selected = '';
    selectedCheckbox: any[] = [];
    memberCollectionList : any[] = [];
    deletetype: any;
    deleteObject: any;
    sectionobj :any;
    otherCategoryRequired!: boolean;
    poscChildList!: any[];
    CheckboxOpioidsList: Array<any> = [
        {
            id: '1',
            label: 'Heroin/Schedule I',
            ischecked: false
        },
        {
            id: '2',
            label: 'Hydrocodone/Schedule II',
            ischecked: false
        },
        {
            id: '3',
            label: 'Buprenorphine/Schedule II',
            ischecked: false
        },
        {
            id: '4',
            label: 'Morphine/Schedule II',
            ischecked: false
        },
        {
            id: '5',
            label: 'Fentanyl/Schedule II',
            ischecked: false
        },
        {
            id: '6',
            label: 'Oxycodone/Schedule II',
            ischecked: false
        },
        {
            id: '7',
            label: 'Oxycodone-Percocet/Schedule II',
            ischecked: false
        },
        {
            id: '8',
            label: 'OxyContin/Schedule II',
            ischecked: false
        },
        {
            id: '9',
            label: 'Codeine/Schedule II',
            ischecked: false
        },
        {
            id: '10',
            label: 'Methadone/Schedule II',
            ischecked: false
        }
      ];
    CheckboxStimulantsList :Array<any> = [
        {
            id: '11',
            label: 'Cocaine/Schedule II',
            ischecked: false
        },
        {
            id: '12',
            label: 'Methamphetamine/Schedule II',
            ischecked: false
        },
        {
            id: '13',
            label: 'Methylphenidate (Ritalin)/Schedule II',
            ischecked: false
        },
        {
            id: '14',
            label: 'Amphetamine/Schedule II',
            ischecked: false
        },
        {
            id: '15',
            label: 'Adderall',
            ischecked: false
        },
        {
            id: '16',
            label: 'Vyvanse',
            ischecked: false
     }]
     CheckboxDepressantsList: Array<any> = [ {
        id: '17',
        label: 'Benzodiazepine/Schedule IV',
        ischecked: false
    },
    {
        id: '18',
        label: 'Valium',
        ischecked: false
    },
    {
        id: '19',
        label: 'Xanax',
        ischecked: false
    },
    {
        id: '20',
        label: 'Barbiturates',
        ischecked: false
    },
    {
        id: '21',
        label: 'Alcohol',
        ischecked: false
    }]
     CheckboxHallucinogensList : Array<any> = [{
        id: '22',
        label: 'Marijuana/Schedule I',
        ischecked: false
    },
    {
        id: '23',
        label: 'Amphetamine/Schedule I- Ecstasy',
        ischecked: false
    },
    {
        id: '24',
        label: 'LSD/Schedule I',
        ischecked: false
    },
    {
        id: '25',
        label: 'Ketamine/Schedule III',
        ischecked: false
    },
    {
        id: '26',
        label: 'Phencyclidine (PCP)/Schedule II',
        ischecked: false
    },
    {
        id: '27',
        label: 'Other',
        ischecked: false
    }]

    daNumber: any;
    id: any;
    showAdd : boolean = true;
    editId: any;
    showparentdd!: boolean;
    showparentdd1!: boolean;
    showparentdd2!: boolean;
    showcaregiverdd!: boolean;
    shownewborntxt!: boolean;
    disableSave: boolean = false;
    checkforrequired: boolean =false;
    isViewMode: boolean = false;
    private _formBuilder: FormBuilder;
    private _datastore: DataStoreService;
    private _commonhttp: CommonHttpService;
    private _router:Router;
    private route: ActivatedRoute;
    private _alert: AlertService;
    private _sharedService : SharedService;
    public _authService: AuthService
    constructor(private injector : Injector) {
        this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._datastore = this.injector.get<DataStoreService>(DataStoreService);
        this._commonhttp = this.injector.get<CommonHttpService>(CommonHttpService);
        this._router = this.injector.get<Router>(Router);
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this._alert = this.injector.get<AlertService>(AlertService);
        this._sharedService = this.injector.get<SharedService>(SharedService);
        this._authService = this.injector.get<AuthService>(AuthService);

        this.id = this._datastore.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._datastore.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
     }

    ngOnInit() {
        this.initSectionOneForm();
        this.initmemberForm();
        this.poscChildList = this._datastore.getData('poscChildList');
        const userDetails = this._authService.getCurrentUser();
        this.planseconeForm.patchValue(userDetails.user);
        this.planseconeForm.patchValue({
            name : userDetails.user.userprofile.fullname,
            unit : userDetails.user.userprofile.teammemberassignment.teammember.team.name,
            phoneno : userDetails.user.userprofile.userprofilephonenumber[0]?.phonenumber

        })
        const caseType = this._datastore.getData(CASE_STORE_CONSTANTS.CASE_TYPE);
        this.intakeserviceid = this._datastore.getData(CASE_STORE_CONSTANTS.CASE_UID);

        if (caseType === CASE_TYPE_CONSTANTS.ADOPTION) {
            this.isAdoptionCase = true;
        }
        this.getInvolvedPerson();
        const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
        const aa = JSON.parse(generateObjectReqId);
        this.isViewMode = aa.isViewMode;
        const seconelength = Object.keys(aa.persondetails)
        if(seconelength.length > 0)
        {
            this.planseconeForm.patchValue(aa.persondetails.ldss);
            this.memberCollectionList = aa.persondetails.data;
        }
    }

    updatePersonDetails() {
        let memberCollectionList = [];
        for(let member of this.memberCollectionList) {
            let person = this.personListFilter.filter(item => item.personid == member.personid);
            member.senStatusFlag = person[0]?.senstatusflag  || 0;
            memberCollectionList.push(member);
        }
        const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
        const aa = JSON.parse(generateObjectReqId);
        const sectionobj = {
            "sectionOne": {
                ldss: aa.persondetails.ldss,
                "data": memberCollectionList
            }
        }
        this.memberCollectionList = memberCollectionList;

        aa.persondetails = sectionobj.sectionOne;
        localStorage.setItem('generateObjectReq', JSON.stringify(aa));
   }

    initSectionOneForm() {
        this.planseconeForm = this._formBuilder.group({
            safecareplandate:[{value: new Date(), disabled: true}],
            name: [''],
            unit: [''],
            phoneno: [''],
            email: ['']

        });
       this.planseconeForm.disable();
    }

    initmemberForm() {
        this.memberForm = this._formBuilder.group({
            familymember: ['', Validators.required],
            personid: ['', Validators.required],
            memberDob: [''],
            memberAddress: [''],
            declinemember : [''],
            homelessmember : [''],
            dobdeclinemember: [''],
            declinememberphonenumber: [''],
            phonenumber : [''],
            selectedOpioids:  new FormArray([]),
            selectedStimulants:  new FormArray([]),
            selectedDepressants:  new FormArray([]),
            selectedHallucinogens:  new FormArray([]),
            othercategory : [null],
            substanceUse: new FormControl(false),
        });
    }

    getInvolvedPerson() {
        let inputRequest = {};
        const isServiceCase = this._datastore.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        if (isServiceCase || this.isAdoptionCase) {
            inputRequest = {
                objectid: this.intakeserviceid,
                objecttypekey: 'servicecase',
                includecaregiver: true,
                personids: this.poscChildList && this.poscChildList.map(item => item.personid)
            };
        } else {
            inputRequest = {
                intakeserviceid: this.intakeserviceid,
                personids: this.poscChildList && this.poscChildList.map(item => item.personid)
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
                this.senChildList = response.data.filter(item => item.drugexposednewbornflag === 1 && item.dobtdiffwithincidentdate <= 65);
                this.personListFilter = response.data;
                this.updatePersonDetails();
                if (response.data && response.data.length) {
                    this.checkPersonDetails(response);
                }
            });
    }

    onSubStanceChage(event: Event) {
        const input = event.target as HTMLInputElement;

        if (input.checked) {
            let ids = [...this.CheckboxOpioidsList, ...this.CheckboxStimulantsList, ...this.CheckboxDepressantsList, ...this.CheckboxHallucinogensList];
            ids.forEach(item => {
                $(`#${item.id}`).prop('disabled', true);
            });
            this.memberForm.controls['othercategory'].disable();
        } else {
            let ids = [...this.CheckboxOpioidsList, ...this.CheckboxStimulantsList, ...this.CheckboxDepressantsList, ...this.CheckboxHallucinogensList];
            ids.forEach(item => {
                $(`#${item.id}`).prop('disabled', false);
            });
            this.memberForm.controls['othercategory'].enable();
        }
    }
    checkPersonDetails(response: any) {
        response.data.forEach((person: any) => {
            this.personDataList.push({ 'name': this.getFullName(person) });
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
    getClientNameList(id: any, list: any) {

        if(this.memberForm.getRawValue().familymember === null || this.memberForm.getRawValue().familymember === '') {
            this._alert.error('Please select a value from the family member drop down');
            this.memberForm.patchValue({
                personid : null
            })
            return;
        }

        const selectPersonList = list.find((f: { personid: any; }) => f.personid === id);
        this.selectedClientName = selectPersonList.fullname;
        let address = selectPersonList.address;
        if(selectPersonList.address2 && selectPersonList.address2 !== '') {
            address = address + ', ' + selectPersonList.address2
        }
        if(selectPersonList.city && selectPersonList.city !== '') {
            address = address + ', ' + selectPersonList.city
        }
        if(selectPersonList.state && selectPersonList.state !== '') {
            address = address + ', ' + selectPersonList.state
        }
        if(selectPersonList.zipcode && selectPersonList.zipcode !== '') {
            address = address + ' - ' + selectPersonList.zipcode
        }
        // this.memberForm.patchValue
        this.memberForm.patchValue({
            memberDob: moment(selectPersonList.dob).format('MM-DD-YYYY'),
            memberAddress: address,
            phonenumber : selectPersonList.phonenumber
        });

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

    memberReset() {
        this.showAdd = true;
        this.resetControl();
        this.showparentdd = false;
        this.showcaregiverdd = false;
        this.checkforrequired =false;

    }


    getSelectedCheckbox(obj: any, e: any) {
        if (e.target.checked) {
            obj.ischecked = true;
            this.selectedCheckbox.push(obj);
        }
        else {
            const index = this.selectedCheckbox.indexOf(obj);
            this.selectedCheckbox.splice(index, 1);
        }

    }

    substanceUseControlChage() {
        let selectedOpioids = (this.memberForm.controls['selectedOpioids'] as FormArray);
        let selectedStimulants = (this.memberForm.controls['selectedStimulants'] as FormArray);
        let selectedDepressants = (this.memberForm.controls['selectedDepressants'] as FormArray);
        let selectedHallucinogens = (this.memberForm.controls['selectedHallucinogens'] as FormArray);
        if(selectedOpioids.controls.length || selectedStimulants.controls.length || selectedDepressants.controls.length || selectedHallucinogens.controls.length) {
            this.memberForm.get('substanceUse')?.setValue(false);
            this.memberForm.controls['substanceUse'].disable();
        } else {
            this.memberForm.controls['substanceUse'].enable();
        }

    }
    onCheckboxOpioidsChange(event: any) {
        const selectedOpioids = (this.memberForm.controls['selectedOpioids'] as FormArray);
        if (event.target.checked) {
            selectedOpioids.push(new FormControl(event.target.value));


        } else {
          const index = selectedOpioids.controls
          .findIndex(x => x.value === event.target.value);
          selectedOpioids.removeAt(index);
        }
        this.substanceUseControlChage();
    }
    onCheckboxStimulantChange(event: any) {
        const selectedStimulants = (this.memberForm.controls['selectedStimulants'] as FormArray);
        if (event.target.checked) {
            selectedStimulants.push(new FormControl(event.target.value));
        } else {
          const index = selectedStimulants.controls
          .findIndex(x => x.value === event.target.value);
          selectedStimulants.removeAt(index);
        }
        this.substanceUseControlChage();
    }
    onCheckboxDepressantsChange(event: any)
    {
        const selectedDepressants = (this.memberForm.controls['selectedDepressants'] as FormArray);
        if (event.target.checked) {
            selectedDepressants.push(new FormControl(event.target.value));
        } else {
          const index = selectedDepressants.controls
          .findIndex(x => x.value === event.target.value);
          selectedDepressants.removeAt(index);
        }
        this.substanceUseControlChage();
    }
    onCheckboxHallucinogensChange(event: any) {
        const selectedHallucinogens = (this.memberForm.controls['selectedHallucinogens'] as FormArray);
        if (event.target.checked) {
            selectedHallucinogens.push(new FormControl(event.target.value));
        } else {
          const index = selectedHallucinogens.controls
          .findIndex(x => x.value === event.target.value);
          selectedHallucinogens.removeAt(index);
        }

        if(event.target.checked && event.target.value === '27') {
            this.otherCategoryRequired = true;
        } else {
            this.otherCategoryRequired = false;
        }

        const selectedHallucinogensData = (this.memberForm.controls['selectedHallucinogens'] as FormArray);
        for (const item of selectedHallucinogensData.controls) {
            if(item.value === '27') {
                this.otherCategoryRequired = true;
            }
        }

        this.substanceUseControlChage();

    }

    addMember() {
        this.checkforrequired = true;
        this.showAdd = true;
        let person = this.personListFilter.filter(item => item.personid == this.memberForm.controls['personid'].value);
        const memberobj = {
            "id": this.memberCollectionList.length + 1,
            "familymember": this.memberForm.controls['familymember'].value,
            "memberAddress": this.memberForm.controls['memberAddress'].value,
            "memberDob": this.memberForm.controls['memberDob'].value,
            "declinemember": this.memberForm.controls['declinemember'].value,
            "homelessmember": this.memberForm.controls['homelessmember'].value,
            "phonenumber": this.memberForm.controls['phonenumber'].value,
            "dobdeclinemember": this.memberForm.controls['dobdeclinemember'].value,
            "declinememberphonenumber": this.memberForm.controls['declinememberphonenumber'].value,
            "personid": this.memberForm.controls['personid'].value,
            "personName": this.selectedClientName,
            "selectedOpioids": this.memberForm.controls['selectedOpioids'].value,
            "selectedStimulants": this.memberForm.controls['selectedStimulants'].value,
            "selectedDepressants": this.memberForm.controls['selectedDepressants'].value,
            "selectedHallucinogens": this.memberForm.controls['selectedHallucinogens'].value,
            "othercategory": this.memberForm.controls['othercategory'].value,
            "substanceUse": this.memberForm.controls['substanceUse'].value,
            "senStatusFlag": person[0]?.senstatusflag  || 0,
        }

        memberobj.selectedOpioids = memberobj.selectedOpioids.filter((item: any) => item !== null);
        memberobj.selectedStimulants = memberobj.selectedStimulants.filter((item: any) => item !== null);
        memberobj.selectedDepressants = memberobj.selectedDepressants.filter((item: any) => item !== null);
        memberobj.selectedHallucinogens = memberobj.selectedHallucinogens.filter((item: any) => item !== null);

        if (this.memberForm.invalid || (memberobj.selectedOpioids.length === 0 && memberobj.selectedStimulants.length === 0 && memberobj.selectedDepressants.length === 0 && memberobj.selectedHallucinogens.length === 0 && !this.memberForm.controls['substanceUse'].value)) {
            this._alert.error('Please fill all the required fields');
        } else {
            this.showmember = false;
            this.memberCollectionList.push(memberobj);
            this.setMemberIndexvalues();
            const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
            const aa = JSON.parse(generateObjectReqId);
            const sectionobj = {
                "sectionOne": {
                    "ldss": {
                        "safecareplandate": this.planseconeForm.controls['safecareplandate'].value,
                        "name": this.planseconeForm.controls['name'].value,
                        "unit": this.planseconeForm.controls['unit'].value,
                        "email": this.planseconeForm.controls['email'].value,
                        "phoneno": this.planseconeForm.controls['phoneno'].value,
                    },

                    "data": this.memberCollectionList
                }
            }
            aa.persondetails = sectionobj.sectionOne;
            localStorage.setItem('generateObjectReq', JSON.stringify(aa));
            this.resetControl();
        }
    }

    setMemberIndexvalues() {
        this.setParentIndexvalues();
        this.setCaregiverIndexvalues();
        this.setNewbornIndexvalues();
    }

    setParentIndexvalues() {
        const parentexistItem = this.memberCollectionList.filter(item => item.familymember.includes('Parent'));
        if (parentexistItem.length > 1) {
            this.memberCollectionList.forEach((item) => {
                parentexistItem.forEach((parent, index) => {
                    if (parent.personid == item.personid) {
                        index += 1;
                        item.familymember = "Parent " + index;
                    }

                });
            });
        }
        else {
            if (parentexistItem.length > 0) {
                const aa = this.memberCollectionList.findIndex(item => item.familymember.includes('Parent'));
                this.memberCollectionList[aa].familymember = 'Parent';

            }
        }
    }

    setCaregiverIndexvalues() {
        const caregiverexistItem = this.memberCollectionList.filter(item => item.familymember.includes('Caregiver'));
        if (caregiverexistItem.length > 1) {
            this.memberCollectionList.forEach((item) => {
                caregiverexistItem.forEach((parent, index) => {
                    if (parent.personid == item.personid) {
                        index += 1;
                        item.familymember = "Caregiver " + index;

                    }
                });
            });
        }
        else {
            if (caregiverexistItem.length > 0) {
                const aa = this.memberCollectionList.findIndex(item => item.familymember.includes('Caregiver'));
                this.memberCollectionList[aa].familymember = 'Caregiver';
            }
        }
    }

    setNewbornIndexvalues() {
        const newbornexistItem = this.memberCollectionList.filter(item => item.familymember.includes('Newborn'));
        if (newbornexistItem.length > 1) {
            this.memberCollectionList.forEach((item) => {
                newbornexistItem.forEach((parent, index) => {
                    if (parent.personid == item.personid) {
                        index += 1;
                        item.familymember = "Newborn " + index;

                    }
                });
            });
        }
        else {
            if (newbornexistItem.length > 0) {
                const aa = this.memberCollectionList.findIndex(item => item.familymember.includes('Newborn'));
                this.memberCollectionList[aa].familymember = 'Newborn';
            }
        }
    }

    resetControl() {
        this.memberForm.reset();
        let selectedOpioids = (this.memberForm.controls['selectedOpioids'] as FormArray);
        let selectedStimulants = (this.memberForm.controls['selectedStimulants'] as FormArray);
        let selectedDepressants = (this.memberForm.controls['selectedDepressants'] as FormArray);
        let selectedHallucinogens = (this.memberForm.controls['selectedHallucinogens'] as FormArray);
        selectedOpioids.clear();
        selectedStimulants.clear();
        selectedDepressants.clear();
        selectedHallucinogens.clear();
        this.resetCheckbox();
        this.selectedCheckbox = [];
        this.setMemberIndexvalues();
        this.memberForm.enable();
        this.otherCategoryRequired = false;
    }

    
  confirmDelete(type: any, item: any) {
      if(this.isViewMode){
          return;
      }
    this.deletetype = type;
    this.deleteObject = item;
    (<any>$('#delete-popup')).modal('show');
  }

    deleteItem() {
        this.memberCollectionList = this.memberCollectionList.filter(x => x.familymember !== this.deleteObject.familymember);
        this.setMemberIndexvalues();
        const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
        const aa = JSON.parse(generateObjectReqId);
        const sectionobj = {
            "sectionOne": {
                "ldss": {
                    "safecareplandate": this.planseconeForm.controls['safecareplandate'].value,
                    "name": this.planseconeForm.controls['name'].value,
                    "unit": this.planseconeForm.controls['unit'].value,
                    "email": this.planseconeForm.controls['email'].value,
                    "phoneno": this.planseconeForm.controls['phoneno'].value,
                },

                "data": this.memberCollectionList
            }
        }
        aa.persondetails = sectionobj.sectionOne;
        localStorage.setItem('generateObjectReq', JSON.stringify(aa));
        this.removeFromAllSections(this.memberCollectionList);
    }

    async removeFromAllSections(section1: any) {
        await this.removeAndUpdateSectionTwo(section1);
        await this.removeAndUpdateSectionThree(section1);
    }

    async removeAndUpdateSectionTwo(section1: any) {
        const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
        const aa = JSON.parse(generateObjectReqId);
        let section2 = aa.planparticipants?.data || {};

        let newBornPersons: any[] = [];
        section1.forEach((item: any) => {
            if(item.familymember.indexOf('Newborn') > -1) {
                newBornPersons.push(item.personid);
            }
        });

        let pcpDetails = section2?.pcpDetails || [];
        if(pcpDetails.length) {
            pcpDetails = pcpDetails.filter((item: any) => newBornPersons.indexOf(item.personid) > -1);
        }

        let notRequiredPCPDetails = section2?.notRequiredPCPDetails || [];
        if(notRequiredPCPDetails.length) {
            notRequiredPCPDetails = notRequiredPCPDetails.filter((item: any) => newBornPersons.indexOf(item.personid) > -1);
        }

        const sectionobj = {
            "sectionTwo": {
                "data": {
                    roleCollectionList: section2?.roleCollectionList,
                    pcpDetails: pcpDetails,
                    notRequiredPCPDetails: notRequiredPCPDetails,
                }
            }
        }
        aa.planparticipants = sectionobj.sectionTwo;
        localStorage.setItem('generateObjectReq', JSON.stringify(aa));
    }

    async removeAndUpdateSectionThree(section1: any) {
        const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
        const aa = JSON.parse(generateObjectReqId);
        let section3 = aa.healthneedsdetails?.memberform || [];

        let persons: any = [];
        section1.forEach((item: any) => {
            persons.push(item.personid)
        });

        let healthneedsdetails = section3.filter((item: any) => {
            let value = section1.filter((val: any) => val.personid == item.personid);
           if(persons.indexOf(item.personid) > -1) {
                item.familymembervalue = value[0].familymember;
                return item;
           }
        });

        const sectionobj = {
            "sectionThree": {
                "memberform": healthneedsdetails
            }
        }
        aa.healthneedsdetails = sectionobj.sectionThree;
        localStorage.setItem('generateObjectReq', JSON.stringify(aa));
    }

    editMember(item: any, type: any) {
        this.resetControl()
        if(this.isViewMode && type=='edit'){
            return;
        }
        this.showmember=true;
        this.showAdd = false;

        this.checkSelectedOpioids(item);
        this.checkSelectedStimulants(item);
        this.checkSelectedDepressants(item);
        this.checkSelectedHallucinogens(item);

        if(item.selectedDepressants.length || item.selectedHallucinogens.length || item.selectedOpioids.length || item.selectedStimulants.length) {
            this.memberForm.get('substanceUse')?.setValue(false);
            this.memberForm.controls['substanceUse'].disable();
        }

        item.familymember = item.familymember.split(' ')[0];
        this.memberForm.patchValue(item);
        this.personListFilter = this.personList.filter((obj) => {
            return obj.userroles.toLowerCase().includes(item.familymember.toLowerCase());
        });

        this.personListFilter = this.personList.filter((obj) => {
            return obj.userroles.toLowerCase().includes(item.familymember.toLowerCase());
        });


        if (item.familymember == "Newborn") {
            this.personListFilter = this.personList.filter((obj) => {
                return obj.userroles.toLowerCase().includes('child');
            });

        }

        if (item.familymember == "Caregiver") {
            this.personListFilter = this.personList.filter((obj) => {
                return (obj.iscaregiver === true || obj.userroles.toLowerCase().includes('caregiver') || obj.userroles.toLowerCase().includes('legal guardian'));
            });
        }
        this.getClientNameList(item.personid, this.personListFilter);
        this.editId = item.id;
        if (type == 'view') {
            this.memberForm.disable();
            this.disableSave = true;
        } else {
            this.disableSave = false;
        }

        if (item.familymember.includes('Parent')) {
            const obj = {
                "value": "Parent"
            }
            this.showreasonDropdown(obj);
        } else if (item.familymember.includes('Caregiver')) {
            const obj = {
                "value": "Caregiver"
            }
            this.showreasonDropdown(obj);
        } else {
            const obj = {
                "value": "New born"
            }
            this.showreasonDropdown(obj);
        }

        if(item.substanceUse) {
            let ids = [...this.CheckboxOpioidsList, ...this.CheckboxStimulantsList, ...this.CheckboxDepressantsList, ...this.CheckboxHallucinogensList];
            setTimeout(() => {
                ids.forEach(item1 => {
                    $(`#${item1.id}`).prop('disabled', true);
                });
                this.memberForm.controls['othercategory'].disable();
            }, 0);
        }
    }

    checkSelectedOpioids(items: any) {
        this.memberForm.setControl('selectedOpioids', new FormArray([]));
        const selectedOpioids = (this.memberForm.controls['selectedOpioids'] as FormArray);

        for (let opioisd of this.CheckboxOpioidsList) {
            for (let item of items.selectedOpioids) {
                if (opioisd.id == item) {
                    opioisd.ischecked = true;
                    selectedOpioids.push(new FormControl(items));
                }
            }
        }

        return selectedOpioids;
    }

    checkSelectedStimulants(items: any){
        this.memberForm.setControl('selectedStimulants', new FormArray([]));
        const selectedStimulants = (this.memberForm.controls['selectedStimulants'] as FormArray);

        for (let Stimulant of this.CheckboxStimulantsList) {
            for (let item of items.selectedStimulants) {
                if (Stimulant.id == item) {
                    Stimulant.ischecked = true;
                    selectedStimulants.push(new FormControl(items));
                }
            }
        }

        return selectedStimulants;

    }

    checkSelectedDepressants(items:any){
        this.memberForm.setControl('selectedDepressants', new FormArray([]));
        const selectedDepressants = (this.memberForm.controls['selectedDepressants'] as FormArray);

        for (let Depressant of this.CheckboxDepressantsList) {
            for (let item of items.selectedDepressants) {
                if (Depressant.id == item) {
                    Depressant.ischecked = true;
                    selectedDepressants.push(new FormControl(items));
                }
            }
        }

        return selectedDepressants;
    }

    checkSelectedHallucinogens(items: any){
        this.memberForm.setControl('selectedHallucinogens', new FormArray([]));
        const selectedHallucinogens = (this.memberForm.controls['selectedHallucinogens'] as FormArray);
        for (let HxHallucinogen of this.CheckboxHallucinogensList) {
            for (let item of items.selectedHallucinogens) {   //  NOSONAR //  loop used to items to selectedHallucinogens
                if (HxHallucinogen.id == item) {
                    HxHallucinogen.ischecked = true;
                    selectedHallucinogens.push(new FormControl(items));
                }
            }
        }

        return selectedHallucinogens;
    }


  updateMember()
  {
    let person = this.personListFilter.filter(item => item.personid == this.memberForm.controls['personid'].value);
    const memberobj = {
        "id" : this.editId,
        "familymember": this.memberForm.controls['familymember'].value,
        "memberAddress": this.memberForm.controls['memberAddress'].value,
        "memberDob": this.memberForm.controls['memberDob'].value,
        "personid": this.memberForm.controls['personid'].value,
        "personName" : this.selectedClientName,
        "selectedOpioids" : this.memberForm.controls['selectedOpioids'].value,
        "selectedStimulants" : this.memberForm.controls['selectedStimulants'].value,
        "selectedDepressants" : this.memberForm.controls['selectedDepressants'].value,
        "selectedHallucinogens" : this.memberForm.controls['selectedHallucinogens'].value,
        "othercategory" : this.memberForm.controls['othercategory'].value  ,
        "phonenumber" : this.memberForm.controls['phonenumber'].value,
         "declinemember" :this.memberForm.controls['declinemember'].value,
         "substanceUse": this.memberForm.controls['substanceUse'].value,
         "senStatusFlag": person[0]?.senstatusflag  || 0,
        }

        memberobj.selectedOpioids = memberobj.selectedOpioids.filter((item: any) => item !== null);
        memberobj.selectedStimulants =  memberobj.selectedStimulants.filter((item: any) => item !== null);
        memberobj.selectedDepressants = memberobj.selectedDepressants.filter((item: any) => item !== null);
        memberobj.selectedHallucinogens = memberobj.selectedHallucinogens.filter((item: any) => item !== null);

        if(memberobj.selectedOpioids.length === 0
            && memberobj.selectedStimulants.length === 0
            && memberobj.selectedDepressants.length === 0
            && memberobj.selectedHallucinogens.length === 0
            && !this.memberForm.controls['substanceUse'].value) {
            this._alert.error('Please select atleast one checkbox to proceed');
            return;
        }

        this.showmember=false

        const index = this.memberCollectionList.findIndex(x => x.id === this.editId);
        this.memberCollectionList.splice(index,1);
        this.memberCollectionList.push(memberobj);
        this.resetControl();
        this.resetCheckbox();
        this.setMemberIndexvalues();



  }

  resetCheckbox() {

    const objIndexop = this.CheckboxOpioidsList.findIndex((obj => obj.ischecked === true));
    if(objIndexop >= 0) {
        this.CheckboxOpioidsList[objIndexop].ischecked = false;
    }
    const objIndexst = this.CheckboxStimulantsList.findIndex((obj => obj.ischecked === true));
    if(objIndexst >= 0) {
        this.CheckboxStimulantsList[objIndexst].ischecked = false;
    }
    const objIndexdp = this.CheckboxDepressantsList.findIndex((obj => obj.ischecked === true));
    if(objIndexdp >= 0) {
        this.CheckboxDepressantsList[objIndexdp].ischecked = false;
    }
    const objIndexhl = this.CheckboxHallucinogensList.findIndex((obj => obj.ischecked === true));
    if(objIndexhl >= 0) {
        this.CheckboxHallucinogensList[objIndexhl].ischecked = false;
    }
  }

  saveSectionDetail() {
        const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
        const aa = JSON.parse(generateObjectReqId);
        const sectionobj = {
            "sectionOne": {
                "ldss": {
                    "safecareplandate": this.planseconeForm.controls['safecareplandate'].value,
                    "name": this.planseconeForm.controls['name'].value,
                    "unit": this.planseconeForm.controls['unit'].value,
                    "email": this.planseconeForm.controls['email'].value,
                    "phoneno": this.planseconeForm.controls['phoneno'].value,
                },

                "data": this.memberCollectionList
            }
        }
        aa.persondetails = sectionobj.sectionOne;
        localStorage.setItem('generateObjectReq', JSON.stringify(aa));
        const url = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/service-plan/plan-of-safecare' + '/section-two'
        this._router.navigate([url], { relativeTo: this.route });
        this._sharedService.emitChange("SectionTwo");
    }

    familymemberchange(e: { value: string; }) {
        if (e.value == 'Parent') {
            this.parentChange(e);
        } else if (e.value == 'Caregiver') {
            this.caregiverChange(e);
        } else {
            this.otherMemberChange(e);
        }
    }

    parentChange(_e: any) {
        this.showparentdd = true;
        this.showcaregiverdd = false;
        this.personListFilter = this.personList.filter((obj) => {
            return obj.userroles.toLowerCase().includes('parent');
        });
        if (this.personListFilter.length > 0) {
            const res1 = this.memberCollectionList.filter(f => f.familymember.includes('Parent'));
            if (res1.length > 0) {
                const res = this.personListFilter.filter(entry1 => !res1.some(entry2 => entry1.personid === entry2.personid));
                this.personListFilter = res;
            }
        }
    }
    caregiverChange(_e: any) {
        this.showcaregiverdd = true;
        this.showparentdd = false;

        this.personListFilter = this.personList.filter((obj) => {
            return (obj.iscaregiver === true || obj.userroles.toLowerCase().includes('caregiver') || obj.userroles.toLowerCase().includes('legal guardian'));
        });

        if (this.personListFilter.length > 0) {
            const res1 = this.memberCollectionList.filter(f => f.familymember.includes('Caregiver'));
            if (res1.length > 0) {
                const res = this.personListFilter.filter(entry1 => !res1.some(entry2 => entry1.personid === entry2.personid));
                this.personListFilter = res;
            }
        }
    }

    otherMemberChange(_e: any) {
        this.showcaregiverdd = false;
        this.showparentdd = false;
        this.personListFilter = this.personList.filter((obj) => {
            return obj.userroles.toLowerCase().includes('child');
        });
        this.personListFilter = this.personListFilter.filter(item => item.drugexposednewbornflag === 1 && item.dobtdiffwithincidentdate <= 65);
        if (this.personListFilter.length > 0) {
            const res1 = this.memberCollectionList.filter(f => f.familymember.includes('Newborn'));
            if (res1.length > 0) {
                const res = this.personListFilter.filter(entry1 => !res1.some(entry2 => entry1.personid === entry2.personid));
                this.personListFilter = res;
            }
        }
    }

  showreasonDropdown(e: { value: any; }) {
    if(e.value == 'Parent') {
        this.showparentdd = true;
        this.showcaregiverdd = false;
    }
    else if(e.value == 'Caregiver') {
        this.showcaregiverdd = true;
        this.showparentdd = false;
    }
    else {
        this.showcaregiverdd = false;
        this.showparentdd = false;
    }

}

getMemberFormData(name: string): any[] {
    return Object.values((this.memberForm.get(name) as FormGroup).controls);
}



}


