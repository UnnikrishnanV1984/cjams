import { Component } from "@angular/core";
import { FormArray, FormBuilder, FormGroup, Validators } from "@angular/forms";
import { ActivatedRoute, Router } from "@angular/router";
import { AlertService,DataStoreService } from "../../../../../../@core/services";
import { CASE_STORE_CONSTANTS } from "../../../../../case-worker/_entities/caseworker.data.constants";
import { SharedService } from "../../_service/shared-service";

@Component({
    selector: 'plan-of-safecare-four',
    templateUrl: './Plan-of-safecare-section-four.component.html',
    styleUrls: ['./Plan-of-safecare-section-four.component.scss'],
    standalone: false
})
export class PlanOfSafeCareFourComponent {
    otherserviceform!: FormGroup;
    establishedServiceForm!: FormGroup;
    checkboxobj : any;
    familyMemberData : any[] = [];
    selected = 'option2';
    id: any;
    daNumber: any;
    supportitemsFormArray!: FormArray;
    unitedwayitemsFormArray!: FormArray;
    housingitemsFormArray!: FormArray;
    paroleitemsFormArray!: FormArray;
    drugitemsFormArray!: FormArray;
    additionalitemsFormArray!: FormArray;

    clientInspect : any = [];

    sectionOneMemberData: any;
    setsupportrequiredsymbol!: boolean;
    setunitedwayrequiredsymbol!: boolean;
    sethousingrequiredsymbol!: boolean;
    setparolerequiredsymbol!: boolean;
    setdrugrequiredsymbol!: boolean;
    setadditionalrequiredsymbol!: boolean;
    checkforrequired: boolean =false;

    constructor(private _formBuilder: FormBuilder,   private _router:Router, private route: ActivatedRoute, 
        private _datastore: DataStoreService,private _sharedService : SharedService , private _alertService :AlertService)
    {
        this.id = this._datastore.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._datastore.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    }
    ngOnInit() {
        this.initOtherServiceForm();
        this.checkboxObject();
        this.intiEstablushedServiceForm();
        this.loadFamilyMember();
        const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
        const aa = JSON.parse(generateObjectReqId);
        const secfourlength = Object.keys(aa.otherservices).length;
        let familymembers: any[] = [];
        aa?.persondetails?.data?.forEach((item: any) => {
            let familymember = item.familymember;
            if(item.familymember === 'Parent') {
                familymember = 'Parent 1';
            }
            familymembers.push(familymember)
        });
        let establishedServices: any = {};
        for (let item in aa.otherservices.establishedServices) {
            establishedServices[item] = establishedServices[item] || [];
            for (let value of aa.otherservices.establishedServices[item]) {
                let familymember = value.familymember;
                if(familymember === 'Parent') {
                    familymember = 'Parent 1';
                }
                if (familymembers.indexOf(familymember) > -1) {
                    establishedServices[item].push(value)
                }
            }
        }
        if (secfourlength > 0) {
            this.otherserviceform.patchValue(aa.otherservices.referralCurrentServices);
            this.establishedServiceForm.patchValue(establishedServices);
            this.setvalidations(aa);
        }
    }

    setvalidations(aa: any) {
        const support = aa.otherservices.establishedServices.supportitemsFormArray.filter((entry1: { familymember: any; }) => this.sectionOneMemberData.some((entry2: { familymember: any; }) => entry1.familymember === entry2.familymember));
        const unitedway = aa.otherservices.establishedServices.unitedwayitemsFormArray.filter((entry1: { familymember: any; }) => this.sectionOneMemberData.some((entry2: { familymember: any; }) => entry1.familymember === entry2.familymember));
        const housing = aa.otherservices.establishedServices.housingitemsFormArray.filter((entry1: { familymember: any; }) => this.sectionOneMemberData.some((entry2: { familymember: any; }) => entry1.familymember === entry2.familymember));
        const parole = aa.otherservices.establishedServices.paroleitemsFormArray.filter((entry1: { familymember: any; }) => this.sectionOneMemberData.some((entry2: { familymember: any; }) => entry1.familymember === entry2.familymember));
        const drug = aa.otherservices.establishedServices.drugitemsFormArray.filter((entry1: { familymember: any; }) => this.sectionOneMemberData.some((entry2: { familymember: any; }) => entry1.familymember === entry2.familymember));
        const additional = aa.otherservices.establishedServices.additionalitemsFormArray.filter((entry1: { familymember: any; }) => this.sectionOneMemberData.some((entry2: { familymember: any; }) => entry1.familymember === entry2.familymember));

        this.validateSupport(support);
        this.validateUnitedWay(unitedway);
        this.validateHousing(housing);
        this.validateParole(parole);
        this.validateDrug(drug);
        this.validateAdditional(additional);

        if(aa.otherservices.referralCurrentServices.noneIdentified) {
            this.checkToDisableNoneIdentified();
        }
    }

