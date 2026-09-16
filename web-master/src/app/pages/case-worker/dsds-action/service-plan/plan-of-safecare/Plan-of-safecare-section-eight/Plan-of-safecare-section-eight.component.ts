import { Component, OnInit } from "@angular/core";
import { FormArray, FormBuilder, FormGroup } from "@angular/forms";
import { ActivatedRoute, Router } from "@angular/router";
import { CASE_STORE_CONSTANTS } from "../../../../../case-worker/_entities/caseworker.data.constants";
import { AuthService, DataStoreService, SessionStorageService } from "../../../../../../@core/services";
import { SharedService } from "../../_service/shared-service";
import { AppConstants } from "../../../../../../@core/common/constants";
@Component({
    selector: 'plan-of-safecare-eight',
    templateUrl: './Plan-of-safecare-section-eight.component.html',
    styleUrls: ['./Plan-of-safecare-section-eight.component.scss'],
    standalone: false
})
export class PlanOfSafeCareEightComponent implements OnInit{
    
    decisionserviceform!: FormGroup;
    decisioncontactform!: FormGroup;
    decisioncourtform!: FormGroup;
    defaultDecisionStatusArray : any;
    id: any;
    daNumber: any;
    showIntendedLink!: boolean;
    showContactLink!: boolean;
    showCourtlink!: boolean;
    sectionOneMemberData: any;
    sigatureitemsFormArray!: FormArray;
    isCaseWorker!: boolean;
    isSupervisor!: boolean;
    userDetails: any;
    currentDate: Date = new Date();
    showShelterPetition!: boolean;
    caseWorkerName: string;
    supervisorName!: string;
    showsignature: any;
    savedSignatures: any = [];
    caseWorkerSignature: any;
    supervisorSignature: any;
    declinemember!: boolean;
    caseworkerComments: any;
    supervisorComments: any;
    ldsssign_validation: boolean = false;
    superVIsor_validation: boolean = false;
    careGiverSign_validation: boolean = false;
    parentSign_validation: boolean = false;
    caseworkerpageurl = '#/pages/case-worker/';
    contactpagepopupid = '#contact-page';
    courtpagepopupid = '#court-page';
    constructor(private _formBuilder: FormBuilder, private _router:Router, private route: ActivatedRoute, 
        private _sharedService : SharedService, 
        private _datastore: DataStoreService, 
        private _session: SessionStorageService,
        public _authService: AuthService
    ) {
        this.id = this._datastore.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._datastore.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.userDetails = this._authService.getCurrentUser();
        this.caseWorkerName = this.userDetails.user.userprofile.fullname;
        
    }

    ngOnInit() {
        this.initDecisionServiceForm();
        this.initDecisionContactForm();
        this.initDecisionCourtForm();
        this.loadFamilyMember();
        this.formDecisionStatus();
        this.isCaseWorker = this._authService.selectedRoleIs(AppConstants.ROLES.CASE_WORKER);
        this.isSupervisor = this._authService.selectedRoleIs(AppConstants.ROLES.SUPERVISOR);
        this.supervisorName = this.isSupervisor ? this.userDetails.user.userprofile.displayname : '';
        const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
        const aa = JSON.parse(generateObjectReqId);
        if(aa != null) {
            this.caseWorkerName = aa.caseworkername ? aa.caseworkername : this.caseWorkerName;
            this.patchDecisionServiceForm(aa);
            this.savedSignatures = (aa.signatures && aa.signatures.signatureitemsFormArray) ? aa.signatures.signatureitemsFormArray : [];
            this.caseWorkerSignature = aa.signatures?.ldsssign;
            this.supervisorSignature = aa.signatures?.supervisorsign;
            this.supervisorComments = aa.signatures?.supervisorComments;
            this.caseworkerComments = aa.justification;
            this.serviceStatusChange(this.decisionserviceform.controls['serviceStatus']);
        } 
        this.decisionserviceform.get('signatureitemsFormArray')?.valueChanges.subscribe(x => {
            this.generateObj()
         })
         this.decisionserviceform.get('ldsssign')?.valueChanges.subscribe(x => {
            this.generateObj()
         })
         this.decisionserviceform.get('supervisorsign')?.valueChanges.subscribe(x => {
            this.generateObj()
         })
    }

