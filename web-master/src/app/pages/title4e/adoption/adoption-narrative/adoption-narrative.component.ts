import { Component, OnInit } from '@angular/core';
import { RecordingNotes } from '../../title-ive-foster-car/narratives/iveNarrativeModel';
import { ActivatedRoute } from '@angular/router';
import { CommonHttpService } from '../../../../@core/services/common-http.service';
import { MatDialog } from '@angular/material/dialog';
import { AlertService } from '../../../../@core/services/alert.service';
import { DataStoreService, AuthService} from '../../../../@core/services';
import { Titile4eUrlConfig } from '../../_entities/title4e-dashboard-url-config';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'adoption-narrative',
    templateUrl: './adoption-narrative.component.html',
    standalone: false
})
export class AdoptionNarrativeComponent implements OnInit {
  progressNote: RecordingNotes = new RecordingNotes();
  clientId: string='';
  isCLW: any;
  isreadonly: any;
  constructor(
    private route: ActivatedRoute,
    public dialog: MatDialog,
    private _commonHttpService: CommonHttpService,
    private _alertService: AlertService,
    private _dataStoreService: DataStoreService,
    public _authService: AuthService
  ) { }

  ngOnInit() {
    this.clientId = this.route.snapshot.params['clientid'];
    this.getNarrative(this.clientId);
    this._dataStoreService.currentStore.subscribe((item) => {
      if (item['isivereadonly']) {
        this.isreadonly = item['isivereadonly'];
      }
    });
  }

  getNarrative(clientId:string) {
    this._commonHttpService
    .create(
      {entitytypeid: clientId,
       entitytype: 'IVEADOP'},
        Titile4eUrlConfig.EndPoint.getNarrative
    )
    .subscribe(
        (response: any) => {
            if (response && response.length > 0 && response[0] !== '') {
              this.progressNote = response[0];
              this._dataStoreService.setData('addNarrative', true);
            }
            else{
              this._dataStoreService.setData('addNarrative', false);
            }
        },
        error => {
            return false;
        }
    );
  }
  addUpdateNarrative() {
    // hard coded progressnotetypeid to 'note' type and entitytype to 'IVE'
      this.progressNote.progressnotetypeid = 'a1f78e9f-ea8d-4f0b-8df5-7d4c0eda21cc';
      this.progressNote.entitytypeid = this.clientId;
      this.progressNote.entitytype = 'IVEADOP';
      this._commonHttpService
          .create(
              this.progressNote,
              Titile4eUrlConfig.EndPoint.addUpdateNarrative
          )
          .subscribe(
              (response: any) => {
                  if (response) {
                    this._alertService.success('Narrative saved successfully.');
                    this.getNarrative(this.clientId);
                  }
              },
              error => {
                  this._alertService.error('Unable to save narrative.');
                  this.getNarrative(this.clientId);
                  return false;
              }
          );
  }

}
