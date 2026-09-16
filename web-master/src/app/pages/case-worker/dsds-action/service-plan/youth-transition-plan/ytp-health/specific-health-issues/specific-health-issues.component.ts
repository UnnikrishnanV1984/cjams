import { Component, OnInit, Input } from '@angular/core';
import { DataStoreService } from '../../../../../../../@core/services';

@Component({
    selector: 'specific-health-issues',
    templateUrl: './specific-health-issues.component.html',
    styleUrls: ['./specific-health-issues.component.scss'],
    standalone: false
})
export class SpecificHealthIssuesComponent implements OnInit {

  ytpData: any;

  @Input() healthIssuesList!: any;
  constructor(
    private _dataStoreService: DataStoreService
  ) { }

  ngOnInit() {
    this.ytpData = this._dataStoreService.getData('YTPDATA');
  }

  addHealthIssues() {
    this.healthIssuesList.push({
      health_issues: '',
      concern: '',
      date_last_exam: null,
      doctor_info: ''
    });
  }

  deleteHealthIssues(index: any) {
    this.healthIssuesList.splice(index, 1);
  }

}