    validateSupport(support: any){
        if (support.length > 0) {
            for (let i = 0; i < support.length; i++) {
                if (support[i].issupportappt !== null) {
                    this.setSupportValidation(support[i].issupportappt, i);
                }
            }
        }
    }

    validateUnitedWay(unitedway: any){
        if (unitedway.length > 0) {
            for (let i = 0; i < unitedway.length; i++) {
                if (unitedway[i].isunitedwayappt !== null) {
                    this.setUnitedwayValidation(unitedway[i].isunitedwayappt, i);
                }
            }
        }
    }

    validateHousing(housing: any){
        if (housing.length > 0) {
            for (let i = 0; i < housing.length; i++) {
                if (housing[i].ishousingappt !== null) {
                    this.setHousingValidation(housing[i].ishousingappt, i);
                }
            }
        }
    }
    validateParole(parole: any){
        if (parole.length > 0) {
            for (let i = 0; i < parole.length; i++) {
                if (parole[i].isparoleappt !== null) {
                    this.setParoleValidation(parole[i].isparoleappt, i);
                }
            }
        }
    }

    validateDrug(drug: any){
        if (drug.length > 0) {
            for (let i = 0; i < drug.length; i++) {
                if (drug[i].isdrugappt !== null) {
                    this.setDrugValidation(drug[i].isdrugappt, i);
                }
            }
        }
    }

    validateAdditional(additional: any){
        if (additional.length > 0) {
            for (let i = 0; i < additional.length; i++) {
                if (additional[i].isadditionalappt !== null) {
                    this.setAdditionalValidation(additional[i].isadditionalappt, i);
                }
            }
        }
    }

    initOtherServiceForm()
    {
        this.otherserviceform = this._formBuilder.group({
            breastfeedingReferral : [false],
            breastfeedingCurrent : [false],
            infantReferral : [false],
            infantCurrent : [false],  
            childcareReferral : [false],
            childcareCurrent : [false],
            homeReferral : [false],
            homeCurrent : [false],
            homeNotes : [''],
            pregnancyReferral : [false],
            pregnancyCurrent : [false],
            interventionReferral : [false],
            interventionCurrent : [false],
            birthReferral : [false],
            birthCurrent : [false],
            publicReferral : [false],
            publicCurrent : [false],
            parentingReferral : [false],
            parentingCurrent : [false],
            otherReferral : [false],
            otherCurrent : [false],
            otherNotes : [''],
           
            noneIdentified: [''],
            noneIdentifiedReason: [''],
            });
        
    }

    noneIdentifiedChange(event: any) {
        if(event.target.checked) {
            this.checkToDisableNoneIdentified();
        } else {
            Object.keys(this.otherserviceform.controls).forEach(controler => {
                if(!['noneIdentified', 'noneIdentifiedReason'].includes(controler)){
                    this.otherserviceform.get(controler)?.enable();
                }
            });
            this.otherserviceform.get('noneIdentifiedReason')?.setValue('');
        }
        this.saveAsDraftSectionDetail(false);
    }


    checkToDisableNoneIdentified() {
        Object.keys(this.otherserviceform.controls).forEach(controler => {
            if(!['noneIdentified', 'noneIdentifiedReason'].includes(controler)){
                this.otherserviceform.get(controler)?.disable();
            }
        });
    }

