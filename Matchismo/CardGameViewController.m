//
//  CardGameViewController.m
//  Matchismo
//
//  Created by simon jenni on 27/08/2015.
//  Copyright (c) 2015 Acme. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "SetCardView.h"
#import "CardViewBuilder.h"
#import "PlayingCardView.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet SetCardView *testCard;

@end

@implementation CardGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.numInitialCards = 35;
    self.maxCardSize = CGSizeMake(80.0, 120.0);
}

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (void)updateCardView:(CardView *)cardView forCardIndex:(NSInteger)idx inFrame:(CGRect)frame {
    [super updateCardView:cardView forCardIndex:idx inFrame:frame];
    Card *card = [self.game cardAtIndex:idx];
    PlayingCardView *playingCardView = (PlayingCardView *) cardView;
    playingCardView.faceUp = card.chosen || card.matched;
}


@end
