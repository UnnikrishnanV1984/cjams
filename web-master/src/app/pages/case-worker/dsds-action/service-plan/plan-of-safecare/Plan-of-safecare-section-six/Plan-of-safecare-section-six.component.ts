import { Component } from "@angular/core";
import { FormBuilder, FormGroup } from "@angular/forms";
import { ActivatedRoute, Router } from "@angular/router";
import { CASE_STORE_CONSTANTS } from "../../../../../case-worker/_entities/caseworker.data.constants";
import { DataStoreService } from "../../../../../../@core/services";
import { SharedService } from "../../_service/shared-service";

@Component({
    selector: 'plan-of-safecare-six',
    templateUrl: './Plan-of-safecare-section-six.component.html',
    styleUrls: ['./Plan-of-safecare-section-six.component.scss'],
    standalone: false
})
export class PlanOfSafeCareSixComponent {
    commentsForm!: FormGroup;
    id: any;
    daNumber: any;
    
    constructor(private _formBuilder: FormBuilder,   private _router:Router, private route: ActivatedRoute, 
        private _datastore: DataStoreService,private _sharedService : SharedService)
    {
        this.id = this._datastore.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.daNumber = this._datastore.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
    }
    ngOnInit() {
        this.initcommentsForm();
        const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
        let aa = JSON.parse(generateObjectReqId);
        this.commentsForm.patchValue({
            comments: aa.comments || ''
        });
    }

    initcommentsForm()
    {
        this.commentsForm = this._formBuilder.group({
            comments : ['']
        });
    }

    textchange()
    {
        this.saveAsDraftSectionDetail();
    }

    saveAsDraftSectionDetail()
    {
        const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
        let aa = JSON.parse(generateObjectReqId);
        const sectionobj = {
            "sectionSix" : {      
             "comments" : this.commentsForm.controls['comments'].value
         } 
       }
        aa.comments = sectionobj.sectionSix.comments;
        localStorage.setItem('generateObjectReq',JSON.stringify(aa));
        

    }
    
    saveSectionDetail()
    {
        const generateObjectReqId: any = localStorage.getItem('generateObjectReq');
        let aa = JSON.parse(generateObjectReqId);
        const sectionobj = {
            "sectionSix" : {      
             "comments" : this.commentsForm.controls['comments'].value
         } 
       }
        aa.comments = sectionobj.sectionSix.comments;
        localStorage.setItem('generateObjectReq',JSON.stringify(aa));
        var url = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/service-plan/plan-of-safecare' + '/section-seven'
        this._router.navigate([url],{relativeTo :this.route});
        this._sharedService.emitChange("SectionSeven");

    }
    goToPrevious()
    {
        var url = '/pages/case-worker/' + this.id + '/' + this.daNumber + '/dsds-action/service-plan/plan-of-safecare' + '/section-five'
      this._router.navigate([url],{relativeTo :this.route});
      this._sharedService.emitChange("SectionFive");

    }
    
}