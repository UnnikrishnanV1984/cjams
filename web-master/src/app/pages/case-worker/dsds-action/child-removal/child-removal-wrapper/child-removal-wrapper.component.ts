import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { ChildRemovalService } from '../child-removal.service';
import { AuthService } from '../../../../../@core/services';

@Component({
    selector: 'child-removal-wrapper',
    templateUrl: './child-removal-wrapper.component.html',
    styleUrls: ['./child-removal-wrapper.component.scss'],
    standalone: false
})
export class ChildRemovalWrapperComponent implements OnInit {

  childRemovalShow = false;
  moduleview: any;
  constructor(private route: ActivatedRoute, private _service: ChildRemovalService, private _authService: AuthService) {
    this.route.data.subscribe(res => {
      if (res && res.config) {       
        this._service.loadDropDownList();
        _authService.setAuthDetail('childremoval',res.config.authdetails);
      }

    });
  }

  ngOnInit() {
    this.moduleview = this._authService.isModuleAccessable('childremoval', 'childremoval');
  }

}
