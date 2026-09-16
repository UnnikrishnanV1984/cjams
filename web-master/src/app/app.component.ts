import { HttpClient } from '@angular/common/http';
import { Component, OnInit, ViewChild, ElementRef, NgZone, ChangeDetectorRef, OnDestroy, AfterViewInit, Injector, HostListener } from '@angular/core';
import { ActivatedRoute, Router, RouterOutlet } from '@angular/router';
import { environment } from '../environments/environment';
import { AppUser, UserInfo } from './@core/entities/authDataModel';
import { AuthService, AlertService } from './@core/services';
import { CommonHttpService } from './@core/services/common-http.service';
import { SessionStorageService } from './@core/services/storage.service';
import { ContactlogComponent } from './contactlog/contactlog.component';
import { fromEvent, Subscription, Observable, Subject } from 'rxjs';
import { Idle, EventTargetInterruptSource } from '@ng-idle/core';
import { Keepalive } from '@ng-idle/keepalive';
import { GlobalPatchService } from './@core/services/global-patch.service';
import { UploadSharedService } from './@core/services/upload-shared.service';
import { CaseWorkerUrlConfig } from './pages/case-worker/case-worker-url.config';
import { config } from '../environments/config';
import { GLOBAL_MESSAGES } from './@core/entities/constants';
import { UploadProgressWidgetModule } from './shared/shared-components/upload-progress-widget/upload-progress-widget.module';
import { CommonModule } from '@angular/common';

declare var $: any;


@Component({
    // tslint:disable-next-line:component-selector
    selector: 'app-root',
    templateUrl: './app.component.html',
    styleUrls: ['./app.component.scss'],
    imports:[RouterOutlet,UploadProgressWidgetModule,ContactlogComponent,CommonModule],
    standalone: true
})
export class AppComponent implements OnInit, AfterViewInit, OnDestroy {
    title = 'Session Timeout Demo';
    idleState = 'NOT_STARTED';
    timedOut = false;
    lastPing?: Date | null = null;
    _idleTimerSubscription: Subscription = new Subscription();
    private watch!: Observable<any>;
    subscription: Subscription = new Subscription();
    private timer!: Observable<any>;
    public timeoutExpired: Subject<number> = new Subject<number>();
    isSessionNeedsTobeInLife = false;
    formBuilderPassword :  any;
    dynamsoftProductKey:any;
    offlineEvent!: Observable<Event>;
    onlineEvent!: Observable<Event>;
    subscriptions: Subscription[] = [];
    private timerStart: any;
    sessionmodalid = '#session-time-out';

    @ViewChild(ContactlogComponent) contactLogComponent: any;

    private router: Router;
    private route: ActivatedRoute;
    private _storage: SessionStorageService;
    public _authService: AuthService;
    private _http: HttpClient;
    public _service: CommonHttpService;
    private element: ElementRef;
    private idle: Idle;
    private keepalive: Keepalive;
    private zone: NgZone;
    private globalPatch: GlobalPatchService;
    private shareduploadService: UploadSharedService;
    pendingDocs: any = [];

    constructor(private readonly injector : Injector, private _alert: AlertService, private cdRef: ChangeDetectorRef) {
        this.router = this.injector.get<Router>(Router);
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this._storage = this.injector.get<SessionStorageService>(SessionStorageService);
        this._authService = this.injector.get<AuthService>(AuthService);
        this._http = this.injector.get<HttpClient>(HttpClient);
        this._service = this.injector.get<CommonHttpService>(CommonHttpService);
        this.element = this.injector.get<ElementRef>(ElementRef);
        this.idle = this.injector.get<Idle>(Idle);
        this.keepalive = this.injector.get<Keepalive>(Keepalive);
        this.zone = this.injector.get<NgZone>(NgZone);
        this.globalPatch = this.injector.get<GlobalPatchService>(GlobalPatchService);
        
        this.shareduploadService = this.injector.get<UploadSharedService>(UploadSharedService);

        this.zone.runOutsideAngular(() => {
            // sets an idle timeout of 10 minutes.
            this.idle.setIdle(environment.IdleTimeOut);
            // sets a timeout period of 5 minutes.
            this.idle.setTimeout(environment.PopupTimeOut);
            // sets the interrupts like Keydown, scroll, mouse wheel, mouse down, and etc
            this.idle.setInterrupts([
                new EventTargetInterruptSource(
                    this.element.nativeElement, 'keydown DOMMouseScroll mousewheel mousedown scroll')]);


            this.idle.onTimeout.subscribe(() => {
                this.idleState = 'TIMED_OUT';
                this.timedOut = true;
                this.idle.stop();
                this._authService.performTimeout();
            });

            this.idle.onIdleStart.subscribe(() => {
                const user: any = this._authService.getCurrentUser();
                if (user?.id && this._authService.isLoggedIn()) {
                    this.timerStart = Date.now();
                    $(this.sessionmodalid).modal('show');
                } else {
                    this.idle.stop();
                }
            });

            this.idle.onTimeoutWarning.subscribe((countdown: any) => {
                const remainingSecs = Math.floor(this.idle.getTimeout() - (Math.abs(Date.now() - this.timerStart)/1000));
                if (remainingSecs <= 0) {
                    this.idle.stop();
                    this._authService.performTimeout();
                } else {
                    const sec = remainingSecs % 60 < 10 ? '0' + remainingSecs % 60 : remainingSecs % 60;
                    const timeData = document.getElementById('time');
                    if(timeData) {
                        timeData.innerHTML = Math.floor(remainingSecs / 60).toString()  + ':' + sec;
                    }
                }
            });

            // sets the ping interval to 15 seconds
            this.keepalive.interval(15);

            this.keepalive.onPing.subscribe(() => {
                this.lastPing = new Date();
            });
            this.reset();
        });

        this._authService.checkIfReloaded();
        
        //registering an hearbeat for timeouts
        //https://dev2.cw.cjams.mdthink.maryland.gov/assets/images/logo_home.png
        setInterval(() => {
            this._authService.callAPIToResetCokiesBackFromOpenAm();
        }, 300000);
    }