    onOtherServicesEstablishChange() {
        let valueExists = false;
        let allValues = this.otherserviceform.value;
        Object.keys(allValues).forEach(controler => {
            let ctrl = ['noneIdentified', 'noneIdentifiedReason'];
            if (!ctrl.includes(controler)) {
                let value = allValues[controler];
                if (value) {
                    valueExists = true;
                }
            }
        });

        if (valueExists) {
            this.otherserviceform.get('noneIdentified')?.disable();
            this.otherserviceform.get('noneIdentifiedReason')?.disable();
            this.otherserviceform.get('noneIdentified')?.setValue('');
            this.otherserviceform.get('noneIdentifiedReason')?.setValue('');
        } else {
            this.otherserviceform.get('noneIdentified')?.enable();
            this.otherserviceform.get('noneIdentifiedReason')?.enable();
        }
        this.saveAsDraftSectionDetail(false);
    }

    intiEstablushedServiceForm()
    {
       this.establishedServiceForm = this._formBuilder.group({
     
        supportitemsFormArray : this._formBuilder.array([this.createsupportitemsFormArray()]),
        unitedwayitemsFormArray : this._formBuilder.array([this.createunitedwayitemsFormArray()]),
        housingitemsFormArray : this._formBuilder.array([this.createhousingitemsFormArray()]),
        paroleitemsFormArray : this._formBuilder.array([this.createparoleitemsFormArray()]),
        drugitemsFormArray : this._formBuilder.array([this.createdrugitemsFormArray()]),
        additionalitemsFormArray : this._formBuilder.array([this.createadditionalitemsFormArray()])
       
       });
    }

    createsupportitemsFormArray()
    {
        return this._formBuilder.group({
            issupportappt: ['',Validators.required],
            supportapptdate: ['']
        })
    }

    createunitedwayitemsFormArray()
    {
        return this._formBuilder.group({
            isunitedwayappt: ['',Validators.required],
            unitedwayapptdate: ['']
        })
    }
    createhousingitemsFormArray()
    {
        return this._formBuilder.group({
            ishousingappt: ['',Validators.required],
            housingapptdate: ['']
        })
    }
    createparoleitemsFormArray()
    {
        return this._formBuilder.group({
            isparoleappt: ['',Validators.required],
            paroleapptdate: ['']
        })
    }
    createdrugitemsFormArray()
    {
        return this._formBuilder.group({
            isdrugappt: ['',Validators.required],
            drugapptdate: ['']
        })
    }
    createadditionalitemsFormArray()
    {
        return this._formBuilder.group({
            isadditionalappt: ['',Validators.required],
            additionalapptdate: ['']
        })
    }
 
    checkboxObject()
    {
        this.checkboxobj = {
            breastfeedingReferral :false,
            breastfeedingCurrent : false,
            infantReferral : false,
            infantCurrent : false,  
            childcareReferral : false,
            childcareCurrent : false,
            homeReferral : false,
            homeCurrent : false,
            homeNotes : '',
            pregnancyReferral : false,
            pregnancyCurrent : false,
            interventionReferral : false,
            interventionCurrent : false,
            birthReferral : false,
            birthCurrent : false,
            publicReferral : false,
            publicCurrent : false,
            parentingReferral : false,
            parentingCurrent : false,
            otherReferral : false,
            otherCurrent : false,
            otherNotes : ''
        }
    }

