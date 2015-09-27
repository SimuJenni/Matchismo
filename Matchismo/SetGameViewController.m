//
//  SetGameViewController.m
//  Matchismo
//
//  Created by simon jenni on 27/08/2015.
//  Copyright (c) 2015 Acme. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "SetCardView.h"

@interface SetGameViewController ()

@end

@implementation SetGameViewController

- (Deck *)createDeck {
    return [[SetCardDeck alloc] init];
}

- (void) viewDidLoad {
    [super viewDidLoad];
    self.numInitialCards = 12;
    self.maxCardSize = CGSizeMake(120.0, 120.0);
}

- (void)updateCardView:(CardView *)cardView forCardIndex:(NSInteger)idx inFrame:(CGRect)frame {
    cardView.tag = idx;
    Card *card = [self.game cardAtIndex:idx];
    SetCardView *cv = (SetCardView *) cardView;
    [UIView animateWithDuration:0.5 delay:0 options: UIViewAnimationOptionTransitionNone animations:^{cv.chosen = card.isChosen;} completion:^(BOOL finished){}];
    if(card.matched) {
        [self removeCard:cardView];
    }
}

@end
