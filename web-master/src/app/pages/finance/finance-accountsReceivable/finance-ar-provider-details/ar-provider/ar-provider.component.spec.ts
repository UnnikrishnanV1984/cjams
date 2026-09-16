import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ArProviderComponent } from './ar-provider.component';

describe('ArProviderComponent', () => {
  let component: ArProviderComponent;
  let fixture: ComponentFixture<ArProviderComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ArProviderComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ArProviderComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
