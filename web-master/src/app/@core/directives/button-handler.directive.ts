import { Directive, ElementRef, HostListener } from '@angular/core';

@Directive({
    selector: '[click]',
    standalone: false
})
export class ButtonHandlerDirective {

  btnDisabled : any[] = [];

  constructor(private el: ElementRef) {}

  @HostListener('click', ['$event'])
  handleEvent($event: any){
      if(!this.el.nativeElement.classList.contains('btn-pri')) {return;}
      if (this.el?.nativeElement?.contains($event.target)) {
        if(this.btnDisabled.includes($event.target)) {
          alert('Please wait...operation to complete');
          $event.preventDefault();
        } else {
          this.btnDisabled.push($event.target);
          const pauseAction = setInterval((arr, item) => {
             arr.splice(item,1);
             clearInterval(pauseAction);
          }, 3000, this.btnDisabled, $event.target);
        }
      }
  }

}