    breastfeedingReferralChange(e: any)
    {
        if(e.target.checked)
        {
            this.checkboxobj.breastfeedingReferral = e.target.checked;
        }
        else
        {
            this.checkboxobj.breastfeedingReferral = false;
        }
        this.saveAsDraftSectionDetail();
        
    }
    breastfeedingCurrentChange(e: any)
    {
        if(e.target.checked)
        {
            this.checkboxobj.breastfeedingCurrent = e.target.checked;
        }
        else
        {
            this.checkboxobj.breastfeedingCurrent = false;
        }
        this.saveAsDraftSectionDetail();
    }
    infantReferralChange(e: any)
    {
        if(e.target.checked)
        {
            this.checkboxobj.infantReferral = e.target.checked;
        }
        else
        {
            this.checkboxobj.infantReferral = false;
        }
        this.saveAsDraftSectionDetail();
    }
    infantCurrentChange(e: any)
    {
        if(e.target.checked)
        {
            this.checkboxobj.infantCurrent = e.target.checked;
        }
        else
        {
            this.checkboxobj.infantCurrent = false;
        }
        this.saveAsDraftSectionDetail();
    }
    childcareReferralChange(e: any)
    {
        if(e.target.checked)
        {
            this.checkboxobj.childcareReferral = e.target.checked;
        }
        else
        {
            this.checkboxobj.childcareReferral = false;
        }
        this.saveAsDraftSectionDetail();
    }
    childcareCurrentChange(e: any)
    {
        if(e.target.checked)
        {
            this.checkboxobj.childcareCurrent = e.target.checked;
        }
        else
        {
            this.checkboxobj.childcareCurrent = false;
        }
        this.saveAsDraftSectionDetail();
    }
    homeReferralChange(e: any)
    {
        if(e.target.checked)
        {
            this.checkboxobj.homeReferral = e.target.checked;
        }
        else
        {
            this.checkboxobj.homeReferral = false;
        }
        this.saveAsDraftSectionDetail();
    }
    homeCurrentChange(e: any)
    {
        if(e.target.checked)
        {
            this.checkboxobj.homeCurrent = e.target.checked;
        }
        else
        {
            this.checkboxobj.homeCurrent = false;
        }
        this.saveAsDraftSectionDetail();
    }
    pregnancyReferralChange(e: any)
    {
        if(e.target.checked)
        {
            this.checkboxobj.pregnancyReferral = e.target.checked;
        }
        else
        {
            this.checkboxobj.pregnancyReferral = false;
        }
        this.saveAsDraftSectionDetail();
    }
    pregnancyCurrentChange(e: any)
    {
        if(e.target.checked)
        {
            this.checkboxobj.pregnancyCurrent = e.target.checked;
        }
        else
        {
            this.checkboxobj.pregnancyCurrent = false;
        }
        this.saveAsDraftSectionDetail();
    }
    interventionReferralChange(e: any)
    {
        if(e.target.checked)
        {
            this.checkboxobj.interventionReferral = e.target.checked;
        }
        else
        {
            this.checkboxobj.interventionReferral = false;
        }
        this.saveAsDraftSectionDetail();
    }
    interventionCurrenthange(e: any)
    {
        if(e.target.checked)
        {
            this.checkboxobj.interventionCurrent = e.target.checked;
        }
        else
        {
            this.checkboxobj.interventionCurrent = false;
        }
        this.saveAsDraftSectionDetail();
    }
    birthReferralChange(e: any)
    {
        if(e.target.checked)
        {
            this.checkboxobj.birthReferral = e.target.checked;
        }
        else
        {
            this.checkboxobj.birthReferral = false;
        }
        this.saveAsDraftSectionDetail();
    }
    birthCurrentChange(e: any)
    {
        if(e.target.checked)
        {
            this.checkboxobj.birthCurrent = e.target.checked;
        }
        else
        {
            this.checkboxobj.birthCurrent = false;
        }
        this.saveAsDraftSectionDetail();
    }
    publicReferralChange(e: any)
    {
        if(e.target.checked)
        {
            this.checkboxobj.publicReferral = e.target.checked;
        }
        else
        {
            this.checkboxobj.publicReferral = false;
        }
        this.saveAsDraftSectionDetail();
    }
    publicCurrentChange(e: any)
    {
        if(e.target.checked)
        {
            this.checkboxobj.publicCurrent = e.target.checked;
        }
        else
        {
            this.checkboxobj.publicCurrent = false;
        }
        this.saveAsDraftSectionDetail();
    }
    parentingReferralChange(e: any)
    {
        if(e.target.checked)
        {
            this.checkboxobj.parentingReferral = e.target.checked;
        }
        else
        {
            this.checkboxobj.parentingReferral = false;
        }
        this.saveAsDraftSectionDetail();
    }
    parentingCurrentChange(e: any)
    {
        if(e.target.checked)
        {
            this.checkboxobj.parentingCurrent = e.target.checked;
        }
        else
        {
            this.checkboxobj.parentingCurrent = false;
        }
        this.saveAsDraftSectionDetail();
    }
    otherReferralChange(e: any)
    {
        if(e.target.checked)
        {
            this.checkboxobj.otherReferral = e.target.checked;
        }
        else
        {
            this.checkboxobj.otherReferral = false;
        }
        this.saveAsDraftSectionDetail();
    }
    otherCurrentChange(e: any) {
        if (e.target.checked) {
            this.checkboxobj.otherCurrent = e.target.checked;
        }
        else {
            this.checkboxobj.otherCurrent = false;
        }
        this.saveAsDraftSectionDetail();
    }
    loadFamilyMember()
    {   
        const generateObjectReqId: any = localStorage.getItem('generateObjectReq');   
        const sectionObj = JSON.parse(generateObjectReqId);
        this.sectionOneMemberData = sectionObj.persondetails.data || [];
        this.setFormvalues();     
    }

