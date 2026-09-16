import { ActivatedRouteSnapshot, CanDeactivate, RouterStateSnapshot, UrlTree } from '@angular/router';
import { Observable } from 'rxjs';
import { NotesComponent } from './notes.component';

export class DeactivateGuard implements CanDeactivate<NotesComponent> {
    canDeactivate(component: NotesComponent, currentRoute: ActivatedRouteSnapshot, currentState: RouterStateSnapshot, nextState?: RouterStateSnapshot): boolean | UrlTree | Observable<boolean | UrlTree> | Promise<boolean | UrlTree> {

        if (!component.recordingForm.dirty || component.checkPageNavigationFlag) {
            return true;
        }

        // Open custom popup
        component.checkPageNavigation(nextState?.url);
        return false;
    }

}
