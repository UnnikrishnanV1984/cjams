import { ComponentFixture, TestBed } from '@angular/core/testing';

import { YtpHelpPopoverComponent } from './ytp-help-popover.component';

describe('YtpHelpPopoverComponent', () => {
  let component: YtpHelpPopoverComponent;
  let fixture: ComponentFixture<YtpHelpPopoverComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ YtpHelpPopoverComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(YtpHelpPopoverComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
