// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
filterSelection("all")
function filterSelection(c) {
  var x, i;
  x = document.getElementsByClassName("filterDiv");
  if (c == "all") c = "";
  // Add the "show" class (display:block) to the filtered elements, and remove the "show" class from the elements that are not selected
  for (i = 0; i < x.length; i++) {
    w3RemoveClass(x[i], "show");
    if (x[i].className.indexOf(c) > -1) w3AddClass(x[i], "show");
  }
}

// Show filtered elements
function w3AddClass(element, name) {
  var i, arr1, arr2;
  arr1 = element.className.split(" ");
  arr2 = name.split(" ");
  for (i = 0; i < arr2.length; i++) {
    if (arr1.indexOf(arr2[i]) == -1) {
      element.className += " " + arr2[i];
    }
  }
}

// Hide elements that are not selected
function w3RemoveClass(element, name) {
  var i, arr1, arr2;
  arr1 = element.className.split(" ");
  arr2 = name.split(" ");
  for (i = 0; i < arr2.length; i++) {
    while (arr1.indexOf(arr2[i]) > -1) {
      arr1.splice(arr1.indexOf(arr2[i]), 1);
    }
  }
  element.className = arr1.join(" ");
}

// Add active class to the current control button (highlight it)
var btnContainer = document.getElementById("myBtnContainer");
var btns = btnContainer.getElementsByClassName("btn");
for (var i = 0; i < btns.length; i++) {
  btns[i].addEventListener("click", function() {
    var current = document.getElementsByClassName("active");
    current[0].className = current[0].className.replace(" active", "");
    this.className += " active";
  });
}

// product show page
$(document).ready(function(){
         //-- Click on detail
         $("ul.menu-items > li").on("click",function(){
             $("ul.menu-items > li").removeClass("active");
             $(this).addClass("active");
         })

         $(".attr,.attr2").on("click",function(){
             var clase = $(this).attr("class");

             $("." + clase).removeClass("active");
             $(this).addClass("active");
         })

         //-- Click on QUANTITY
         $(".btn-minus").on("click",function(){
             var now = $(".section > div > input").val();
             if ($.isNumeric(now)){
                 if (parseInt(now) -1 > 0){ now--;}
                 $(".section > div > input").val(now);
             }else{
                 $(".section > div > input").val("1");
             }
         })
         $(".btn-plus").on("click",function(){
             var now = $(".section > div > input").val();
             if ($.isNumeric(now)){
                 $(".section > div > input").val(parseInt(now)+1);
             }else{
                 $(".section > div > input").val("1");
             }
         })
     })