    checkIfSessionExist(isCheck: any) {
        if (isCheck ) {
            $(this.sessionmodalid).modal('hide');
            this.continueSession();
        } else {
            if (this.router.url !== '/login') {
            $(this.sessionmodalid).modal('show');
            }
        }
    }

    reset() {
        this.idle.watch();
        this.idleState = 'Started.';
        this.timedOut = false;
    }

    continueSession() {
        $(this.sessionmodalid).modal('hide');
        this._authService.callAPIToResetCokiesBackFromOpenAm();
        this.reset();
        const timeData = document.getElementById('time');
        if(timeData) {
            timeData.innerHTML = '';
        }
    }
    logOutSession() {
        this.idle.stop();
        $(this.sessionmodalid).modal('hide');
        this._authService.logout();
    }

    async  ngOnInit() {
        this.handleAppConnectivityChanges();
        if (this.router.url !== '/login') {
            this.subscription = fromEvent(document, 'keypress').subscribe(e => {
                // Setting extension needs to be called
                this.isSessionNeedsTobeInLife = true;
            });
            // Setting time out
            setInterval(() => {
                if (this.isSessionNeedsTobeInLife) {
                    // Call session extended
                    this.continueSession();
                    // Make isSessionNeedsTobeInLife
                    this.isSessionNeedsTobeInLife = false;
                }
            }, environment.PopupTimeOut * 1000);
        }

        if (window.location.host.indexOf('4200') < 0) {
            console.log = function () {
                // No content to add or call // NOSONAR
            };
        }
        const fbToken = this._storage.getObj('fbToken');
        if (!fbToken) {
            const templateUrl = environment.formBuilderHost + `/user/login`;
            this._http
                .post(
                    templateUrl,
                    {
                        // data: {
                        //     email: environment.formBuilderUserId,
                        //     password: decodeURIComponent(atob(this._storage.getItem('formBuilderPassword')))  ? decodeURIComponent(atob(this._storage.getItem('formBuilderPassword'))):null
                        // }
                    },
                    { observe: 'response' }
                )
                .subscribe((res: any) => {
                    this._storage.setObj('fbToken', res.headers.get('x-jwt-token'));
                });
        }
        this._authService.populate();
        if (localStorage.getItem('showReloadWarning') === 'true' && localStorage.getItem('showPendingDocumentsAlert') === 'true') {
            this._alert.warn("The page was reloaded. Any pending document upload has been cancelled after the page reload.");
            $('#reload-failed-alert').modal('show');
            // Clear the flag so the message isn't shown on subsequent navigations
            localStorage.removeItem('showReloadWarning');
            localStorage.removeItem('showPendingDocumentsAlert');
        }
        // const secret: any = await this.getWebAwsSecretsManager().toPromise();
        // if(secret){
        //     this.dynamsoftProductKey= secret['dynamsoftProductKey'];
        //     this._storage.setItem("dynamsoftProductKey",btoa(encodeURIComponent ( this.dynamsoftProductKey)));
        // }
    }

