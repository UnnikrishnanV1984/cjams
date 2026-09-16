import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ApChicklistComponent } from './ap-chicklist.component';

describe('ApChicklistComponent', () => {
  let component: ApChicklistComponent;
  let fixture: ComponentFixture<ApChicklistComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ApChicklistComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ApChicklistComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
