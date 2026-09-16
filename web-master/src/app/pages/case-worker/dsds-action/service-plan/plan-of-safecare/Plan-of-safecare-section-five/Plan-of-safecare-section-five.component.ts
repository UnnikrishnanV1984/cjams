import { Component } from "@angular/core";
import { FormArray, FormBuilder, FormGroup, Validators } from "@angular/forms";
import { ActivatedRoute, Router } from "@angular/router";
import { CASE_STORE_CONSTANTS } from "../../../../../case-worker/_entities/caseworker.data.constants";
import { DataStoreService,AlertService } from "../../../../../../@core/services";
import { SharedService } from "../../_service/shared-service";

@Component({
    selector: 'plan-of-safecare-five',
    templateUrl: './Plan-of-safecare-section-five.component.html',
    styleUrls: ['./Plan-of-safecare-section-five.component.scss'],
    standalone: false
})
export class PlanOfSafeCareFiveComponent {
    ReviewDiscussForm!: FormGroup;
    sleepingitemsForm!: FormGroup;
    copingitemsForm!: FormGroup;
    homesafetyitemsForm!: FormGroup;
    firesafetyitemsForm!: FormGroup;
    fireescapeitemsForm!: FormGroup;
    id: any;
    daNumber: any;
    sectionOneMemberData: any;
    sleepingitemsFormArray!: FormArray;
    copingitemsFormArray!: FormArray;
    homesafetyitemsFormArray!: FormArray;
    firesafetyitemsFormArray!: FormArray;
    fireescapeitemsFormArray!: FormArray;
  setsleepingrequiredsymbol!: boolean;
  setcopingrequiredsymbol!: boolean;
  sethomesafetyrequiredsymbol!: boolean;
  setfiresafetyrequiredsymbol!: boolean;
  setfireescaperequiredsymbol!: boolean;
  checkforrequired: boolean= false;


    constructor(private _formBuilder: FormBuilder,   private _router:Router, private route: ActivatedRoute, 
        private _datastore: DataStoreService,private _sharedService : SharedService,private _alertservice : AlertService)
    {
        this.id = this._datastore.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._datastore.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    }
    ngOnInit() {
        this.initReviewForm();
        this.loadFamilyMember();
        const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
        const aa = JSON.parse(generateObjectReqId);
        const secfivelength = Object.keys(aa.planreviewdetails).length;
        let familymembers: any[] = [];
        aa?.persondetails?.data?.forEach((item: any) => {
            let familymember = item.familymember;
            if(item.familymember === 'Parent') {
                familymember = 'Parent 1';
            }
            familymembers.push(familymember)
        });
        let reviewdiscuss: any = {};
        for (let item in aa.planreviewdetails.reviewdiscuss) {
            reviewdiscuss[item] = reviewdiscuss[item] || [];
            for (let value of aa.planreviewdetails.reviewdiscuss[item]) {
                let familymember = value.familymember;
                if(familymember === 'Parent') {
                    familymember = 'Parent 1';
                }
                if (familymembers.indexOf(familymember) > -1) {
                    reviewdiscuss[item].push(value)
                }
            }
        }
        if(secfivelength > 0) {
            this.ReviewDiscussForm.patchValue(reviewdiscuss);
            this.setValidations(aa);
        }
    }

  setValidations(aa: any) {
    const sleeping = aa.planreviewdetails.reviewdiscuss.sleepingitemsFormArray.filter((entry1: any) => this.sectionOneMemberData.some((entry2: any) => entry1.familymember === entry2.familymember));
    const coping = aa.planreviewdetails.reviewdiscuss.copingitemsFormArray.filter((entry1: any) => this.sectionOneMemberData.some((entry2: any) => entry1.familymember === entry2.familymember));
    const homesafety = aa.planreviewdetails.reviewdiscuss.homesafetyitemsFormArray.filter((entry1: any) => this.sectionOneMemberData.some((entry2: any) => entry1.familymember === entry2.familymember));
    const firesafety = aa.planreviewdetails.reviewdiscuss.firesafetyitemsFormArray.filter((entry1: any) => this.sectionOneMemberData.some((entry2: any) => entry1.familymember === entry2.familymember));
    const fireescape = aa.planreviewdetails.reviewdiscuss.fireescapeitemsFormArray.filter((entry1: any) => this.sectionOneMemberData.some((entry2: any) => entry1.familymember === entry2.familymember));
    if (sleeping.length > 0) {
      for (let i = 0; i < sleeping.length; i++) {
        this.setSleepingValidation(sleeping[i].sleepingcomments, i);
      }
    }
    if (coping.length > 0) {
      for (let i = 0; i < coping.length; i++) {
        this.setCopingValidation(coping[i].copingcomments, i);
      }
    }
    if (homesafety.length > 0) {
      for (let i = 0; i < homesafety.length; i++) {
        this.setHomesafetyValidation(homesafety[i].homesafetycomments, i);
      }
    }
    if (firesafety.length > 0) {
      for (let i = 0; i < firesafety.length; i++) {
        this.setFiresafetyValidation(firesafety[i].homesafetycomments, i);
      }
    }
    if (fireescape.length > 0) {
      for (let i = 0; i < fireescape.length; i++) {
        this.setFireescapeValidation(fireescape[i].fireescapecomments, i);
      }
    }
  }
   
