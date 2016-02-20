use strict;
use warnings;
use feature qw(say);
use List::Util qw(shuffle);

our @player_cards = ();
our @dealer_cards = ();
our @cards = (1, 1, 1, 1, 2, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 4, 5, 5, 5, 5, 6, 6, 6, 6, 7, 7, 7, 7, 8, 8, 8, 8, 9, 9, 9, 9, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10);
our @deck = shuffle @cards;
our $player_total = 0;
our $dealer_total = 0;
our $choice = '';

# Deals cards to player and dealer
sub deal_player{
  my $card = pop @deck;
  $player_total += $card;

  push (@player_cards, $card);
}

sub deal_dealer{
  unless($dealer_total >= 17){
    my $card = pop @deck;
    $dealer_total += $card;

    push (@dealer_cards, $card);
  }
}

sub start_game{
  for (my $i=0; $i < 2; $i++) {
    deal_player;
    deal_dealer;
  }
  say "The player cards are: @player_cards";
  say "The dealer cards are: @dealer_cards";
}

sub player_turn{
  unless($player_total >= 21 || $choice eq "S"){
    say "Player, do you want to HIT? or Stay? (type H for HIT, or S for STAY)";
    $choice = uc <>;
    chomp $choice;
    if ($choice eq "H" ){
      deal_player;
      say "The player cards are: @player_cards";
    }
    say "The Players card total is $player_total";
  }
}

sub player_win{
  ($player_total <= 21 && $dealer_total > 21) || ($choice eq "S" && $dealer_total >= 17 && $player_total > $dealer_total);
}

sub dealer_win{
  ($player_total > 21 && $dealer_total <= 21) || ($choice eq "S" && $dealer_total >= 17 && $dealer_total >= $player_total);
}

sub game_over{
   player_win || dealer_win;
}


start_game;
until( game_over ){
  player_turn;
  if(player_win){
    last;
  }
  deal_dealer;
}
say "The Players card total is $player_total";
say "The Dealers card total is $dealer_total";
if(player_win) {
  say "You win!";
} else {
  say "Dealer beat you, sucker.";
}






# De-reference the list's scalar
# my @hand = @{ $hand_ref };
# my @cards = @{ $deck_ref};
