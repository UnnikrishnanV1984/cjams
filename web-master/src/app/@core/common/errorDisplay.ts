
import {throwError as observableThrowError,  Observable } from 'rxjs';


import { Component, Input } from '@angular/core';


/**
 *   A Bootstrap based alert display
 */
@Component({
    // moduleId: module.id,
    // tslint:disable-next-line:component-selector
    selector: 'error-display',
    // templateUrl: 'errorDisplay.html'
    template: `
        <div *ngIf="error.message"
             class="alert alert-{{error.icon}} alert-dismissable">
            <button *ngIf="error.dismissable" type="button" class="btn-close"
                    data-bs-dismiss="alert" aria-hidden="true">
                <i class="fa fa-remove"></i>
            </button>

            <div *ngIf="error.header" style="font-size: 1.5em; font-weight: bold">
                <i class="fa fa-{{error.imageIcon}}" style="color: {{error.iconColor}}"></i>
                {{error.header}}
            </div>
            <i *ngIf="!error.header"
               class="fa fa-{{error.imageIcon}}"
               style="color: {{error.iconColor}}"></i>

            <strong>{{error.message}}</strong>
        </div>
    `,
    standalone: false
})

// tslint:disable-next-line:component-class-suffix
export class ErrorDisplay {
    /**
     * Error object that is bound to the component.
     * @type {ErrorInfo}
     */
    @Input() error: ErrorInfo = new ErrorInfo();
}

export class ErrorInfo {
    constructor() {
        this.reset();
    }

    message!: string;
    icon!: string;
    dismissable!: boolean;
    header!: string;
    imageIcon!: string;
    iconColor!: string;

    response: Response | null = null;

    reset() {
        this.message = '';
        this.header = '';
        this.dismissable = false;
        this.icon = 'warning';
        this.imageIcon = 'warning';
        this.iconColor = 'inherit';
    }

    /**
     * Low level method to set message properties
     * @param msg - the message to set to
     * @param icon? - sets the icon property (warning*)
     * @param iconColor? - sets the icon color (left as is)
     */
    show(msg: string, icon?: string, iconColor?: string) {
        this.message = msg;
        this.icon = icon ? icon : 'warning';
        if (iconColor) {
            this.iconColor = iconColor;
        }

        this.fixupIcons();

    }

    /**
     * Displays an error alert
     * @param msg  - Either a message string or error object with .message property
     */
    error(msg: any) {
        if (typeof (msg) === 'object' && msg.message) {
            this.message = msg.message;
        } else {
            this.message = msg;
        }

        this.show(this.message, 'warning');
    }

    /**
     * DIsplays an info style alert
     * @param msg - message to display
     */
    info(msg: string) {
        this.show(msg, 'info');
    }

    /**
     * Fixes up icons and colors based on standard icon settings
     * this method is called in internally after any of the helper
     * methods are called. You can call this when setting any icon
     * related properties manually.
     */
    fixupIcons() {
        const err = this;

        if (err.icon === 'info') {
            err.imageIcon = 'info-circle';
        }
        if (err.icon === 'error' || err.icon === 'danger' || err.icon === 'warning') {
            err.imageIcon = 'warning';
            err.iconColor = 'firebrick';
        }
        if (err.icon === 'success') {
            err.imageIcon = 'check';
            err.iconColor = 'green';
        }
    }

    /**
     * Parse a toPromise() .catch() clause error
     * from a response object and returns an errorInfo object
     * @param response
     * @returns {Promise<void>|Promise<T>}
     */
    parsePromiseResponseError(response: any) {

        if (response && response.hasOwnProperty('message')) {
            return Promise.reject(response);
        }
        if (response && response.hasOwnProperty('Message')) {
            response.message = response.Message;
            return Promise.reject(response);
        }

        const err: any = new ErrorInfo();
        err.response = response;
        err.message = response?.statusText;

        try {
            const data: any = response?.json();
            if (data && data.message) {
                err.message = data.message;
            }
        } catch (ex) {

        }

        return Promise.reject(err);
    }

    parseObservableResponseError(response: any): Observable<any> {
        let err: any = new ErrorInfo();

        // HttpClient has an `error` property for raw JSON response
        if (response.hasOwnProperty('error')) {

            try {
                err = JSON.parse(response.error);
            } catch (ex) { }

            if (err.hasOwnProperty('message')) {
                return observableThrowError(err);
            }
            if (err.hasOwnProperty('Message')) {
                err.message = err['Message'];
                return observableThrowError(err);
            }
        }
        if (response.hasOwnProperty('message')) {
            return observableThrowError(response);
        }
        if (response.hasOwnProperty('Message')) {
            response.message = response.Message;
            return observableThrowError(response);
        }

        err.response = response;
        err.message = response.statusText;

        try {
            const data = response.json();
            if (data && data.message) {
                err.message = data.message;
            }
        } catch (ex) {
        }

        if (!err.message) {
            err.message = 'Unknown server failure.';
        }

        return observableThrowError(err);
    }
}