      setFormvalues() {
       
        this.sectionOneMemberData = this.sectionOneMemberData.filter((x: any) => !x.familymember.includes("Newborn"));
        this.establishedServiceForm.setControl('supportitemsFormArray', this._formBuilder.array([]));
        const supportcontrol = <FormArray>this.establishedServiceForm.controls['supportitemsFormArray'];
        this.sectionOneMemberData.forEach((x: any) => {
            supportcontrol.push(this.buildSupportServiceForm(x));
        });

        this.establishedServiceForm.setControl('unitedwayitemsFormArray', this._formBuilder.array([]));
        const unitedwaycontrol = <FormArray>this.establishedServiceForm.controls['unitedwayitemsFormArray'];
        this.sectionOneMemberData.forEach((x: any) => {
            unitedwaycontrol.push(this.buildUnitedwayServiceForm(x));
        });
        this.establishedServiceForm.setControl('housingitemsFormArray', this._formBuilder.array([]));
        const housingcontrol = <FormArray>this.establishedServiceForm.controls['housingitemsFormArray'];
        this.sectionOneMemberData.forEach((x: any) => {
            housingcontrol.push(this.buildHousingServiceForm(x));
        });
        
        this.establishedServiceForm.setControl('paroleitemsFormArray', this._formBuilder.array([]));
        const parolecontrol = <FormArray>this.establishedServiceForm.controls['paroleitemsFormArray'];
        this.sectionOneMemberData.forEach((x: any) => {
            parolecontrol.push(this.buildParoleServiceForm(x));
        });

        this.establishedServiceForm.setControl('drugitemsFormArray', this._formBuilder.array([]));
        const drugcontrol = <FormArray>this.establishedServiceForm.controls['drugitemsFormArray'];
        this.sectionOneMemberData.forEach((x: any) => {
            drugcontrol.push(this.buildDrugServiceForm(x));
        });
        this.establishedServiceForm.setControl('additionalitemsFormArray', this._formBuilder.array([]));
        const additionalcontrol = <FormArray>this.establishedServiceForm.controls['additionalitemsFormArray'];
        this.sectionOneMemberData.forEach((x: any) => {
            additionalcontrol.push(this.buildAdditionalServiceForm(x));
        });
        

      }
      private buildSupportServiceForm(x: any): FormGroup {
        return this._formBuilder.group({
            issupportappt: x.issupportappt,
            supportapptdate: x.supportapptdate,
            familymember : x.familymember,
            personid: x.personid
        });
      }
      private buildUnitedwayServiceForm(x: any): FormGroup {
        return this._formBuilder.group({
            isunitedwayappt: x.isunitedwayappt,
            unitedwayapptdate: x.unitedwayapptdate ,
            familymember : x.familymember,
            personid: x.personid 
        });
      }
      private buildHousingServiceForm(x: any): FormGroup {
        return this._formBuilder.group({
            ishousingappt: x.ishousingappt,
            housingapptdate: x.housingapptdate,
            familymember : x.familymember,
            personid: x.personid
        });
      }
      private buildParoleServiceForm(x: any): FormGroup {
        return this._formBuilder.group({
            isparoleappt: x.isparoleappt,
            paroleapptdate: x.paroleapptdate ,
            familymember : x.familymember,
            personid: x.personid
        });
      }
      private buildDrugServiceForm(x: any): FormGroup {
        return this._formBuilder.group({
            isdrugappt: x.isdrugappt,
            drugapptdate: x.drugapptdate ,
            familymember : x.familymember ,
            personid: x.personid
        });
      }
      private buildAdditionalServiceForm(x: any): FormGroup {
        return this._formBuilder.group({
            isadditionalappt: x.isadditionalappt,
            additionalapptdate: x.additionalapptdate,
            familymember : x.familymember,
            personid: x.personid
        });
      }