    initReviewForm()
    {
       this.ReviewDiscussForm = this._formBuilder.group({
         sleepingitems  : new FormArray([]),
         copingitems : new FormArray([]),
         homesafetyitems : new FormArray([]),
         firesafetyitems : new FormArray([]),
         fireescapeitems : new FormArray([]),
         sleepingitemsFormArray : this._formBuilder.array([this.createsleepingitemsFormArray()]),
         copingitemsFormArray : this._formBuilder.array([this.createcopingitemsFormArray()]),
         homesafetyitemsFormArray : this._formBuilder.array([this.createhomesafetyitemsFormArray()]),
         firesafetyitemsFormArray : this._formBuilder.array([this.createfiresafetyitemsFormArray()]),
         fireescapeitemsFormArray : this._formBuilder.array([this.createfireescapeitemsFormArray()])
       });
    }
    createsleepingitemsFormArray()
    {
        return this._formBuilder.group({
          sleepingreviewed: ['',Validators.required],
          sleepingcomments: ['']
        })
    }
    createcopingitemsFormArray()
    {
        return this._formBuilder.group({
          copingreviewed: ['',Validators.required],
          copingcomments: ['']
        })
    }
    createhomesafetyitemsFormArray()
    {
        return this._formBuilder.group({
          homesafetyreviewed: ['',Validators.required],
          homesafetycomments: ['']
        });
    }
    createfiresafetyitemsFormArray()
    {
        return this._formBuilder.group({
          firesafetyreviewed: ['',Validators.required],
          firesafetycomments: ['']
        });
    }
    createfireescapeitemsFormArray()
    {
      return this._formBuilder.group({
          fireescaoereviewed: ['',Validators.required],
          fireescapecomments: ['']
        });
    }

    loadFamilyMember()
    {
      const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
      const sectionObj = JSON.parse(generateObjectReqId);
          this.sectionOneMemberData = sectionObj.persondetails.data || [];        
          this.setFormvalues();     
    }

    setFormvalues() {
      this.sectionOneMemberData = this.sectionOneMemberData.filter((x: { familymember: string | string[]; }) => !x.familymember.includes("Newborn"));
      this.ReviewDiscussForm.setControl('sleepingitemsFormArray', this._formBuilder.array([]));
      const sleepingcontrol = <FormArray>this.ReviewDiscussForm.controls['sleepingitemsFormArray'];
      this.sectionOneMemberData.forEach((x: any) => {
        sleepingcontrol.push(this.buildSleepingServiceForm(x));
      });
      
      this.ReviewDiscussForm.setControl('copingitemsFormArray', this._formBuilder.array([]));
      const copingcontrol = <FormArray>this.ReviewDiscussForm.controls['copingitemsFormArray'];
      this.sectionOneMemberData.forEach((x: any) => {
        copingcontrol.push(this.buildCopingServiceForm(x));
      });
    
    this.ReviewDiscussForm.setControl('homesafetyitemsFormArray', this._formBuilder.array([]));
    const homesafetycontrol = <FormArray>this.ReviewDiscussForm.controls['homesafetyitemsFormArray'];
    this.sectionOneMemberData.forEach((x: any) => {
      homesafetycontrol.push(this.buildHomeSafetyServiceForm(x));
    });
    
    this.ReviewDiscussForm.setControl('firesafetyitemsFormArray', this._formBuilder.array([]));
    const firesafetycontrol = <FormArray>this.ReviewDiscussForm.controls['firesafetyitemsFormArray'];
    this.sectionOneMemberData.forEach((x: any) => {
      firesafetycontrol.push(this.buildFireSafetyServiceForm(x));
    });
    this.ReviewDiscussForm.setControl('fireescapeitemsFormArray', this._formBuilder.array([]));
    const fireescapecontrol = <FormArray>this.ReviewDiscussForm.controls['fireescapeitemsFormArray'];
    this.sectionOneMemberData.forEach((x: any) => {
      fireescapecontrol.push(this.buildFireEscapeServiceForm(x));
    });
  }

