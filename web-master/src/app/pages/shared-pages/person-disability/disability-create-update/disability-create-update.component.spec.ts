import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { DisabilityCreateUpdateComponent } from './disability-create-update.component';

describe('DisabilityCreateUpdateComponent', () => {
  let component: DisabilityCreateUpdateComponent;
  let fixture: ComponentFixture<DisabilityCreateUpdateComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ DisabilityCreateUpdateComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(DisabilityCreateUpdateComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
