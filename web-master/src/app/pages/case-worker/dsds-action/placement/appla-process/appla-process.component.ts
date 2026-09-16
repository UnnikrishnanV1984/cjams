import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { DataStoreService, SessionStorageService } from '../../../../../@core/services';
import { ApplaProcessService } from './appla-process.service';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';

@Component({
    selector: 'appla-process',
    templateUrl: './appla-process.component.html',
    standalone: false
})
export class ApplaProcessComponent implements OnInit {

  showGrid = true;
  id: any;
  daNumber: any;
  child: any;

  constructor(private route: ActivatedRoute,
    private _router: Router,
    private _dataStoreService: DataStoreService,
    private _service: ApplaProcessService, 
    private storage: SessionStorageService,
    ) {
    this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
  }

  ngOnInit() {
    this.child = this.storage.getObj('placed_child');
    if (!this.child) {
      this._service.getPage(1).subscribe(response => {
        if (response && response.data && Array.isArray(response.data) && response.data.length > 0) {
          const applaAssessment = response.data.find(assessment => assessment.description === 'APPLA');
          this.handleIntakassessmentChildDataFn(applaAssessment);
        }
      });
    }
  }
  // Assosiated with ngOnInit method
  private handleIntakassessmentChildDataFn(applaAssessment: any) {
    if (applaAssessment && applaAssessment.intakassessment
      && Array.isArray(applaAssessment.intakassessment)
      && applaAssessment.intakassessment.length > 0) {
      const currentAssessment = applaAssessment.intakassessment[0];
      if (currentAssessment && currentAssessment.submissiondata && currentAssessment.submissiondata.child) {
        this.child = currentAssessment.submissiondata.child;
        this.storage.setObj('placed_child', this.child);
      }

    }
  }

  close() {
    this._router.navigate(['../../'], { relativeTo: this.route });
  }


}
