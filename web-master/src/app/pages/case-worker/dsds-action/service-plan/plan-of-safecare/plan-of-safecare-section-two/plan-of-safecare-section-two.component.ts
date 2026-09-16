import {Observable, forkJoin } from 'rxjs';
// import 'rxjs/Rx';
import { Component, Injector } from "@angular/core";
import { FormBuilder, FormGroup } from "@angular/forms";
import { CASE_STORE_CONSTANTS, CASE_TYPE_CONSTANTS } from "../../../../../case-worker/_entities/caseworker.data.constants";
import { CommonHttpService, DataStoreService,CommonDropdownsService, AlertService } from "../../../../../../@core/services";
import { AppUser } from "../../../../../../@core/entities/authDataModel";
import { DropdownModel } from '../../../../../../@core/entities/common.entities';
import { ActivatedRoute, Router } from "@angular/router";
import { SharedService } from '../../_service/shared-service';

@Component({
    selector: 'plan-of-safecare-two',
    templateUrl: './plan-of-safecare-section-two.component.html',
    styleUrls: ['./plan-of-safecare-section-two.component.scss'],
    standalone: false
})

export class PlanOfSafeCareTwoComponent{
   
    showrole!: boolean;
    isAdoptionCase!: boolean;
    intakeserviceid = '';
    personList: any[] = [];
    personListFilter: any[] = [];
    selectedClientName: string = '';
    personDataList: any[] = [];
    childList: any[] = [];
    personListName: any;
    legalGuardian = '';
    user!: AppUser;
    candidacyRoles: string[] = ['CHILD', 'OTHERCHILD', 'AV'];
    roleform!: FormGroup;
    showClientDropdown: boolean = false;
    roleCollectionList : any[] = [];
    deletetype: any;
    deleteObject: any;
    id: any;
    daNumber: any;
    roledropdown:any=[];
    senChildList!: any[];
    //memberdropdown:any=[];
    showAdd : boolean = true;
    selected = '';
    memberRoleDropdownItems$!: Observable<DropdownModel[]>;
    cpsRoleDropdownItems$!: Observable<DropdownModel[]>;
    editId: any;
    primaryCareDoctorList: any[] = [];
    selectedPrimaryDoctor!: boolean;
    primaryDoctorName!: string | null;
    primaryDoctorEmail!: string;
    primaryDoctorPhone!: string;
    newBornPersons: any;
    selectedPrimaryDoctorDetails: any;
    checkforrequired: boolean =false;
    isViewMode: boolean = false;
    selectedChild: any = {};
    selectedChildPrimaryCareDoctorList: any[] = [];
    pcpDetails: any[] = [];
    notRequiredPCPDetails: any[] =[];
    pcpSearchKeys: string[] = [
        'clientName',
        'isPCP',
        'primaryCareDoctor',
        'physicianType',
        'email',
        'contact',
        'Cred'
    ];
    requestColumns: string[] = [
        'Client Name',
        'Does the newborn have a primary care phsician(PCP)?',
        'Primary Care Doctor',
        'Physician Type',
        'Email',
        'Contact',
        'Action'
    ];

    unsortablecolumnsList: string[] = [
        'Client Name',
        'Does the newborn have a primary care phsician(PCP)?',
        'Primary Care Doctor',
        'Physician Type',
        'Email',
        'Contact',
        'Action'
    ];

    styles: any = {
        'Client Name': { 'thStyleClassName': 'width-150', 'tdStyleClassName': '', 'filterIconClassName': '', },
        'Does the newborn have a primary care phsician(PCP)?': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'Primary Care Doctor': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'Physician Type': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'Email': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'Contact': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
        'Action': { 'thStyleClassName': 'inherit', 'tdStyleClassName': '', 'filterIconClassName': '' },
    }

    private _formBuilder: FormBuilder;
    private _datastore: DataStoreService;
    private _commonhttp: CommonHttpService;
    private _commonDropdownService: CommonDropdownsService;
    private _router:Router;
    private route: ActivatedRoute;
    private _sharedService : SharedService;
    private _alert: AlertService;
    constructor(private injector: Injector) {
        this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
        this._datastore = this.injector.get<DataStoreService>(DataStoreService);
        this._commonhttp = this.injector.get<CommonHttpService>(CommonHttpService);
        this._commonDropdownService = this.injector.get<CommonDropdownsService>(CommonDropdownsService);
        this._router = this.injector.get<Router>(Router);
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this._sharedService = this.injector.get<SharedService>(SharedService);
        this._alert = this.injector.get<AlertService>(AlertService);
        this.id = this._datastore.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._datastore.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    }

