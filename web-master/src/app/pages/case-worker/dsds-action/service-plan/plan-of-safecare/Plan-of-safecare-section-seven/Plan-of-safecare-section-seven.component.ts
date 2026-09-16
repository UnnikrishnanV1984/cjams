import { Component,OnInit} from "@angular/core";
import { FormBuilder, FormGroup } from "@angular/forms";
import { CASE_STORE_CONSTANTS, CASE_TYPE_CONSTANTS } from "../../../../../case-worker/_entities/caseworker.data.constants";
import { CommonHttpService, DataStoreService, SessionStorageService } from "../../../../../../@core/services";
import { AppUser } from "../../../../../../@core/entities/authDataModel";
import { ActivatedRoute, Router } from "@angular/router";
import { SharedService } from "../../_service/shared-service";

@Component({
    selector: 'plan-of-safecare-seven',
    templateUrl: './Plan-of-safecare-section-seven.component.html',
    styleUrls: ['./plan-of-safecare-section-seven.component.scss'],
    standalone: false
})
export class PlanOfSafeCareSevenComponent implements OnInit{



   showrole : boolean =false;
    isAdoptionCase!: boolean;
    intakeserviceid = '';
    personList!: any[];
    selectedClientName: string = '';
    personDataList!: any[];
    childList: any[] = [];
    personListName: any;
    legalGuardian = '';
    user!: AppUser;
    sectiononedata!: any[];
    candidacyRoles: string[] = ['CHILD', 'OTHERCHILD', 'AV'];
    roleform!: FormGroup;
    showClientDropdown: boolean = false;
    secsevencollectionlist : any[] = [];
    deletetype: any;
    deleteObject: any;
    id: any;
    daNumber: any;
    isupdate :boolean = false;
    index:any;
    isViewMode: boolean = false;

    constructor(private _formBuilder: FormBuilder, private _datastore: DataStoreService,
        private _commonhttp: CommonHttpService, private _session: SessionStorageService,
        private _router:Router, private route: ActivatedRoute, private _sharedService : SharedService
        ) {
            this.id = this._datastore.getData(CASE_STORE_CONSTANTS.CASE_UID);
            this.daNumber = this._datastore.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
         }

    ngOnInit() {
        this.getsectiononedata();
        this.initmemberForm();

       
        const caseType = this._datastore.getData(CASE_STORE_CONSTANTS.CASE_TYPE);
        this.intakeserviceid = this._datastore.getData(CASE_STORE_CONSTANTS.CASE_UID);

        if (caseType === CASE_TYPE_CONSTANTS.ADOPTION) {
            this.isAdoptionCase = true;
        }
    }
    getsectiononedata() {

        const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
        var aa = JSON.parse(generateObjectReqId);
        this.isViewMode = aa.isViewMode;
        const seconelength = Object.keys(aa.persondetails)
        if(seconelength.length > 0)
        {
            
            this.sectiononedata = aa.persondetails.data;
        } 
    }        
   
    initmemberForm() {
        const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
        this.roleform = this._formBuilder.group({
            
            personName : [''],
            consent:[''],
            background :[''],
            releaseofinfo :[''],
            reason:[''],
        });

        const secSevendata = JSON.parse(generateObjectReqId);
        this.secsevencollectionlist = (secSevendata?.consentform && secSevendata.consentform.data) ? secSevendata.consentform.data : [] ;

           this. loadsectionsevendata();
     
        
       
    }
    loadsectionsevendata() {

        const sectionsevendata = this.sectiononedata?.filter((obj)=>{
            return !obj.familymember.includes('Newborn');
        });

        sectionsevendata?.forEach((data)=>{
            const checkExist = this.secsevencollectionlist.filter(item => item.personName === data.personName) || [];
            if(checkExist.length === 0) {
                const memberobj = {
                    "id" : this.secsevencollectionlist.length == 0 ? 
                            this.secsevencollectionlist.length + 1:this.secsevencollectionlist[this.secsevencollectionlist.length - 1].id + 1,     
                    "personName" : data.personName,
                    "consent":this.roleform.controls['consent'].value,
                    "background" :this.roleform.controls['background'].value,
                    "releaseofinfo" :this.roleform.controls['releaseofinfo'].value,
                    "reason":this.roleform.controls['reason'].value,
                }
                this.secsevencollectionlist.push(memberobj);
            }
        })    
    }

    

    addRoleDetail()
    {
        if(this.showrole){
            
            const memberobj = {
          
                "id" : this.secsevencollectionlist.length == 0 ? 
                this.secsevencollectionlist.length + 1:this.secsevencollectionlist[this.secsevencollectionlist.length - 1].id + 1, 
                "personName" : this.roleform.controls['personName'].value,
                "consent":this.roleform.controls['consent'].value,
                "background" :this.roleform.controls['background'].value,
                "releaseofinfo" :this.roleform.controls['releaseofinfo'].value,
                "reason":this.roleform.controls['reason'].value,
                "newmemberadded" :true,
        
        }
        if(this.isupdate){
            
            this.secsevencollectionlist.splice(this.index, 1);
          
    }
    this.secsevencollectionlist.push(memberobj);
        }
        else {
        const memberobj = {
          
            "personName" : this.roleform.controls['personName'].value,
            "consent":this.roleform.controls['consent'].value,
            "background" :this.roleform.controls['background'].value,
            "releaseofinfo" :this.roleform.controls['releaseofinfo'].value,
            "reason":this.roleform.controls['reason'].value,
    
    }
    if(this.isupdate){
            
        this.secsevencollectionlist.splice(this.index, 1);
      
}
this.secsevencollectionlist.push(memberobj);
}

        
      
        this.saveSectionDetail();
        
    }
    rolememberReset()
    {
        this.roleform.reset();
        this.roleform.controls['personName'].enable();
        this.isupdate = false;
    }
   

    editrole(item: any,_type: any,index: any)
    {
        this.roleform.patchValue(item);
        this.roleform.controls['personName'].disable();
        this.index = index;
        this.isupdate = true; 
       
    }
    confirmDelete(type: any, item: any) {
        this.deletetype = type;
        this.deleteObject = item;
        (<any>$('#delete-popup')).modal('show');
      }
    
      deleteItem() {
        const index = this.secsevencollectionlist.findIndex(x => x.id === this.deleteObject.id);
        this.secsevencollectionlist.splice(index,1);
        this.saveSectionDetail()

      }
      saveSectionDetail()
      {
        const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
        var aa = JSON.parse(generateObjectReqId);
        const sectionobj = {
            "sectionSeven" : {              
               "data" : this.secsevencollectionlist
        } 
       }
        aa.consentform = sectionobj.sectionSeven;
        localStorage.setItem('generateObjectReq',JSON.stringify(aa));
        this.isupdate = false;
        this.rolememberReset();
    }

        gotoNext() {
        var url = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/service-plan/plan-of-safecare' + '/section-eight'
        this._router.navigate([url],{relativeTo :this.route});
        this._sharedService.emitChange("SectionEight");
        }

     
      goToPrevious()
      {
        var url = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/service-plan/plan-of-safecare' + '/section-six'
        this._router.navigate([url],{relativeTo :this.route});
        this._sharedService.emitChange("SectionSix");

      }

}