    initDecisionServiceForm() {
        
        this.decisionserviceform =  this._formBuilder.group({
            serviceStatus : [''],
            showcontactvalue : [''],
            showcourtvalue : [''],
            signatureitemsFormArray : this._formBuilder.array([this.createsignatureitemsFormArray()]),
            ldsssign  : [''],
            ldssdate : [''],
            supervisorsign : [''],
            supervisordate : ['']
        });

    }

    onSigantureRequired(event: any, itemForm: any) {
        if(event.target.checked) {
            Object.keys(itemForm.controls).forEach(controler => {
                if(!['isSignatureRequired', 'reason', 'otherReason'].includes(controler)){
                    itemForm.get(controler).setValue('');
                    itemForm.get(controler)?.disable();
                }
            });
        } else {
            Object.keys(itemForm.controls).forEach(controler => {
                if(!['isSignatureRequired', 'reason', 'otherReason'].includes(controler)){
                    itemForm.get(controler)?.enable();
                    itemForm.get('reason').setValue('');
                    itemForm.get('otherReason').setValue('');
                }
            });
        }
    }

    patchDecisionServiceForm(aa: any) {
        if (aa.recommendedforclosure) {
            this.decisionserviceform.patchValue({ serviceStatus: '1' });
        }
        if (aa.insufficientevidencetocourt) {
            this.decisionserviceform.patchValue({ serviceStatus: '2' });
        }
        if (aa.familypreservationtransfer) {
            this.decisionserviceform.patchValue({ serviceStatus: '3' });
        }
        if (aa.referredtocps) {
            this.decisionserviceform.patchValue({ serviceStatus: '4' });
        }
        if (aa.shelterorder) {
            this.decisionserviceform.patchValue({ serviceStatus: '5' });
        }
        this.decisionserviceform.patchValue(aa.signatures);
        this.decisionserviceform.patchValue(aa.signatures.signatureitemsFormArray);
        this.decisionserviceform.patchValue({
            showcourtvalue: aa.signatures.showcourtvalue,
            showcontactvalue: aa.signatures.showcontactvalue
        });

        let signatureitemsFormArray: any = this.decisionserviceform.get('signatureitemsFormArray');

        for(let item of signatureitemsFormArray?.controls) {
            let isSignatureRequired = item.get('isSignatureRequired').value;
            if(isSignatureRequired) {
                Object.keys(item.controls).forEach(controler => {
                    if(!['isSignatureRequired', 'reason', 'otherReason'].includes(controler)){
                        item.get(controler).setValue('');
                        item.get(controler)?.disable();
                    }
                });
            }
        }


    }    
    
    createsignatureitemsFormArray() {
        return this._formBuilder.group({   
            signaturevalue : [null],
            isSignatureRequired: [''],
            reason: [''],
            otherReason: [''],
            signaturedate: [''],
        });
    }

    initDecisionContactForm() {
        this.decisioncontactform =  this._formBuilder.group({
            servicecontactvalue : ['']
        });
    }

    initDecisionCourtForm() {
        this.decisioncourtform =  this._formBuilder.group({
            servicecourtvalue : ['']
        });
    }

    loadFamilyMember() {
        const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
        const sectionObj = JSON.parse(generateObjectReqId);
        this.sectionOneMemberData = sectionObj.persondetails.data || [];
        this.setFormvalues();  
        const seconelength = Object.keys(sectionObj.persondetails);
        let sectiononedata ;
        if (seconelength.length > 0) {
        sectiononedata = sectionObj.persondetails.data;
        }

        sectiononedata?.forEach((obj: any) => {
            if (obj.declinemember === 'Deceased') {
              this.declinemember = true;
            }      
          });

    }

