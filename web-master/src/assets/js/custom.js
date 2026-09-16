$(document).ready(function () {
    $('body').on('click', ".toggle-word", function () {
        $(this).parent().find('.textarea-form, .form-search-person').slideToggle(300);
        $(this).find('span .fa').toggleClass('fa-minus').toggleClass('fa-plus');
    });
});
function toggleIcon(e) {
    $(e.target)
        .prev('.card-header')
        .find(".more-less")
        .toggleClass('glyphicon-plus glyphicon-minus');
}
$('.card-group').on('hidden.bs.collapse', toggleIcon);
$('.card-group').on('shown.bs.collapse', toggleIcon);