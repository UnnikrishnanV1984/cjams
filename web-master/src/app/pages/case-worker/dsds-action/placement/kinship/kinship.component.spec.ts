import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { KinshipComponent } from './kinship.component';

describe('KinshipComponent', () => {
  let component: KinshipComponent;
  let fixture: ComponentFixture<KinshipComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ KinshipComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(KinshipComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
