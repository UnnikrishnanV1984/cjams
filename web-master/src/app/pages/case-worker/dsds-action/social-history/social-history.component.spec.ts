import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { SocialHistoryComponent } from './social-history.component';

describe('SocialHistoryComponent', () => {
  let component: SocialHistoryComponent;
  let fixture: ComponentFixture<SocialHistoryComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ SocialHistoryComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(SocialHistoryComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
