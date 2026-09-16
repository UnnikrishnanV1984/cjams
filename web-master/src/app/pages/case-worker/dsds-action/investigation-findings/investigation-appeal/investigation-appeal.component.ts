import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { CommonHttpService } from '../../../../../@core/services';

@Component({
    selector: 'investigation-appeal',
    templateUrl: './investigation-appeal.component.html',
    standalone: false
})
export class InvestigationAppealComponent implements OnInit {
  supervisoryConferenceForm!: FormGroup;
  conferenceDecisions: any = [];
  appealTypes: any;

  constructor(
    private _formBuilder: FormBuilder,
    private _commonHttpService: CommonHttpService
  ) { }

  ngOnInit() {
    this.initFormGroup();
    this.loadAppealTypes();
  }

  initFormGroup() {
    this.supervisoryConferenceForm = this._formBuilder.group({
      sendOutDate: [null],
      conferenceHeld: [null],
      conferenceDate: [null],
      conferenceDecision: [null],
      conferenceDetails: [null],
      appealType: [null]
    });
  }

  loadAppealTypes() {
    this._commonHttpService.getArrayList({
      nolimit: true,
      where: { referencetypeid: 96 }, order: 'displayorder ASC', method: 'get'
    },
      'referencevalues?filter').subscribe(res => {
        this.appealTypes = res;
      });
  }

  addAppeal() {
   // No content to add or call //NOSONAR
  }

}