    private buildSleepingServiceForm(x: {personid: any; sleepingreviewed: any; sleepingcomments: any; familymember: any; }): FormGroup {
      return this._formBuilder.group({
        sleepingreviewed: x.sleepingreviewed,
        sleepingcomments: x.sleepingcomments,
        familymember : x.familymember,
        personid: x.personid
      });
    }

    private buildCopingServiceForm(x: {personid: any; copingreviewed: any; copingcomments: any; familymember: any; }): FormGroup {
      return this._formBuilder.group({
        copingreviewed: x.copingreviewed,
        copingcomments: x.copingcomments,
        familymember : x.familymember,
        personid: x.personid
      });
    }
    private buildHomeSafetyServiceForm(x: {personid: any; homesafetyreviewed: any; homesafetycomments: any; familymember: any; }): FormGroup {
      return this._formBuilder.group({
        homesafetyreviewed: x.homesafetyreviewed,
        homesafetycomments: x.homesafetycomments ,
        familymember : x.familymember,
        personid: x.personid
      });
    }
    private buildFireSafetyServiceForm(x: {personid: any; firesafetyreviewed: any; firesafetycomments: any; familymember: any; }): FormGroup {
      return this._formBuilder.group({
        firesafetyreviewed: x.firesafetyreviewed,
        firesafetycomments: x.firesafetycomments,
        familymember : x.familymember,
        personid: x.personid
      });
    }
    private buildFireEscapeServiceForm(x: {personid: any; fireescaoereviewed: any; fireescapecomments: any; familymember: any; }): FormGroup {
      return this._formBuilder.group({
        fireescapereviewed: x.fireescaoereviewed,
        fireescapecomments: x.fireescapecomments ,
        familymember : x.familymember ,
        personid: x.personid
      });
    }

    goToPrevious()
    {
      const url = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/service-plan/plan-of-safecare' + '/section-four'
      this._router.navigate([url],{relativeTo :this.route});
      this._sharedService.emitChange("SectionFour");
    }

    saveSectionDetail()
    {
      this.checkforrequired = true;
      const sleepingFormArray: FormArray = this.ReviewDiscussForm.get('sleepingitemsFormArray') as FormArray;
      const copingFormArray: FormArray = this.ReviewDiscussForm.get('copingitemsFormArray') as FormArray;
      const homesafetyFormArray: FormArray = this.ReviewDiscussForm.get('homesafetyitemsFormArray') as FormArray;
      const firesafetyFormArray: FormArray = this.ReviewDiscussForm.get('firesafetyitemsFormArray') as FormArray;
      const fireescapeFormArray: FormArray = this.ReviewDiscussForm.get('fireescapeitemsFormArray') as FormArray;
      const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
        const aa = JSON.parse(generateObjectReqId);
        const sectionobj = {
            "sectionFive" : { 
              "reviewdiscuss":{
                  "sleepingitemsFormArray" : sleepingFormArray.value,
                  "copingitemsFormArray" : copingFormArray.value,
                  "homesafetyitemsFormArray" : homesafetyFormArray.value,
                  "firesafetyitemsFormArray" : firesafetyFormArray.value,
                  "fireescapeitemsFormArray" : fireescapeFormArray.value
  
              }
        } 
       }
        aa.planreviewdetails = sectionobj.sectionFive;
        localStorage.setItem('generateObjectReq',JSON.stringify(aa));
        const url = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/service-plan/plan-of-safecare' + '/section-six'
        this._router.navigate([url],{relativeTo :this.route});
        this._sharedService.emitChange("SectionSix");        
    }
  saveAsDraftSectionDetail() {
    const sleepingFormArray: FormArray = this.ReviewDiscussForm.get('sleepingitemsFormArray') as FormArray;
    const copingFormArray: FormArray = this.ReviewDiscussForm.get('copingitemsFormArray') as FormArray;
    const homesafetyFormArray: FormArray = this.ReviewDiscussForm.get('homesafetyitemsFormArray') as FormArray;
    const firesafetyFormArray: FormArray = this.ReviewDiscussForm.get('firesafetyitemsFormArray') as FormArray;
    const fireescapeFormArray: FormArray = this.ReviewDiscussForm.get('fireescapeitemsFormArray') as FormArray;
    const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
    const aa = JSON.parse(generateObjectReqId);
    const sectionobj = {
      "sectionFive": {
        "reviewdiscuss": {
          "sleepingitemsFormArray": sleepingFormArray.value,
          "copingitemsFormArray": copingFormArray.value,
          "homesafetyitemsFormArray": homesafetyFormArray.value,
          "firesafetyitemsFormArray": firesafetyFormArray.value,
          "fireescapeitemsFormArray": fireescapeFormArray.value
        }
      }
    }
    aa.planreviewdetails = sectionobj.sectionFive;
    localStorage.setItem('generateObjectReq', JSON.stringify(aa));
  }

