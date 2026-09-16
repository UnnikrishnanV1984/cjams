import { ActivatedRouteSnapshot, CanDeactivate, RouterStateSnapshot, UrlTree } from '@angular/router';
import { Observable } from 'rxjs';
import { LegalCustodyComponent } from './legal-custody.component';

type CanDeactivateResult = boolean | UrlTree | Observable<boolean | UrlTree> | Promise<boolean | UrlTree>;

export class DeactivateGuard implements CanDeactivate<LegalCustodyComponent> {
    canDeactivate(component: LegalCustodyComponent, 
        currentRoute: ActivatedRouteSnapshot, 
        currentState: RouterStateSnapshot,
         nextState?: RouterStateSnapshot):  CanDeactivateResult {

        if (component.noRecordExists && component.openRecordExists) {
            return true;
        }

        // Open custom popup
        component.checkPageNavigation();
        return false;
    }

}
