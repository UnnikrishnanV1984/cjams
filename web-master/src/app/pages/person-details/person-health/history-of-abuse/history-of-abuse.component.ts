
import {map, pluck, share} from 'rxjs/operators';
import { Component, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { HistoryofAbuse } from '../../../../@core/common/models/involvedperson.data.model';
import { AlertService, CommonHttpService } from '../../../../@core/services';
import { CommonUrlConfig } from '../../../../@core/common/URLs/common-url.config';
import { GLOBAL_MESSAGES } from '../../../../@core/entities/constants';
import { PaginationRequest } from '../../../../@core/entities/common.entities';
import { PersonDetailsService } from '../../person-details.service';
import { Observable } from 'rxjs';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'history-of-abuse',
    templateUrl: './history-of-abuse.component.html',
    styleUrls: ['./history-of-abuse.component.scss'],
    standalone: false
})
export class HistoryOfAbuseComponent implements OnInit {

  historyofabuseForm!: FormGroup;
  physicalabuseSelectionEnabled!: boolean | null;
  emotionalabuseSelectionEnabled!: boolean | null;
  sexualabuseSelectionEnabled!: boolean | null;
  neglectSelectionEnabled!: boolean | null;
  historyOfAbuse$ = new Observable<HistoryofAbuse[]>();
  resourceID!: string | null;
  reportMode!: string;
  editMode!: boolean;
  deletehistoryofabusepopup = '#delete-historyofabuse-popup';

  constructor(private formbulider: FormBuilder,
    private _alertSevice: AlertService,
    public _personDetailService: PersonDetailsService,
    private _commonHttpService: CommonHttpService) { }

  ngOnInit() {
    this.historyofabuseForm = this.formbulider.group({
      isneglect: null,
      neglectnotes: '',
      isphysicalabuse: null,
      physicalnotes: '',
      isemotionalabuse: null,
      emotionalnotes: '',
      issexualabuse: null,
      sexualnotes: ''
    });
    this.physicalabuseSelectionEnabled = false;
    this.emotionalabuseSelectionEnabled = false;
    this.sexualabuseSelectionEnabled = false;
    this.neglectSelectionEnabled = false;
    this.reportMode = 'add';
    this.editMode = false;

    this.historyOfAbuse$ = <Observable<HistoryofAbuse[]>>this.getList();

    this.historyOfAbuse$.subscribe((element: any) => {
      this.resourceID = element[0].personabusehistoryid;
      this.reportMode = 'edit';
      this.editMode = true;
      this.historyofabuseForm.patchValue(element[0]);
      this.physicalabuseSelectionEnabled = element[0].isphysicalabuse;
      this.emotionalabuseSelectionEnabled = element[0].isemotionalabuse;
      this.sexualabuseSelectionEnabled = element[0].issexualabuse;
      this.neglectSelectionEnabled = element[0].isneglect;
      setTimeout(() => {
        this.emotionalabuseSelection(element[0].isemotionalabuse);
        this.physicalabuseSelection(element[0].isphysicalabuse);
        this.sexualabuseSelection(element[0].issexualabuse);
        this.neglectSelection(element[0].isneglect);
      }, 1000);
    });
  }

  resetForm() {
    this.historyofabuseForm.reset();
    this.emotionalabuseSelection(false);
    this.physicalabuseSelection(false);
    this.sexualabuseSelection(false);
    this.neglectSelection(false);
  }


  neglectSelection(control: any) {
    if (control) {
      this.neglectSelectionEnabled = true;
      this.historyofabuseForm.get('neglectnotes')?.enable();
      this.historyofabuseForm.get('neglectnotes')?.setValidators([Validators.required]);
      this.historyofabuseForm.get('neglectnotes')?.updateValueAndValidity();

    } else {
      this.neglectSelectionEnabled = false;
      this.historyofabuseForm.get('neglectnotes')?.disable();
      this.historyofabuseForm.get('neglectnotes')?.clearValidators();
      this.historyofabuseForm.get('neglectnotes')?.updateValueAndValidity();

    }
  }


  sexualabuseSelection(control: any) {
    if (control) {
      this.sexualabuseSelectionEnabled = true;
      this.historyofabuseForm.get('sexualnotes')?.enable();
      this.historyofabuseForm.get('sexualnotes')?.setValidators([Validators.required]);
      this.historyofabuseForm.get('sexualnotes')?.updateValueAndValidity();

    } else {
      this.sexualabuseSelectionEnabled = false;
      this.historyofabuseForm.get('sexualnotes')?.disable();
      this.historyofabuseForm.get('sexualnotes')?.clearValidators();
      this.historyofabuseForm.get('sexualnotes')?.updateValueAndValidity();

    }
  }


  emotionalabuseSelection(control: any) {
    if (control) {
      this.emotionalabuseSelectionEnabled = true;
      this.historyofabuseForm.get('emotionalnotes')?.enable();
      this.historyofabuseForm.get('emotionalnotes')?.setValidators([Validators.required]);
      this.historyofabuseForm.get('emotionalnotes')?.updateValueAndValidity();

    } else {
      this.emotionalabuseSelectionEnabled = false;
      this.historyofabuseForm.get('emotionalnotes')?.disable();
      this.historyofabuseForm.get('emotionalnotes')?.clearValidators();
      this.historyofabuseForm.get('emotionalnotes')?.updateValueAndValidity();

    }
  }


  physicalabuseSelection(control: any) {
    if (control) {
      this.physicalabuseSelectionEnabled = true;
      this.historyofabuseForm.get('physicalnotes')?.enable();
      this.historyofabuseForm.get('physicalnotes')?.setValidators([Validators.required]);
      this.historyofabuseForm.get('physicalnotes')?.updateValueAndValidity();

    } else {
      this.physicalabuseSelectionEnabled = false;
      this.historyofabuseForm.get('physicalnotes')?.disable();
      this.historyofabuseForm.get('physicalnotes')?.clearValidators();
      this.historyofabuseForm.get('physicalnotes')?.updateValueAndValidity();

    }
  }

  addUpdate(historyofabuseForm: any) {
    historyofabuseForm.personabusehistoryid = this.resourceID;
    this._commonHttpService.create(historyofabuseForm, CommonUrlConfig.EndPoint.PERSON.MEDICAL.historyofabuseAdd).subscribe(() => {
      this._alertSevice.success('History of abuse details saved successfully!');
      this.getList();
    }, (_error: any) => {
      this.getList();
      this._alertSevice.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
    });
  }

  getList() {
    const source = this._commonHttpService.getPagedArrayList(
      new PaginationRequest(
        {
          method: 'get',
          where: { personid: this._personDetailService.person.personid },
          page: 1,
          limit: 10,
        }),
      CommonUrlConfig.EndPoint.PERSON.MEDICAL.historyofabuseList + '?filter'
    ).pipe(map((result: any) => {
      return {
        data: result
      };
    }),share(),);
    return source.pipe(pluck('data'));
  }


  showDeletePop() {
    (<any>$(this.deletehistoryofabusepopup)).modal('show');
  }

  delete() {
    this._commonHttpService.endpointUrl = CommonUrlConfig.EndPoint.PERSON.MEDICAL.HealthExamInfoDelete;
    return this._commonHttpService.remove(this.resourceID).subscribe(() => {
        this.resourceID = null;
        this.resetForm();
        this._alertSevice.success('History Of Abuse deleted successfully');
        (<any>$(this.deletehistoryofabusepopup)).modal('hide');
      },
      (_error: any) => {
        this.resourceID = null;
        this._alertSevice.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        (<any>$(this.deletehistoryofabusepopup)).modal('hide');
      }
    );
  }
}
