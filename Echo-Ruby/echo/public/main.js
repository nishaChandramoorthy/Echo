      function toTitleCase(str){
        return str.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
      }
      
      function getCategory(cat){

        
        ht = "<hr> <div class='loader-bar'></div>";
        $("#result").html(ht);
        cat = cat.replace( "&", "%26") 
        $.getJSON('/category/?query=' + cat, function(data) {
            if( $.isEmptyObject(data)){
              $(".start-disable").removeClass('start-disable')
              $("#details").html("") 
              $("#recommendation").html("")
              $("#rh").html("")
              $("#back").addClass('start-disable')
              $("#result").html("<p><i> Sorry, could not find anything!<br/> <h2>:( </h2></i></p> <br/> <br/> <p><i> To enhance your search please do the following : <ul> <li> Fix spelling mistakes </li> <li> Use more specific keywords </li> <li> Be as  descriptive as possible </li></ul> <br/> Happy Searching ! </i></p> ");
              $("#recommendation").html('<img src = "/error.jpg" />')
              return
            }
             cat = cat.replace("%26", "&");
             $("#result").html(cat + "<hr/>")

             for(d in data) {
              var imgSrc = data[d]["small"] == null ? "/images.jpg" : data[d]["small"];
                
              ht = '<div class="span3 cat-popover" > <dl> <dd> <a href="#" id="cat-' + data[d]["uuid"]+'"  rel="popover" data-content=" <i><b>Author:</b></i> ' + data[d]["authors"] + '<br/><br/> <i><b>Description:</b></i> '  + data[d]["description"] + '" data-original-title="' + data[d]["title"] + '"> <img src="' + imgSrc + '" style = "height: 162px; width: 102px;" /> </a> </dd> </dl></div>';

              $('#result').append(ht);
              $('#cat-' + data[d]["uuid"]).popover({html: true });
              $('#cat-' + data[d]["uuid"]).hover(function(){
                $(this).popover('show');
              });
              $('#cat-' + data[d]["uuid"]).mouseout(function(){
                $('.popover').remove();

                $(this).popover('hide');
              });

              $('#cat-' + data[d]["uuid"]).click(function(){
                $('.popover').remove();
                $(this).popover('hide');
                var id = this.id.substr(4,this.id.length);
                $.getJSON('/book/?id=' + id, function(data){
                  var imgSrc = data["small"] == null ? "/images.jpg" : data["small"]
                  data["subtitle"] = data["subtitle"] == null ? "" : data["subtitle"]
                  var bookName = data["title"].replace(" ", "_")
                  ht = '<div class="span4" > <dl> <dd> <i><b>' + data["title"] + '</b></i></dt> <dd>' + data["subtitle"] + '</dd> <dd> <br/> <img src="' + imgSrc + '" style = "height: 243px; width: 153px;" /> </dd> <dd> <br> <button class="btn primary" style="width: 153px; height: 100%;" href="#" onclick="showBooks(\'' + data["id"]  + '\',\'' + data["title"] + '\'); return false;"> view </button> <br> </dd> <dd> <a href="/download/?id=' + data["id"]  + '&name=' + bookName + '.pdf" > <button href="#" class="btn success" style="width: 153px; height: 100%;" > Download </button> </a> </dd> <dd> <i><b>Author:</b></i> <br/>' + data["authors"] + '<br/><dd> <i><b>Publisher:</b> </i>' + data["publisher"] + '</dd><br/> <dd> <i><b>Page count: </b></i>' + data["pageCount"] + '</dd><br/> ';
                  if ( data['mainCategories'] != null){
                    ht = ht + '<dd><i><b>Main Categories:</b></i> '+ data["mainCategories"] + ' </dd> <br/> ';
                  }
                  ht = ht + ' <dd><i><b>Other Categories:</b> </i>' + data["categories"] + '</dd><br/> <dd><i><b>Description:</b></i> ' + data["description"] + '</dd>  </dl></div>';  
                  $("#recommendation").html(ht);
                });

                
              });
              
            };

        });

      };

      function getCategoryResult(){
        var query = $('#search').val();
        $(".start-disable").removeClass('start-disable');
        $("#back").addClass('start-disable');
          
        $('#result').html("<div class='loader-bar'></div>");
        $('#recommendation').html("");
        $('#rh').html("")
        $('#details').html("")
        $.getJSON('/search/category/?query=' + query, function(data) {
          if( $.isEmptyObject(data)){
              $(".start-disable").removeClass('start-disable')
              $("#details").html("") 
              $("#recommendation").html("")
              $("#rh").html("")
              $("#back").addClass('start-disable')
              $("#result").html("<p><i> Sorry, could not find anything!<br/> <h2>:( </h2></i></p> <br/> <br/> <p><i> To enhance your search please do the following : <ul> <li> Fix spelling mistakes </li> <li> Use more specific keywords </li> <li> Be as  descriptive as possible </li></ul> <br/> Happy Searching ! </i></p> ");
              $("#recommendation").html('<img src = "/error.jpg" />')
              return
            }
           
          $("#result").html("<p><i> Please click on category to show results</i></p>")
          ht = "<dl>";
          for( d in data) {
            var category = data[d]
            category = $.trim(category)
            category = toTitleCase(category)
            ht += '<dt> <a href="#" onclick="getCategory(\'' + category + '\'); return false;"> <b>' + category + '</b> </a></dt>'; 
          };
          ht += "</dl>";
          $("#details").html(ht);
          getCategory(data[0]);
        });
      
      };

      function showBooks(id, name){
         var url = "http://echo.sdslabs.co.in:4568/download/?id=" + id + "&name=book.pdf" ;
         console.log(url);
         $('#book-view-name').html(name);
         $("#book-show").html('<object data="'+url +'" type="application/pdf" width="100%" height="600px" > <p> It appears your browser don\'t have PDF Plugin .. you can <a href="' +  url +'">  click here to download the pdf.</a></p></object>')
         $("#book-modal").modal("show");
      };
      
      function getResult(){

        var query = $('#search').val();
        $('#result').html("");
        $.getJSON('/search/?query='+query, function(data) {
            if( $.isEmptyObject(data)){
              $(".start-disable").removeClass('start-disable')
              $("#details").html("") 
              $("#recommendation").html("")
              $("#rh").html("")
              $("#back").addClass('start-disable')
              $("#result").html("<p><i> Sorry, could not find anything!<br/> <h2>:( </h2></i></p> <br/> <br/> <p><i> To enhance your search please do the following : <ul> <li> Fix spelling mistakes </li> <li> Use more specific keywords </li> <li> Be as  descriptive as possible </li></ul> <br/> Happy Searching ! </i></p> ");
              $("#recommendation").html('<img src = "/error.jpg" />')
              return
            }
            $(".start-disable").removeClass('start-disable')
            $("#details").html("<p><i>Please click on book icons to show details here! </i></p>");
            $("#recommendation").html("<i>Please click on book icons to show recommendation here !</i>")
            $("#rh").html("<b>You may also like!</b>")
            $("#back").addClass('start-disable')


            for(d in data) {
              var imgSrc = data[d]["small"] == null ? "/images.jpg" : data[d]["small"]
                
              ht = '<div class="span3 result-popover" > <dl> <dd> <a href="#" id="result-' + data[d]["uuid"]+'"  rel="popover" data-content=" <i><b>Author:</b></i> ' + data[d]["authors"] + '<br/><br/> <i><b>Description:</b></i> '  + data[d]["description"] + '" data-original-title="' + data[d]["title"] + '"> <img src="' + imgSrc + '" style = "height: 162px; width: 102px;" /> </a> </dd>  </dl></div>';

              
              $('#result').append(ht);
              $('#result-' + data[d]["uuid"]).popover({html: true });
              $('#result-' + data[d]["uuid"]).hover(function(){
                $(this).popover('show');
              });
              $('#result-' + data[d]["uuid"]).mouseout(function(){
                $('.popover').remove();

                $(this).popover('hide');
              });

              $('#result-' + data[d]["uuid"]).click(function(){
                $('.popover').remove();
                $(this).popover('hide');
                var id = this.id.substr(7,this.id.length);
                $.getJSON('/book/?id=' + id, function(data){
                  var imgSrc = data["small"] == null ? "/images.jpg" : data["small"]
                  var bookName = data["title"].replace(/ /g , "_")
                  ht = '<div class="span4" > <dl> <dd> <i><b>' + data["title"] + '</b></i></dt>';
                  
                  if ( data["subtitle"]!=null)
                                ht= ht + '<dd>' + data["subtitle"] + '</dd>';
                              
                  var bookName = data["title"].replace(" ", "_");
                             
                                
                   ht = ht + '<dd> <br/> <img src="' + imgSrc + '" style = "height: 243px; width: 153px;" /> </dd> <dd> <br> <button class="btn primary" style="width: 153px; height: 100%;" href="#" onclick="showBooks(\'' + data["id"]  + '\',\'' + data["title"] + '\'); return false;"> view </button> <br> </dd> <dd> <a href="/download/?id=' + data["id"]  + '&name=' + bookName + '.pdf" > <button href="#" class="btn success" style="width: 153px; height: 100%;" > Download </button> </a> </dd> <dd> <i><b>Author:</b></i> <br/>' + data["authors"] + '<br/><dd> <i><b>Publisher:</b> </i>' + data["publisher"] + '</dd><br/> <dd> <i><b>Page count: </b></i>' + data["pageCount"] + '</dd><br/> ';
                  if ( data['mainCategories'] != null){
                    ht = ht + '<dd><i><b>Main Categories:</b></i> '+ data["mainCategories"] + ' </dd> <br/> ';
                  }
                  ht = ht + ' <dd><i><b>Other Categories:</b> </i>' + data["categories"] + '</dd><br/> <dd><i><b>Description:</b></i> ' + data["description"] + '</dd>  </dl></div>';  
 
                  $("#details").html(ht);
                });

                getRecommendation(id);
              });
              
            };

        });
        
      };

      function getRecommendation(id){
        var url = '/recommend/?id=' + id
        $("#recommendation").html("")
        $.getJSON(url, function(data){
            ht = "";
            for( d in data ){
              var imgSrc = data[d]["small"] == null ? "/images.jpg" : data[d]["small"]

              ht = '<div class="row"> <div class="span2 result-popover"> <dl> <dd> <a href="#" id="recommend-' + data[d]["uuid"]+'" > <img src="' + imgSrc + '" style = "height: 108px; width: 67px;" /> </a> </dd> </dl></div> <div class="span2"> <i><b>' + data[d]["title"] + '</b></i> <br/> <i> Author: </i>' + data[d]["authors"] +'</div> </div> <br/>';

              
              $('#recommendation').append(ht);

              $('#recommend-' + data[d]["uuid"]).click(function(){
                $('.popover').remove();
                $(this).popover('hide');
                var id = this.id.substr(10,this.id.length);
                $.getJSON('/book/?id=' + id, function(data){
                  var imgSrc = data["small"] == null ? "/images.jpg" : data["small"]
                  var bookName = data["title"].replace(" ", "_")
                  ht = '<div class="span4" > <dl> <dd> <i><b>' + data["title"] + '</b></i></dt> <dd>' + data["subtitle"] + '</dd> <dd> <br/> <img src="' + imgSrc + '" style = "height: 243px; width: 153px;" /> </dd> <dd>  <br> <button class="btn primary" style="width: 153px; height: 100%;" href="#" onclick="showBooks(\'' + data["id"]  + '\',\'' + data["title"] + '\'); return false;"> view </button> <br> </dd> <dd> <a href="/download/?id=' + data["id"]  + '&name=' + bookName + '.pdf" > <button href="#" class="btn success" style="width: 153px; height: 100%;" > Download </button> </a> </dd> <dd> <i><b>Author:</b></i> <br/>' + data["authors"] + '<br/><dd> <i><b>Publisher:</b> </i>' + data["publisher"] + '</dd><br/> <dd> <i><b>Page count: </b></i>' + data["pageCount"] + '</dd><br/> <dd><i><b>Main Categories:</b></i> '+ data["mainCategories"] + ' </dd> <br/> <dd><i><b>Other Categories:</b> </i>' + data["categories"] + '</dd><br/> <dd><i><b>Description:</b></i> ' + data["description"] + ' </dl></div>';  
                  $("#details").html(ht);
                });

              });
              

            };
            $("recommendation").html(data)
        });
      }

	function getPickOfTheDay() {
		      		

      window.onload = function(){
        $("#book-modal").modal("hide")        
        $('#search').keypress(function(e) {
          if(e.keyCode == 13){
            getResult();
          }
        });
        $("#search").focus();
       };

