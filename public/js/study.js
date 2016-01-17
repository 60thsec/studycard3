$(document).ready(function(){
  makeAjaxCall( {rating: 'init', card: getCardID()} );

  $('#show-answer-button').click(function(e){
    e.preventDefault();
    toggleDisplay();
  });

  $('#good-card-button').click(function(e) {
    e.preventDefault();
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
      data: {rating: args.rating, card: getCardID()}
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
  };

  function getDeckID() {
    return $('#deck-id').val();
  };

  function getCardID() {
    return $('#card-id').val();
  };
});
