$(document).ready(function(){
  makeAjaxCall({rating: 'init'});

  $('#show-answer-button').click(function(e){
    toggleDisplay();
  });

  $('#good-card-button').click(function(e) {
    makeAjaxCall({ rating: 'good' });
  });

  function toggleDisplay() {
    $('#card-a').toggle();
    $('#control-a').toggle();
    $('#control-q').toggle();
    $('#card-control-console').toggle();
  };

  function makeAjaxCall(args) {
    var req = $.ajax({
      type: 'post',
      url: '/study/' + getDeckID(),
      dataType: 'json',
      data: {rating: args.rating}
    });

    req.done(function(res){
      console.log(res);
      if (args.rating !== 'init') {
        toggleDisplay();
      }
      loadCard(res.card, res.message);
    });
  };

  function loadCard(card) {
    $('#card-q').html(card.front);
    $('#card-a').html(card.back);
    $('#card-id').html(card.id);
    // if (message !== undefined) {
    //   $('#card-message').html((message));
    // };
  };

  function getDeckID() {
    return $.trim($('#deck-id').html());
  };
});