  getEstablishedServiceForm1Fn(i: any) {
    return this.ReviewDiscussForm.get(['sleepingitemsFormArray', i, 'sleepingcomments']);
  }
    setSleepingValidation(value: any,i: any)
    {
      const val = this.getEstablishedServiceForm1Fn(i);
      if(val) {
        if (value == 'no' || value == 'yes' ) {
            val.setValidators([Validators.required]);
            this.setsleepingrequiredsymbol = true;    
        }
        if(value == 'na' || value == null) {
            val.clearValidators();
            this.setsleepingrequiredsymbol = false; 
            val.markAsDirty();

        }      
          val.updateValueAndValidity();
      }
         this.saveAsDraftSectionDetail();
          
    }

    getEstablishedServiceForm2Fn(i: any) {
      return this.ReviewDiscussForm.get(['copingitemsFormArray', i, 'copingcomments']);
    }
    setCopingValidation(value: any,i: any)
    {
      const val = this.getEstablishedServiceForm2Fn(i);
      if(val) {
        if (value == 'no' || value == 'yes' ) {
            val.setValidators([Validators.required]);
            this.setcopingrequiredsymbol = true;    
        }
        if(value == 'na' || value == null) {
            val.clearValidators();
            this.setcopingrequiredsymbol = false;
            val.markAsDirty();

        }      
          val.updateValueAndValidity();
      }
          this.saveAsDraftSectionDetail();
         
          
    }

    getEstablishedServiceForm3Fn(i: any) {
      return this.ReviewDiscussForm.get(['homesafetyitemsFormArray', i, 'homesafetycomments']);
    }
    setHomesafetyValidation(value: any,i: any)
    {
      const val = this.getEstablishedServiceForm3Fn(i);
      if(val) {
        if (value == 'no' || value == 'yes' ) {
            val.setValidators([Validators.required]);
            this.sethomesafetyrequiredsymbol = true;    
        }
        if(value == 'na' || value == null) {
            val.clearValidators();
            this.sethomesafetyrequiredsymbol = false; 
            val.markAsDirty();

        }      
          val.updateValueAndValidity();
      }
          this.saveAsDraftSectionDetail();        
          
    }

    getEstablishedServiceForm4Fn(i: any) {
      return this.ReviewDiscussForm.get(['firesafetyitemsFormArray', i, 'firesafetycomments']);
    }
    setFiresafetyValidation(value: any,i: any)
    {
      const val = this.getEstablishedServiceForm4Fn(i);
      if(val) {
        if (value == 'no' || value == 'yes' ) {
            val.setValidators([Validators.required]);
            this.setfiresafetyrequiredsymbol = true;    
        }
        if(value == 'na' || value == null) {
            val.clearValidators();
            this.setfiresafetyrequiredsymbol = false; 
            val.markAsDirty();

        }      
          val.updateValueAndValidity();
      }
          this.saveAsDraftSectionDetail();
                   
    }

    getEstablishedServiceForm5Fn(i: any) {
      return this.ReviewDiscussForm.get(['fireescapeitemsFormArray', i, 'fireescapecomments']);
    }
    setFireescapeValidation(value: any,i: any)
    {
      const val = this.getEstablishedServiceForm5Fn(i);
      if(val) {
        if (value == 'no' || value == 'yes' ) {
            val.setValidators([Validators.required]);
            this.setfireescaperequiredsymbol = true;    
        }
        if(value == 'na' || value == null) {
            val.clearValidators();
            this.setfireescaperequiredsymbol = false; 
            val.markAsDirty();

        }      
          val.updateValueAndValidity();
      }
          this.saveAsDraftSectionDetail();         
          
    }

    textChange() {
      this.saveAsDraftSectionDetail(); 
    }

    getReviewDiscussFormData(name: string): any[] {
      return Object.values((this.ReviewDiscussForm.get(name) as FormGroup).controls);
    }

}