    ngOnInit() {
        this.initmemberForm();
        this.loadDropdown();
       
        const caseType = this._datastore.getData(CASE_STORE_CONSTANTS.CASE_TYPE);
        this.intakeserviceid = this._datastore.getData(CASE_STORE_CONSTANTS.CASE_UID);

        if (caseType === CASE_TYPE_CONSTANTS.ADOPTION) {
            this.isAdoptionCase = true;
        }
        this.getInvolvedPerson();
        const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
        const aa = JSON.parse(generateObjectReqId);
        let newBornPersons = aa?.persondetails?.data?.filter((item: any) => item.familymember.indexOf('Newborn') > -1) || [];
        this.isViewMode = aa.isViewMode;
        const seconelength = Object.keys(aa.planparticipants)
        if (seconelength.length > 0) {
            this.roleCollectionList = aa.planparticipants?.data?.roleCollectionList|| [];
            this.pcpDetails = aa.planparticipants?.data?.pcpDetails || [];
            this.notRequiredPCPDetails = aa.planparticipants?.data?.notRequiredPCPDetails || [];
        }

        let personIds: any[] = [];
        this.newBornPersons = newBornPersons.map((item: any) => {
            personIds.push(item.personid);
            let pcp = this.pcpDetails?.filter(value => item.personid === value.personid);
            let noPCP = this.notRequiredPCPDetails?.filter(value => item.personid === value.personid);
            if (pcp.length) {
                item.isPrimaryCarePhysician = pcp[0].isPCP;
                item.SelectedPrimaryCarePhysician = pcp[0].primaryCareDoctor;
                item.reason = '';
            } else if (noPCP.length) {
                item.isPrimaryCarePhysician = noPCP[0].isPCP;
                item.SelectedPrimaryCarePhysician = '';
                item.reason = noPCP[0].reason;
            } else {
                item.isPrimaryCarePhysician = '';
                item.SelectedPrimaryCarePhysician = '';
                item.reason = '';
            }

            return item;
        });

        this.pcpDetails = this.pcpDetails.filter(item => personIds.indexOf(item.personid) > -1);
        this.notRequiredPCPDetails =  this.notRequiredPCPDetails.filter(item => personIds.indexOf(item.personid) > -1);
    }
    private loadDropdown(){
        this.memberRoleDropdownItems$ = this._commonDropdownService.getPickListByName('safecareplanrole'); 
        this.cpsRoleDropdownItems$ = this._commonDropdownService.getPickListByName('cpsroles');
         
        forkJoin([this._commonDropdownService.getPickListByName('safecareplanrole'),this._commonDropdownService.getPickListByName('cpsroles')]).subscribe(
            (data)=>{
                let roledropdown = [...data[0].map(v => ({...v, showDropDown: false})),...data[1].map(v => ({...v, showDropDown: true}))];
                this.roledropdown = roledropdown.filter(val => val.ref_key != 'NPCD')
            });

    }

    onEnterPCPReason(reason: any, personid: any) {
        this.notRequiredPCPDetails = this.notRequiredPCPDetails.map(item => {
            if(item.personid === personid) {
                item.reason = reason;
            }
            return item;
        });

        const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
        const aa = JSON.parse(generateObjectReqId);
        const sectionobj = {
            "sectionTwo": {
                "data": {
                    roleCollectionList: this.roleCollectionList,
                    pcpDetails: this.pcpDetails,
                    notRequiredPCPDetails: this.notRequiredPCPDetails,
                }
            }
        }
        aa.planparticipants = sectionobj.sectionTwo;

        localStorage.setItem('generateObjectReq',JSON.stringify(aa));
    }

