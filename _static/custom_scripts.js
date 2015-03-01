$(window).load(function(){

    $(".multi-code-block").each(function(){

        var $docblock = $(this);

        var $buttons = $("<div/>");
        $buttons.addClass("buttons");
        $docblock.prepend($buttons);

        var biggestBlock = 0;

        $(this).find("ul>li").each(function(){

            var $title = $(this).children("em");
            var $block = $(this).children("div");

            var $ulParent = $title.closest("ul");
            var $relatedBlock = $title.closest("li");

            var previousCss  = $block.attr("style");
            $block.css({
                position:   'absolute',
                visibility: 'hidden',
                display:    'block'
            });
            var height = $block.height();
            if(biggestBlock < height){
                biggestBlock = height;
            }
            $block.attr("style", previousCss ? previousCss : "");

            $block.attr("data_height", height);


            $title.click(function(){

                $ulParent.find(".show").removeClass("show");
                $relatedBlock.children("div").addClass("show");

                $(this).parent().find(".show").removeClass("show");
                $(this).addClass("show");


            });

            $buttons.append($title);

        });

        console.log(biggestBlock);


        $(this).find("ul>li>div").each(function() {

          if( biggestBlock - $(this).attr("data_height") > 40 ){
              $(this).height(biggestBlock);
          }

        });


        $(this).find(".buttons>em").first().trigger("click");

    });

});