import { Component, OnInit, Inject } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog'
import { CommonHttpService } from '../../../@core/services/common-http.service';
import { Subject } from 'rxjs';
import { Titile4eUrlConfig } from '../_entities/title4e-dashboard-url-config';
import { Title4eService } from '../services/title4e.service';
import { Router } from '@angular/router';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'period-table-pop-up',
    templateUrl: './period-table-pop-up.component.html',
    styleUrls: ['./period-table-pop-up.component.scss'],
    standalone: false
})
export class PeriodTablePopUpComponent implements OnInit {
  selectedPeriodData = new Subject<any>();
  onClose = new Subject<boolean>();
  ClientId: any;
  periodTable: any[]=[];
  selectedPeriodsRE: any[]=[];
  selectedPeriodsIN!: {};
  constructor(public dialogRef: MatDialogRef<PeriodTablePopUpComponent>,
    @Inject(MAT_DIALOG_DATA) public data: any,
    private router: Router,
    private commonHttpService: CommonHttpService,
    private title4eService: Title4eService
  ) { }

  ngOnInit() {
    this.ClientId = this.router.routerState.snapshot.url.split('/')[4];

    this.getData();
  }
  onSubmit() {
    this.selectedPeriodData.next(this.periodTable.filter(v => v.isSelected));
    this.onClose.next(true);
    this.dialogRef.close();
  }
  onTimes() {
    this.onClose.next(false);
    this.dialogRef.close();
  }
  onSelectItem(event:any, item:any) {
    item.isSelected = event.target.checked;
  }
  getData() {
     const removalId = this.title4eService.removalIdData;
    this.commonHttpService.getAll(Titile4eUrlConfig.EndPoint.getPeriods + '/' + this.ClientId + '/' + removalId).subscribe(
      (response: any) => {
        response.data.forEach((v:any) => {
          v.isSelected = false;
        });
        this.periodTable = response.data;
      },
      (error) => {
        return false;
      }
    );
  }
}

