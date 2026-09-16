/* tslint:disable:no-unused-variable */
import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';
import { YtpSupportiveRelationshipsComponent } from './ytp-supportive-relationships.component';

describe('YtpSupportiveRelationshipsComponent', () => {
  let component: YtpSupportiveRelationshipsComponent;
  let fixture: ComponentFixture<YtpSupportiveRelationshipsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ YtpSupportiveRelationshipsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(YtpSupportiveRelationshipsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
