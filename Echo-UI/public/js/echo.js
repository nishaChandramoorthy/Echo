$(function(){
 
  $("#bookshelf-heading").live("click", function(){
    $.ajax({
      url: "/bookshelf",
      success: function(data){
        $("#main-content").html(data);
        var height = $("#main-content").height();
      }
    });
  });

  $('#sidebar>li>a').click(function(){
	 $('#main-content').load("/view/"+this.getAttribute('data-url'));
	 return false;//Stops page from scrolling to top
  });
  
  
  $('.search-extra-info').live('click', function(){
    $("#search-detail").toggle('slow', function(){
      
    });
  });

});

