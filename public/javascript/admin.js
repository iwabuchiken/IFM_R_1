// REF http://stackoverflow.com/questions/2672355/calling-jquery-method-from-onclick-attribute-in-html answered Apr 20 '10 at 3:40
function showMessage(msg) {
   alert(msg + " => Shown");
   // alert(msg);
};

// $('#show_button').click(function({

// $(function(){
// 
	// $("#show_button").click(function({
// 		
		// alert("msg");
		// // $(this).css("background-color", "blue")
	// }));
// 	
// });
// 
$(document).ready(function(){
  $("p").click(function(){
    // $(this).hide();
    
    // REF css() http://stackoverflow.com/questions/12197828/how-to-set-style-display-of-an-html-element answered Aug 30 '12 at 13:22
    // REF http://api.jquery.com/css/
    $(this).css("background-color", "blue");
  });
  
  $("#show_button").click(function(){
    // $(this).hide();
    // $(this).css("background-color", "blue");
    // alert($(this).text);
    
    // REF attr()	http://stackoverflow.com/questions/487056/retrieve-button-value-with-jquery answered Jan 28 '09 at 10:12
    // alert($(this).attr("value"));
    
    // REF $()[0] http://stackoverflow.com/questions/4069982/document-getelementbyid-vs-jquery edited Sep 28 '11 at 20:29
    // REF http://blog.mwsoft.jp/article/36582155.html
    // $("logs")[0].css("background-color", "blue");
    // $("logs").css("background-color", "blue");
    // $("#logs").css("background-color", "blue");
    $("#logs").show();
    
    // $(this).attr("value") = "Log shown";
    // $(this).attr("value", "Log shown");
    
    // REF disabled http://stackoverflow.com/questions/5580616/jquery-change-button-text
    $(this).attr("disabled", true);
    
    // REF disabled http://d.hatena.ne.jp/ogakky/20110711/1310349297
    $("#hide_button").removeAttr("disabled");
    
    
    // $("#logs").css("visibility", "visible");
  });
  
  $("#hide_button").click(function(){

    // alert($(this).attr("value"));

	// REF visibility http://www.htmq.com/style/visibility.shtml
    // $("#logs").css("visibility", "hide");
    $("#logs").hide();
    
    $(this).attr("disabled", true);
    $("#show_button").removeAttr("disabled");
    
  });
  
  
  
});