    setFormvalues() {
        this.sectionOneMemberData = this.sectionOneMemberData.filter((x: any) => !x.familymember.includes("Newborn"));
        this.decisionserviceform.setControl('signatureitemsFormArray', this._formBuilder.array([]));
        const supportcontrol = <FormArray>this.decisionserviceform.controls['signatureitemsFormArray'];
        this.sectionOneMemberData.forEach((x: any) => {
            supportcontrol.push(this.buildDecisionServiceForm(x));
        });
    } 

private buildDecisionServiceForm(x: any): FormGroup {
    return this._formBuilder.group({   
        signaturevalue : x.signaturevalue,
        isSignatureRequired: '',
        reason: '',
        otherReason: '',
        signaturedate: x.signaturedate, 
        declinemember :x.declinemember     
    });
  }

formDecisionStatus()
{
    this.defaultDecisionStatusArray = [
        {
        id : '1',
        name : 'No services or monitoring required by this agency: Recommended for Closure',
        ischecked : false 
        },
        {
            id : '2',
            name : 'No services or monitoring required by this agency: Family refuses services and insufficient evidence to petition the court',
            ischecked : false 
        },
        {
            id : '3',
            name : 'Agency services needed: Transferred to Family Preservation',
            ischecked : false 
        },
        {
            id : '4',
            name : 'Agency services needed: Referred for Child Protective Services (maltreatment notification',
            ischecked : false 
        },
        {
            id : '5',
            name : 'Court Action: Order of Shelter',
            ischecked : false 
        },

]
}

    serviceStatusChange(e: any) {
        if(e.value == '1' || e.value == '2' || e.value == '3') {
            this.showIntendedLink = true;
            this.showContactLink = false;
            this.showCourtlink = false;
            this.decisionserviceform.controls['showcontactvalue'].reset();
            this.decisionserviceform.controls['showcourtvalue'].reset();
            this._sharedService.emitChange("enableapprovebtn");  
        } else if(e.value == '4' ) {
            this.showIntendedLink = false;
            this.showContactLink = true;
            this.showCourtlink = false;
            this.decisionserviceform.controls['showcourtvalue'].reset();
            this._sharedService.emitChange("enableapprovebtn");  
        
        } else if(e.value == '5' ) {
            this.showIntendedLink = false;
            this.showContactLink = false;
            this.showCourtlink = true;
            this.showShelterPetition = true;
            this.decisionserviceform.controls['showcontactvalue'].reset();
        }
        
        this.generateObj();        
    }
    changeevent(_e: any)
    {
        this.generateObj();
    }
    onDateChange(_e: any)
    {
        this.generateObj();
    }
    gotoIntendedPage() {
        const url = this.caseworkerpageurl + this.id + '/' + this.daNumber + '/dsds-action/attachment'
        window.open(url);
    }

    gotoSelterPetition() {
        const url = this.caseworkerpageurl + this.id + '/' + this.daNumber + '/dsds-action/court/petition-detail'
        window.open(url);
    }
    contactChange(e: any) {
        if(e.value == 'no') {
            (<any>$(this.contactpagepopupid)).modal('show');   
            this._sharedService.emitChange("disableapprovebtn");  
        }  
        else
        {
            this._sharedService.emitChange("enableapprovebtn");  
        } 
        this.generateObj();   
    }

    gotoContact(e: any) {
        if(e.value == 'yes'){
            (<any>$(this.contactpagepopupid)).modal('hide');
            this.decisioncontactform.reset();
            const url = this.caseworkerpageurl + this.id + '/' + this.daNumber + '/dsds-action/recording/notes'
            window.open(url);
        }
        else{
            (<any>$(this.contactpagepopupid)).modal('hide');
            this.decisioncontactform.reset();
        }
    }

    closeContactPopup() {
        (<any>$(this.contactpagepopupid)).modal('hide');
        this.decisioncontactform.reset();
    }

    courtChange(e: any) {
        if(e.value == 'yes'){
            (<any>$(this.courtpagepopupid)).modal('show');     
        } else {
            (<any>$('#info-popup')).modal('show');     
        }     
        this._sharedService.emitChange("enableapprovebtn");  
        this.generateObj();
    }