    saveSectionDetail()
    {
        const supportFormArray: FormArray = this.establishedServiceForm.get('supportitemsFormArray') as FormArray;
        const unitedwayFormArray: FormArray = this.establishedServiceForm.get('unitedwayitemsFormArray') as FormArray;
        const housingFormArray: FormArray = this.establishedServiceForm.get('housingitemsFormArray') as FormArray;
        const paroleFormArray: FormArray = this.establishedServiceForm.get('paroleitemsFormArray') as FormArray;
        const drugFormArray: FormArray = this.establishedServiceForm.get('drugitemsFormArray') as FormArray;
        const additionalFormArray: FormArray = this.establishedServiceForm.get('additionalitemsFormArray') as FormArray;
        const generateObjectReqId: any = localStorage.getItem('generateObjectReq');  
      const aa = JSON.parse(generateObjectReqId);
      const sectionobj = {
          "sectionFour" : {      
            "referralCurrentServices" : {
                breastfeedingReferral : this.otherserviceform.controls['breastfeedingReferral'].value,
                breastfeedingCurrent : this.otherserviceform.controls['breastfeedingCurrent'].value,
                infantReferral : this.otherserviceform.controls['infantReferral'].value,
                infantCurrent : this.otherserviceform.controls['infantCurrent'].value,  
                childcareReferral : this.otherserviceform.controls['childcareReferral'].value,
                childcareCurrent : this.otherserviceform.controls['childcareCurrent'].value,
                homeReferral : this.otherserviceform.controls['homeReferral'].value,
                homeCurrent : this.otherserviceform.controls['homeCurrent'].value,
                homeNotes : this.otherserviceform.controls['homeNotes'].value,
                pregnancyReferral : this.otherserviceform.controls['pregnancyReferral'].value,
                pregnancyCurrent : this.otherserviceform.controls['pregnancyCurrent'].value,
                interventionReferral : this.otherserviceform.controls['interventionReferral'].value,
                interventionCurrent : this.otherserviceform.controls['interventionCurrent'].value,
                birthReferral : this.otherserviceform.controls['birthReferral'].value,
                birthCurrent : this.otherserviceform.controls['birthCurrent'].value,
                publicReferral : this.otherserviceform.controls['publicReferral'].value,
                publicCurrent : this.otherserviceform.controls['publicCurrent'].value,
                parentingReferral :this.otherserviceform.controls['parentingReferral'].value,
                parentingCurrent : this.otherserviceform.controls['parentingCurrent'].value,
                otherReferral : this.otherserviceform.controls['otherReferral'].value,
                otherCurrent : this.otherserviceform.controls['otherCurrent'].value,
                otherNotes : this.otherserviceform.controls['otherNotes'].value,
                noneIdentified : this.otherserviceform.controls['noneIdentified'].value,
                noneIdentifiedReason : this.otherserviceform.controls['noneIdentifiedReason'].value,
            },    
            "establishedServices":{
                "supportitemsFormArray" : supportFormArray.value,
                "unitedwayitemsFormArray" : unitedwayFormArray.value,
                "housingitemsFormArray" :housingFormArray.value,
                "paroleitemsFormArray" : paroleFormArray.value,
                "drugitemsFormArray" :drugFormArray.value,
                "additionalitemsFormArray" :additionalFormArray.value

            }
      } 
     }
    
      aa.otherservices = sectionobj.sectionFour;
      localStorage.setItem('generateObjectReq',JSON.stringify(aa));
      const url = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/service-plan/plan-of-safecare' + '/section-five'
      this._router.navigate([url],{relativeTo :this.route});
      this._sharedService.emitChange("SectionFive");
    }
    saveAsDraftSectionDetail(isRequiredEstablishValidation: boolean = true)
    {
        if(isRequiredEstablishValidation) {
            this.onOtherServicesEstablishChange();
        }

        const supportFormArray: FormArray = this.establishedServiceForm.get('supportitemsFormArray') as FormArray;
        const unitedwayFormArray: FormArray = this.establishedServiceForm.get('unitedwayitemsFormArray') as FormArray;
        const housingFormArray: FormArray = this.establishedServiceForm.get('housingitemsFormArray') as FormArray;
        const paroleFormArray: FormArray = this.establishedServiceForm.get('paroleitemsFormArray') as FormArray;
        const drugFormArray: FormArray = this.establishedServiceForm.get('drugitemsFormArray') as FormArray;
        const additionalFormArray: FormArray = this.establishedServiceForm.get('additionalitemsFormArray') as FormArray;
        const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
      const aa = JSON.parse(generateObjectReqId);
      const sectionobj = {
          "sectionFour" : {      
            "referralCurrentServices" : {
                breastfeedingReferral : this.otherserviceform.controls['breastfeedingReferral'].value,
                breastfeedingCurrent : this.otherserviceform.controls['breastfeedingCurrent'].value,
                infantReferral : this.otherserviceform.controls['infantReferral'].value,
                infantCurrent : this.otherserviceform.controls['infantCurrent'].value,  
                childcareReferral : this.otherserviceform.controls['childcareReferral'].value,
                childcareCurrent : this.otherserviceform.controls['childcareCurrent'].value,
                homeReferral : this.otherserviceform.controls['homeReferral'].value,
                homeCurrent : this.otherserviceform.controls['homeCurrent'].value,
                homeNotes : this.otherserviceform.controls['homeNotes'].value,
                pregnancyReferral : this.otherserviceform.controls['pregnancyReferral'].value,
                pregnancyCurrent : this.otherserviceform.controls['pregnancyCurrent'].value,
                interventionReferral : this.otherserviceform.controls['interventionReferral'].value,
                interventionCurrent : this.otherserviceform.controls['interventionCurrent'].value,
                birthReferral : this.otherserviceform.controls['birthReferral'].value,
                birthCurrent : this.otherserviceform.controls['birthCurrent'].value,
                publicReferral : this.otherserviceform.controls['publicReferral'].value,
                publicCurrent : this.otherserviceform.controls['publicCurrent'].value,
                parentingReferral :this.otherserviceform.controls['parentingReferral'].value,
                parentingCurrent : this.otherserviceform.controls['parentingCurrent'].value,
                otherReferral : this.otherserviceform.controls['otherReferral'].value,
                otherCurrent : this.otherserviceform.controls['otherCurrent'].value,
                otherNotes : this.otherserviceform.controls['otherNotes'].value,
                noneIdentified : this.otherserviceform.controls['noneIdentified'].value,
                noneIdentifiedReason : this.otherserviceform.controls['noneIdentifiedReason'].value,
            },    
            "establishedServices":{
                "supportitemsFormArray" : supportFormArray.value,
                "unitedwayitemsFormArray" : unitedwayFormArray.value,
                "housingitemsFormArray" :housingFormArray.value,
                "paroleitemsFormArray" : paroleFormArray.value,
                "drugitemsFormArray" :drugFormArray.value,
                "additionalitemsFormArray" :additionalFormArray.value

            }
      } 
     }
    
      aa.otherservices = sectionobj.sectionFour;
      localStorage.setItem('generateObjectReq',JSON.stringify(aa));
     
    }
    goToPrevious()
    {
      const url = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/service-plan/plan-of-safecare' + '/section-three'
      this._router.navigate([url],{relativeTo :this.route});
      this._sharedService.emitChange("SectionThree");
    }