    onChagePhysician(value: any) {
        if(value.isPrimaryCarePhysician === "Yes") {
            (<any>$('#primary-doctor-select')).modal('show');
            this.selectedChild = value;
            this.selectedChildPrimaryCareDoctorList = this.primaryCareDoctorList.filter(item=> item.personid === value.personid);
            this.notRequiredPCPDetails = this.notRequiredPCPDetails.filter(item=> item.personid !== value.personid);
        } else {
            this.notRequiredPCPDetails.push({
                name: value.personName,
                personid: value.personid,
                isPCP: 'No',
                reason: '',
            });
            this.pcpDetails = this.pcpDetails.filter(item => item.personid != value.personid);
            this.newBornPersons = this.newBornPersons.map((item: any) => {
                if(item.personid === value.personid) {
                    item.SelectedPrimaryCarePhysician = '';
                    item.reason = '';
                }
                return item;
            });
        }

        const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
        const aa = JSON.parse(generateObjectReqId);
        const sectionobj = {
            "sectionTwo": {
                "data": {
                    roleCollectionList: this.roleCollectionList,
                    pcpDetails: this.pcpDetails,
                    notRequiredPCPDetails: this.notRequiredPCPDetails,
                }
            }
        }
        aa.planparticipants = sectionobj.sectionTwo;

        localStorage.setItem('generateObjectReq',JSON.stringify(aa));
    }

    callReDirect(event: any) {
        const data = JSON.parse(event);

        if (data.action === 'EDIT') {
            (<any>$('#primary-doctor-select')).modal('show');
            this.selectedChild = data;
            this.selectedChildPrimaryCareDoctorList = this.primaryCareDoctorList.filter(item=> item.personid === data.personid);
        }

        if (data.action === 'DELETE') {
            this.pcpDetails = this.pcpDetails.filter(item => item.personid != data.personid);
            this.newBornPersons = this.newBornPersons.map((item: any) => {
                if(item.personid === data.personid) {
                    item.SelectedPrimaryCarePhysician = '';
                    item.reason = '';
                    item.isPrimaryCarePhysician = '';
                }
                return item;
            });
        }

        const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
        const aa = JSON.parse(generateObjectReqId);
        const sectionobj = {
            "sectionTwo" : {              
                "data" : {
                    roleCollectionList: this.roleCollectionList,
                    pcpDetails: this.pcpDetails,
                    notRequiredPCPDetails: this.notRequiredPCPDetails,
                }
            } 
        }
        aa.planparticipants = sectionobj.sectionTwo;

        localStorage.setItem('generateObjectReq',JSON.stringify(aa));
    }

    initmemberForm() {
        this.roleform = this._formBuilder.group({
            rolemember : [''],
            personid : [''],
            rolephone : [''],
            roleemail : [''],
            rolenameTitle : [''],
            havePrimaryCarePhysician: [''],
            Reason: ['']
        });
        
    }

