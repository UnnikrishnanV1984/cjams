import { Component, OnInit, OnDestroy } from '@angular/core';
import { CommonHttpService, DataStoreService, AlertService } from '../../../../@core/services';
import { NewUrlConfig } from '../../../newintake/newintake-url.config';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';
import { Subscription } from 'rxjs';

@Component({
    selector: 'folder-change',
    templateUrl: './folder-change.component.html',
    standalone: false
})
export class FolderChangeComponent implements OnInit, OnDestroy {
  folders: any;
  currentFolder!: string;
  selectedFolder!: string | null;
  caseID!: string;
  datastoreSubscription!: Subscription;

  constructor(
    private _commonService: CommonHttpService,
    private _dataStoreService: DataStoreService,
    private _alertService: AlertService
  ) { }

  ngOnInit() {
    this.datastoreSubscription = this._dataStoreService.currentStore.subscribe(storeObj => {
      if (storeObj[CASE_STORE_CONSTANTS.FOLDER_CHANGE_INITIATED]) {
        this._dataStoreService.setData(CASE_STORE_CONSTANTS.FOLDER_CHANGE_INITIATED, false);
        this.loadFolderType();
        this.selectedFolder = null;
      }
    });
    this.caseID = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
  }

  ngOnDestroy(): void {
    if (this.datastoreSubscription) {
      this.datastoreSubscription.unsubscribe();
    }
  }

  loadFolderType() {
    this._commonService
      .getArrayList(
        {}, NewUrlConfig.EndPoint.Intake.folderTypeList
      )
      .subscribe(result => {
        const currentFolder = this._dataStoreService.getData('da_foldertypedecription');
        this.folders = result.filter(folder => folder.description !== currentFolder);
      });
  }

  changeFolder() {
    this._commonService.patch(this.caseID, {
      foldertypekey: this.selectedFolder
    }, 'Intakeservicerequests/updatefolderchange')
      .subscribe(res => {
        this._alertService.success('Folder Changed Successfully');
        this._dataStoreService.setData(CASE_STORE_CONSTANTS.FOLDER_CHANGED, true);
        (<any>$('#folder-change')).modal('hide');
      }, err => {
        this._alertService.error('Failed to change folder');
        (<any>$('#folder-change')).modal('hide');
      });
  }

}
