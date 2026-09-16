import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ApplaProcessComponent } from './appla-process.component';

describe('ApplaProcessComponent', () => {
  let component: ApplaProcessComponent;
  let fixture: ComponentFixture<ApplaProcessComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ApplaProcessComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ApplaProcessComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
