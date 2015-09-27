//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by simon jenni on 23/08/2015.
//  Copyright (c) 2015 Acme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck matching:(NSInteger)numCards2match;
- (void)choseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (void)removeMatchedCards;


@property (readonly, nonatomic) NSInteger score;
@property (strong, nonatomic) NSArray *lastMatch;
@property (readonly, nonatomic) NSInteger lastMatchScore;
@property (readonly, nonatomic) NSInteger numDealtCards;

@end