    getEstablishedServiceFormFn(i: any) {
        return this.establishedServiceForm.get(['supportitemsFormArray', i, 'supportapptdate']);
    }
    setSupportValidation(val: any,i: any)
    {
        const value = this.getEstablishedServiceFormFn(i);
        if(value) {
            if (val == 'no' || val == 'yes' ) {
                value.setValidators([Validators.required]);
                this.setsupportrequiredsymbol = true;    
            }
            if(val == 'na' || val == null) {
                value.clearValidators();
                this.setsupportrequiredsymbol = false; 
                value.markAsDirty();
            }
               
            value.updateValueAndValidity();
        }
          this.saveAsDraftSectionDetail();
    }

    getEstablishedServiceForm2Fn(i: any) {
        return this.establishedServiceForm.get(['unitedwayitemsFormArray', i, 'unitedwayapptdate']);
    }
    setUnitedwayValidation(value: any,i: any)
    {
        const val = this.getEstablishedServiceForm2Fn(i);
        if(val) {
            if (value == 'no' || value == 'yes' ) {
                val.setValidators([Validators.required]);
                this.setunitedwayrequiredsymbol = true;    
            }
             if(value == 'na' || value == null) {
                val.clearValidators();
                this.setunitedwayrequiredsymbol = false; 
                val.markAsDirty();
    
            }      
            val.updateValueAndValidity();
        }
        this.saveAsDraftSectionDetail();
    }

