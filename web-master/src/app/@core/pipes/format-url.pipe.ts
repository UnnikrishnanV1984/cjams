import { Pipe, PipeTransform } from '@angular/core';
import { environment } from '../../../environments/environment';
@Pipe({
    name: 'formatUrl',
    standalone: false
})
export class FormatUrlPipe implements PipeTransform {
    environment = environment;
    transform(url: string) {
        if (!url) {
            return url;
          }
        try {
            new URL(url);
            return this.removeDuplicateApiString(url);
          } catch (err) {
            return this.removeDuplicateApiString(environment.apiHost + url);
          }
    }
    removeDuplicateApiString(url: string) {
        const splitUrl = url.split('/attachments');
        if (splitUrl.length < 2) {
            return url;
        }
        return environment.apiHost + '/attachments' + splitUrl[1];
    }
}
