import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ApiRefferanceComponent } from './api-refferance.component';

describe('ApiRefferanceComponent', () => {
  let component: ApiRefferanceComponent;
  let fixture: ComponentFixture<ApiRefferanceComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ApiRefferanceComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ApiRefferanceComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
