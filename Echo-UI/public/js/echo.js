$(function(){

  $("#sb-activity").click(function(){
    $.ajax({
      url: "/activity",
      success: function(data){
        $("#main-content").html(data);
        var height = $("#main-content").height();
        //$("#container").css("height", height);
      }
    });
  });

  $("#sb-search").click(function(){
    $.ajax({
      url: "/search",
      success: function(data){
        $("#main-content").html(data);
        var height = $("#main-content").height();
        //$("#container").css("height", height);
      }
    });
  });

  $("#sb-suggestions").click(function(){
    $.ajax({
      url: "/suggestions",
      success: function(data){
        $("#main-content").html(data);
      }
    });

  });

  $("#sb-bookshelf").click(function(){
    $.ajax({
      url: "/bookshelves",
      success: function(data){
        $("#main-content").html(data);
      }
    });
  });

  $("#sb-readinglist").click(function(){
     $.ajax({
      url: "/reading-list",
      success: function(data){
        $("#main-content").html(data);
      }
    });
  });

  $("#sb-communities").click(function(){
    $.ajax({
      url: "/communities",
      success: function(data){
        $("#main-content").html(data);
      }
    });
  });

  $("#sb-friends").click(function(){
    $.ajax({
      url: "/friends",
      success: function(data){
        $("#main-content").html(data);
      }
    });
  });

  $("#sb-history").click(function(){
    $.ajax({
      url: "/history",
      success: function(data){
        $("#main-content").html(data);
      }
    });
  });
  
  
  $('.search-extra-info').live('click', function(){
    $("#search-detail").toggle('slow', function(){
      
    });
  });

});

