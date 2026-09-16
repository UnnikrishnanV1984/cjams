import { Component, OnInit } from '@angular/core';
import { Router } from '@angular/router';

@Component({
    // tslint:disable-next-line: component-selector
    selector: 'provider-payment-management',
    templateUrl: './provider-payment-management.component.html',
    styleUrls: ['./provider-payment-management.component.scss'],
    standalone: false
})
export class ProviderPaymentMgmtComponent implements OnInit {
  tabs:any[] = [];
  selectedurl?: string;
  selectedPageName?: string;

  constructor( 
    private _router: Router,
  ) { 
      
  }

  ngOnInit() {
    this.tabs = [
        {
          active: false,
          path: 'cfe-payment',
          name: 'Provider Ancillary Payments',
          enable: true
      }
    ];
  }

  tabChanged(url:any) {
      this.selectedurl = url;
      const selectedTab = this.tabs.find(item => item.path === this.selectedurl);
      if (selectedTab) {
        this.selectedPageName = selectedTab.name;
      }
      this._router.navigate(['pages/provider-payment-management/' + this.selectedurl]);
  }
  
}
