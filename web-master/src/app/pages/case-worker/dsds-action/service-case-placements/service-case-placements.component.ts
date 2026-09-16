import { Component, OnInit } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { ServiceCasePlacementsService } from './service-case-placements.service';
import { AuthService } from '../../../../@core/services/auth.service';

@Component({
    selector: 'service-case-placements',
    templateUrl: './service-case-placements.component.html',
    standalone: false
})
export class ServiceCasePlacementsComponent implements OnInit {

  moduleview: any;

  constructor(private route: ActivatedRoute,
    public _authService: AuthService,
    private _service: ServiceCasePlacementsService,
    private router: Router) {

    this.route.data.subscribe(res => {
      if (res && res.config) {
        _authService.setAuthDetail('placement',res.config.authdetails);
      }
    });
  }

  ngOnInit() {
    this.moduleview = this._authService.isModuleAccessable('placement', 'placement');
  }

  openLivingArrangementOrReferral() {
    this.router.navigate(['wrapper']);
  }

}
