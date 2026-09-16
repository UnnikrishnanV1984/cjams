import { Component, OnInit } from '@angular/core';
import { AuthService } from '../../../../@core/services/auth.service';
import { ActivatedRoute } from '@angular/router';
import { InHomeServiceResolverService } from './in-home-service-resolver-service';

@Component({
    selector: 'in-home-service',
    templateUrl: './in-home-service.component.html',
    styleUrls: ['./in-home-service.component.scss'],
    standalone: false
})
export class InHomeServiceComponent implements OnInit {

  moduleview: any;
  constructor(
    private route: ActivatedRoute,
    public _authService: AuthService,
    private inHomeServiceResolverService: InHomeServiceResolverService
  ) {
  //   this.route.data.subscribe(data => {
  //     if (data && data.hasOwnProperty('result')) {
  //       _authService.setAuthDetail('serviceagreement',data.result);
  //     }
  // });
   }

  ngOnInit() {
    this.inHomeServiceResolverService.getServiceagreement().subscribe({
        next: (data: any) => {
            this._authService.setAuthDetail('serviceagreement',data);
        }
    })
    this.moduleview = this._authService.isModuleAccessable('serviceagreement', 'serviceagreement');
  }

}