    // Fires on refresh/close/tab close
    @HostListener('window:beforeunload', ['$event'])
    WindowBeforeUnload(e: any) { //onBeforeUnload beforeUnloadHandler BeforeUnloadEvent
        const uploadprogress = this.shareduploadService.getUploadFileProgress();
        if(uploadprogress && uploadprogress.length > 0) {
            this.pendingDocs = uploadprogress.filter((up: any) => up.progress > 0 && !up.uploadComplete);
        }    
        if(this.pendingDocs && this.pendingDocs.length > 0 ) {
            this.continueLogout();   
        }  
    }

   continueLogout() {
        if(this.pendingDocs && this.pendingDocs.length > 0 ){
            localStorage.setItem('showPendingDocumentsAlert', 'true');
            this.pendingDocs.forEach((doc: any) => {
                const url = CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.UploadStatusUpdateAttachmentUrl + '/' + doc.ecmsdocumentid;
                this.commonCreateFn(url);
            })            
        }
    }

    ngAfterViewInit() {
        $(document).ready(function () {
            $("body").tooltip({
                selector: '[data-bs-toggle=tooltip]',
                trigger: 'hover'
            });
        });
    }

    getWebAwsSecretsManager() {
        this._service.endpointUrl = 'awsapiKeys/getWebAwsSecretsManager';
         return this._service.getAll()
    }

    refreshPage() {
        window.location.reload();
    }

    contactSupport() {
        this.contactLogComponent.launchContactlog();
    }

    ngAfterContentChecked() {
        this.cdRef.detectChanges();
    }

    private handleAppConnectivityChanges(): void {
        this.onlineEvent = fromEvent(window, 'online');
        this.offlineEvent = fromEvent(window, 'offline');

        this.subscriptions.push(this.onlineEvent.subscribe(e => {
          // handle online mode
          console.log('Online...');
          this._alert.clear();
          this._alert.success('Connected to CJAMS, your device reconnected to the internet. You are online now!');
          setTimeout(() => {
            this.retryupdatedocumentstatus();
          }, 10000);
        }));

        this.subscriptions.push(this.offlineEvent.subscribe(e => {
          // handle offline mode
          console.log('Offline...');
          this._alert.error("Unable to connect to CJAMS because your device isn't connected to the internet", true);
        }));
    }

    ngOnDestroy(): void {
        this.subscriptions.forEach(subscription => subscription.unsubscribe());
    }

    closeReleasePopup(){
        $('#release-popup').modal('hide');
    }

    goToReleaseNotes(){
        $('#release-popup').modal('hide');
        this.router.navigate(['/pages/release-notes'], { queryParams: { fromScreen: 'login' } });
    }

    retrythefile(file:any) {
        $('#upload-failed-alert').modal('hide');
        this.shareduploadService.routetodocumentsupload(file);
    }
    removewidgetnotification(file: any) {
        const uploadprogress = this.shareduploadService.getUploadFileProgress(); 
        if(uploadprogress && uploadprogress.length > 0) {
            const uprogress = uploadprogress.filter((up: any) => up.ecmsdocumentid != file.ecmsdocumentid);
            this.shareduploadService.setUploadFileProgress(uprogress);
            if(uprogress && uprogress.length === 0) {
                $('#upload-failed-alert').modal('hide');  
            }          
        }       
    }
    retryupdatedocumentstatus() {         
       const uprogress = this._storage.getObj('uploadstatusretryfiles');
        if(uprogress && uprogress.length > 0) {            
            uprogress.forEach((uprogg: any) => {                 
                const url = CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.UploadStatusUpdateAttachmentUrl + '/' + uprogg.ecmsdocumentid;
                this.commonCreateFn(url);
            });       
            this._storage.setObj('uploadstatusretryfiles',null);     
        }
    }
    private commonCreateFn(url: string) {
        this._service.create({}, url).subscribe((response) => {
            if (response) {
                console.log('Data updated');
            }
        });
    }

    deletetheretryfile(file: any) {
        const workEnv = config.workEnvironment;
        this._service.endpointUrl = CaseWorkerUrlConfig.EndPoint.DSDSAction.Attachment.DeleteAttachmentUrl;
        let id : any;
        if (workEnv === 'state') {
            id = file.documentpropertiesid + '&' + file.ecmsdocumentid;
        } else {
            id = file.documentpropertiesid;
        }
        this._service.remove(id).subscribe(
            _result3 => {
                this.removewidgetnotification(file);
                this._authService.getuserfailedfileupload();
                this._alert.success('Attachment Deleted successfully!');
            },
            _err => {
                this._alert.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
        });
    }

    closeupload() {
        $('#upload-failed-alert').modal('hide');
    }

    closereload() {
        $('#reload-failed-alert').modal('hide');
    }

}