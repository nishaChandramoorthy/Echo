      function showBooks(id, name){
         var url = "http://192.168.208.204:4568/download/?id=" + id + "&name=book.pdf" ;
         console.log(url);
         $('#book-view-name').html(name);
         $("#book-show").html('<object data="'+url +'" type="application/pdf" width="100%" height="100%" > <p> It appears your browser don\'t have PDF Plugin .. you can <a href="' +  url +'">  click here to download the pdf.</a></p></object>')
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
                
              ht = '<div class="span3 result-popover" > <dl> <dd> <a href="#" id="result-' + data[d]["uuid"]+'"  rel="popover" data-content=" <i><b>Author:</b></i> ' + data[d]["authors"] + '<br/><br/> <i><b>Description:</b></i> '  + data[d]["description"] + '" data-original-title="' + data[d]["title"] + '"> <img src="' + imgSrc + '" style = "height: 162px; width: 102px;" /> </a> </dd> </dl></div>';

              
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
                  ht = '<div class="span4" > <dl> <dd> <i><b>' + data["title"] + '</b></i></dt> <dd>' + data["subtitle"] + '</dd> <dd> <br/> <img src="' + imgSrc + '" style = "height: 243px; width: 153px;" /> </dd> <dd> <br> <button class="btn primary" style="width: 153px; height: 100%;" href="#" onclick="showBooks(\'' + data["id"]  + '\',\'' + data["title"] + '\'); return false;"> view </button> <br> </dd> <dd> <i><b>Author:</b></i> <br/>' + data["authors"] + '<br/><dd> <i><b>Publisher:</b> </i>' + data["publisher"] + '</dd><br/> <dd> <i><b>Page count: </b></i>' + data["pageCount"] + '</dd><br/> <dd><i><b>Main Categories:</b></i> '+ data["mainCategories"] + ' </dd> <br/> <dd><i><b>Other Categories:</b> </i>' + data["categories"] + '</dd><br/> <dd><i><b>Description:</b></i> ' + data["description"] + '</dd>  </dl></div>';  
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
                  ht = '<div class="span4" > <dl> <dd> <i><b>' + data["title"] + '</b></i></dt> <dd>' + data["subtitle"] + '</dd> <dd> <br/> <img src="' + imgSrc + '" style = "height: 243px; width: 153px;" /> </dd> <dd>  <br> <button class="btn primary" style="width: 153px; height: 100%;" href="#" onclick="showBooks(\'' + data["id"]  + '\',\'' + data["title"] + '\'); return false;"> view </button> <br> </dd><dd> <i><b>Author:</b></i> <br/>' + data["authors"] + '<br/><dd> <i><b>Publisher:</b> </i>' + data["publisher"] + '</dd><br/> <dd> <i><b>Page count: </b></i>' + data["pageCount"] + '</dd><br/> <dd><i><b>Main Categories:</b></i> '+ data["mainCategories"] + ' </dd> <br/> <dd><i><b>Other Categories:</b> </i>' + data["categories"] + '</dd><br/> <dd><i><b>Description:</b></i> ' + data["description"] + ' </dl></div>';  
                  $("#details").html(ht);
                });

              });
              

            };
            $("recommendation").html(data)
        });
      }


      window.onload = function(){
        $("#book-modal").modal("hide")        
        $('#search').keypress(function(e) {
          if(e.keyCode == 13){
            getResult();
          }
        });
        $("#search").focus()
      };