    closeCourtPopup() {
        (<any>$(this.courtpagepopupid)).modal('hide');
        this.decisioncourtform.reset();
    }

    gotoCourt(e: any) {
        if(e.value == 'yes'){
            (<any>$(this.courtpagepopupid)).modal('hide');
            this.decisioncourtform.reset();
            const url = this.caseworkerpageurl + this.id + '/' + this.daNumber + '/dsds-action/court/petition-detail'
            window.open(url);
        } else {
            (<any>$(this.courtpagepopupid)).modal('hide');
            this.decisioncourtform.reset();
            
        }
    }

    generateObj() {
        const signatureFormArray: FormArray = this.decisionserviceform.get('signatureitemsFormArray') as FormArray;

        const checkedvalue = this.decisionserviceform.controls['serviceStatus'].value;
        this.defaultDecisionStatusArray.map((item: { id: any; ischecked: boolean; }) => {
            if(item.id == checkedvalue)
            {
                item.ischecked = true;
            }
            else{
                item.ischecked = false;
            }
        });
        const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
        const aa = JSON.parse(generateObjectReqId); 
        aa.recommendedforclosure = this.defaultDecisionStatusArray[0].ischecked;
        aa.insufficientevidencetocourt = this.defaultDecisionStatusArray[1].ischecked;
        aa.familypreservationtransfer = this.defaultDecisionStatusArray[2].ischecked;
        aa.referredtocps =this.defaultDecisionStatusArray[3].ischecked;
        aa.shelterorder = this.defaultDecisionStatusArray[4].ischecked;

        aa.signatures = {
                "showcourtvalue" : this.decisionserviceform.controls['showcourtvalue'].value,
                "showcontactvalue" : this.decisionserviceform.controls['showcontactvalue'].value,
                "signatureitemsFormArray" : signatureFormArray.value,
                "ldsssign"  : this.decisionserviceform.controls['ldsssign'].value,
                "ldssdate" : this.decisionserviceform.controls['ldssdate'].value == "" ? "" :
                this.decisionserviceform.controls['ldssdate'].value ,
                "supervisorsign" : this.decisionserviceform.controls['supervisorsign'].value,
                // "supervisordate" : moment(new Date(this.decisionserviceform.controls['supervisordate'].value)).format('YYYY-MM-DD') ,
                "supervisordate" : this.decisionserviceform.controls['supervisordate'].value == "" ? "" : 
                this.decisionserviceform.controls['supervisordate'].value ,
           
                }
       localStorage.setItem('generateObjectReq',JSON.stringify(aa));
       this.signatureValidation();
    }
    goToPrevious() {
        const url = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/service-plan/plan-of-safecare' + '/section-seven'
        this._router.navigate([url],{relativeTo :this.route});
        this._sharedService.emitChange("SectionSeven");
    }

    closePopup() {
        (<any>$('#info-popup')).modal('hide');
    }

    signatureValidation() {
        const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
        const signatures = JSON.parse(generateObjectReqId).signatures;

        if (signatures) {
            this.parentSign_validation = signatures.signatureitemsFormArray.some(
                (item: any, index: number) =>
                    (this.sectionOneMemberData[index].familymember === 'Parent 1' ||
                        this.sectionOneMemberData[index].familymember === 'Parent 2') &&
                    (item.signaturevalue === '' || item.signaturevalue === null)
            ) ? true : false;

            this.careGiverSign_validation = signatures.signatureitemsFormArray.some(
                (item: any, index: number) =>
                    this.sectionOneMemberData[index].familymember === 'Caregiver' &&
                    (item.signaturevalue === '' || item.signaturevalue === null)
            ) ? true : false;

            this.ldsssign_validation = signatures.ldsssign === '' ? true : false;

            this.superVIsor_validation = signatures.supervisorsign === '' ? true : false;

        }
    }

    getDecisionserviceformData(name: string): any[] {
        return Object.values((this.decisionserviceform.get(name) as FormGroup).controls);
    }
}