    getEstablishedServiceForm3Fn(i: any) {
        return this.establishedServiceForm.get(['housingitemsFormArray', i, 'housingapptdate']);
    }
    setHousingValidation(value: any,i: any) {
        const val = this.getEstablishedServiceForm3Fn(i);
        if(val) {
            if (value == 'no' || value == 'yes' ) {
                val.setValidators([Validators.required]);
                this.sethousingrequiredsymbol = true;    
            }
            if(value == 'na' || value == null) {
                val.clearValidators();
                this.sethousingrequiredsymbol = false; 
                val.markAsDirty();
            }  
              
              val.updateValueAndValidity();
            }
            this.saveAsDraftSectionDetail();
          
    }

    getEstablishedServiceForm4Fn(i: any) {
        return this.establishedServiceForm.get(['paroleitemsFormArray', i, 'paroleapptdate']);
    }
    setParoleValidation(value: any,i: any)
    {
        const val = this.getEstablishedServiceForm4Fn(i);
        if(val) {
            if (value == 'no' || value == 'yes' ) {
                val.setValidators([Validators.required]);
                this.setparolerequiredsymbol = true;    
            }
            if(value == 'na' || value == null) {
                val.clearValidators();
                this.setparolerequiredsymbol = false; 
                val.markAsDirty();
    
            }      
            val.updateValueAndValidity();
        }
          this.saveAsDraftSectionDetail();
          
    }

    getEstablishedServiceForm5Fn(i: any) {
        return this.establishedServiceForm.get(['drugitemsFormArray', i, 'drugapptdate']);
    }
    setDrugValidation(value: any,i: any)
    {
        const val = this.getEstablishedServiceForm5Fn(i);
        if(val) {
            if (value == 'no' || value == 'yes' ) {
                val.setValidators([Validators.required]);
                this.setdrugrequiredsymbol = true;    
            }
            if(value == 'na' || value == null) {
                val.clearValidators();
                this.setdrugrequiredsymbol = false; 
                val.markAsDirty();
    
            }      
            val.updateValueAndValidity();
        }
          this.saveAsDraftSectionDetail();
          
    }

    getEstablishedServiceForm6Fn(i: any) {
        return this.establishedServiceForm.get(['additionalitemsFormArray', i, 'additionalapptdate']);
    }
    setAdditionalValidation(value: any,i: any)
    {
        const val = this.getEstablishedServiceForm6Fn(i);
        if(val) {
            if (value == 'no' || value == 'yes' ) {
                val.setValidators([Validators.required]);
                this.setadditionalrequiredsymbol = true;    
            }
            if(value == 'na' || value == null) {
                val.clearValidators();
                this.setadditionalrequiredsymbol = false; 
                val.markAsDirty();
    
            }      
            val.updateValueAndValidity();
        }
          this.saveAsDraftSectionDetail();
          
    }
    txtchange()
    {
        this.saveAsDraftSectionDetail(false);
    }

    getEstablishedServiceFormData(name: string): any[] {
        return Object.values((this.establishedServiceForm.get(name) as FormGroup).controls);
    }
}