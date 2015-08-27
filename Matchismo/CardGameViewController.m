//
//  CardGameViewController.m
//  Matchismo
//
//  Created by simon jenni on 27/08/2015.
//  Copyright (c) 2015 Acme. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()

@end

@implementation CardGameViewController

// Abstract method
- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

@end
