import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { DataStoreService, AuthService } from '../../../@core/services';
import { AppConstants } from '../../../@core/common/constants';

@Component({
    selector: 'involved-persons',
    templateUrl: './involved-persons.component.html',
    styleUrls: ['./involved-persons.component.scss'],
    standalone: false
})
export class InvolvedPersonsComponent implements OnInit {
  moduleview: any;

  constructor(private activatedRoute: ActivatedRoute, private _dataStoreService: DataStoreService, private auth: AuthService) {
    this.activatedRoute.data.subscribe(data => {
      if (data && data.hasOwnProperty('result')) {
        auth.setAuthDetail('person',data.result);
      }
      if (data && data.hasOwnProperty('source')) {
        this._dataStoreService.setData(AppConstants.GLOBAL_KEY.SOURCE_PAGE, data.source);
      } else {
        alert('Please Configure source for persons in routing'); // configre data in respective feautre routing module
      }
    });
  }
  
  ngOnInit() {   
    this.moduleview = this.auth.isModuleAccessable('person', 'person');
  }



}