    getInvolvedPerson() {
        let inputRequest = {};
        const isServiceCase = this._datastore.getData(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
        if (isServiceCase || this.isAdoptionCase) {
            inputRequest = {
                objectid: this.intakeserviceid,
                objecttypekey: 'servicecase'
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
                const nonChildList = response.data.filter(item => !item.userroles?.toLowerCase().includes('child'));
                this.senChildList = response.data.filter(item => item.userroles?.toLowerCase().includes('child') && item.drugexposednewbornflag === 1 && item.dobtdiffwithincidentdate <= 65);
                this.personList = [...nonChildList, ...this.senChildList];
                this.personListFilter = this.personList;
                this.getPrimaryCareDoctor();
                if (response.data && response.data.length) {
                    this.checkpersonDetails(response);
                }
            });
    }
    checkpersonDetails(response: any){
        response.data.forEach((person: any) => {
            this.personDataList.push({ 'name': this.getFullName(person) });
            let obj;
            if (person.roles) {
                person.roles.some((role: { intakeservicerequestpersontypekey: string; }) => {
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
        const selectPersonList = list.find((f: { personid: any; }) => f.personid === id);
        this.selectedClientName = selectPersonList.fullname;
        this.roleform.patchValue({
            rolephone : selectPersonList.phonenumber
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

    getrolemember(value: any, editmode = false)  {
        
        const data = this.roledropdown.find((item: { ref_key: any; }) => item.ref_key === value);
        this.showClientDropdown = (data?.showDropDown) ? data.showDropDown : false;
        if(this.showClientDropdown) {
            this.roleform.controls['rolenameTitle'].clearValidators();
            this.roleform.patchValue({rolenameTitle: ''});
            this.roleform.controls['rolenameTitle'].markAsDirty();
        }
        else{
            this.roleform.controls['personid'].clearValidators();
            this.roleform.patchValue({personid: ''});
            this.roleform.controls['personid'].markAsDirty();
            this.primaryDoctorName = null;
            if(value === "NPCD" && !editmode) {
                this.primaryDoctorName = null;
            } else {
                this.roleform.controls['rolenameTitle'].enable();
            }
        }

        const selectedRoleKey = value?.toLowerCase();
        const selectedRoleDescription = data?.description?.toLowerCase();

        const roleFilteredList = this.personList.filter((person: any) => {

            const personRoleKeys = person.roles?.map((role: any) =>
                role.intakeservicerequestpersontypekey?.toLowerCase()
            ) || [];

            const userRoles = person.userroles?.toLowerCase() || '';

            return personRoleKeys.includes(selectedRoleKey) ||
                   userRoles.includes(selectedRoleDescription);
        });

        const res = roleFilteredList.filter(entry1 => 
            !this.roleCollectionList.some(entry2 => entry1.personid === entry2.personid)
        );

        this.personListFilter = res;
    }  

    
    addRoleDetail() {
        this.checkforrequired =true;
        this.showAdd = true;
        if(this.roleform.valid){
        const roleDtl = this.roledropdown.find((item: { ref_key: any; }) => item.ref_key === this.roleform.controls['rolemember'].value);
        const memberobj = {
            "id" : this.roleCollectionList.length == 0 ? 
            this.roleCollectionList.length + 1:this.roleCollectionList[this.roleCollectionList.length - 1].id + 1,          
            "rolemember": this.roleform.controls['rolemember'].value,
            "rolenameTitle": this.roleform.controls['rolenameTitle'].value,
            "rolephone": this.roleform.controls['rolephone'].value,
            "personid": this.roleform.controls['personid'].value,
            "personName" : this.roleform.controls['personid'].value == '' ? this.roleform.controls['rolenameTitle'].value
                             : this.selectedClientName,
            "roleemail" : this.roleform.controls['roleemail'].value,
            "roledesc" : roleDtl.description
        }
        
        this.roleCollectionList.push(memberobj);
        this.clearcontrol();
        this.saveAsDraftSectionDetail();
        this.showrole=false;
    }
    else{
        this._alert.error('Please fill all the required fields');
    }
    }
    rolememberReset() {
        this.showAdd = true;
        this.checkforrequired = false;
    }
    
    clearcontrol() {
        this.showAdd = true;
    }

    openForm() {
        this.showrole = true;
        this.roleform.reset();
        this.roleform.enable();
    }

    editrole(item: any,type: any) {
        if(this.isViewMode && type=='edit'){
            return;
        }
        this.showrole=true;
        this.editId = item.id;
        this.showAdd = false;
        this.roleform.patchValue(item);
        this.getrolemember(item.rolemember, true);
        this.roleform.enable();
        if(type === 'edit') {
            this.roleform.controls['rolemember'].disable();
            if(item.rolenameTitle) {
                this.roleform.controls['rolenameTitle'].disable();
            }
        } else {
            this.roleform.disable();
        }
        this.personListFilter = this.personList;
        if(item.personid !== '') {
            this.getClientNameList(item.personid,this.personList);
        }
    }

    updateRoleDetail()
    {    this.checkforrequired = true;
        if(this.roleform.valid){
        const roleDtl = this.roledropdown.find((item: { ref_key: any; }) => item.ref_key === this.roleform.controls['rolemember'].value);
        const memberobj = {
            "id" : this.editId,
            "rolemember": this.roleform.controls['rolemember'].value,
            "rolenameTitle": this.roleform.controls['rolenameTitle'].value,
            "rolephone": this.roleform.controls['rolephone'].value,
            "personid": this.roleform.controls['personid'].value,
            "personName" : this.selectedClientName,
            "roleemail" : this.roleform.controls['roleemail'].value,
            "roledesc" : roleDtl.description
        }
        const index = this.roleCollectionList.findIndex(x => x.id === this.editId);
        this.roleCollectionList.splice(index,1);      
        this.roleCollectionList.push(memberobj);
        this.clearcontrol();
        this.saveAsDraftSectionDetail();
    }
    else{
        this._alert.error('Please fill all required fields');
    }
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
        const index = this.roleCollectionList.findIndex(x => x.id === this.deleteObject.id);
        this.roleCollectionList.splice(index,1);
        this.saveAsDraftSectionDetail();
    }

    saveSectionDetail() {
        const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
        const aa = JSON.parse(generateObjectReqId);
        const sectionobj = {
            "sectionTwo" : {              
                "data" : {
                    roleCollectionList: this.roleCollectionList,
                    pcpDetails: this.pcpDetails,
                    notRequiredPCPDetails: this.notRequiredPCPDetails,
                }
            } 
        }
        aa.planparticipants = sectionobj.sectionTwo;

        localStorage.setItem('generateObjectReq',JSON.stringify(aa));
        const url = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/service-plan/plan-of-safecare' + '/section-three'
            this._router.navigate([url],{relativeTo :this.route});
            this._sharedService.emitChange("SectionThree");
       
    }
    goToPrevious() {
        const url = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/service-plan/plan-of-safecare' + '/section-one'
        this._router.navigate([url],{relativeTo :this.route});
        this._sharedService.emitChange("SectionOne");
    }
    saveAsDraftSectionDetail() {
        const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
        const aa = JSON.parse(generateObjectReqId);
        const sectionobj = {
            "sectionTwo": {
                "data": {
                    roleCollectionList: this.roleCollectionList,
                    pcpDetails: this.pcpDetails,
                    notRequiredPCPDetails: this.notRequiredPCPDetails,
                }
            }
        }
        aa.planparticipants = sectionobj.sectionTwo;

        localStorage.setItem('generateObjectReq',JSON.stringify(aa));
    }

    getPrimaryCareDoctor() {
        const obj = {
          "personids": this.senChildList.map(item => item.personid)
        }
        this._commonhttp.create(obj, 'safecareplan/getprimarycaredoctor').subscribe(response => {
          this.primaryCareDoctorList = (response.success) ? response.data : [];
          this.selectedChildPrimaryCareDoctorList = this.primaryCareDoctorList.filter(item=> item.personid === this.selectedChild.personid);
        });
    }

    onClose() {

        this.newBornPersons = this.newBornPersons.map((item: any) => {
            if (item.personid === this.selectedChild.personid) {
                item.SelectedPrimaryCarePhysician = '';
                item.reason = '';
                item.isPrimaryCarePhysician = '';
            }
            return item;
        });
        (<any>$('#primary-doctor-select')).modal('hide');
    }

    selectPrimaryCareDoctor(modal: any) {
        this.selectedPrimaryDoctor = true;
        this.selectedPrimaryDoctorDetails = modal;
    }

    clearPrimaryCareDoctor() {
        let details = {
            clientName: this.selectedPrimaryDoctorDetails.personname,
            isPCP: 'Yes',
            primaryCareDoctor: this.selectedPrimaryDoctorDetails.name,
            physicianType: this.selectedPrimaryDoctorDetails.physiciantype,
            email: this.selectedPrimaryDoctorDetails.email,
            contact: this.selectedPrimaryDoctorDetails.phone,
            personid: this.selectedPrimaryDoctorDetails.personid,
        }

        const index = this.pcpDetails.findIndex(item => item.personid === details.personid);
        if (index != -1) {
            this.pcpDetails[index] = details;
        } else {
            this.pcpDetails.push(details);
        }

        this.selectedPrimaryDoctor = false;
        this.newBornPersons = this.newBornPersons.map((item: any) => {
            if (item.personid === details.personid) {
                item.SelectedPrimaryCarePhysician = details.primaryCareDoctor;
                item.reason = '';
            }
            return item;
        });
        const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
        const aa = JSON.parse(generateObjectReqId);
        const sectionobj = {
            "sectionTwo": {
                "data": {
                    roleCollectionList: this.roleCollectionList,
                    pcpDetails: this.pcpDetails,
                    notRequiredPCPDetails: this.notRequiredPCPDetails,
                }
            }
        }
        aa.planparticipants = sectionobj.sectionTwo;

        localStorage.setItem('generateObjectReq', JSON.stringify(aa));
        (<any>$('#primary-doctor-select')).modal('hide');
    }

    navitageToPersonTab() {
        const url = '#/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/person-cw/list'
        window.open(url);
    }

}