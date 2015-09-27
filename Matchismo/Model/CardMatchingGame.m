//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by simon jenni on 23/08/2015.
//  Copyright (c) 2015 Acme. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (readwrite, nonatomic) NSInteger score;
@property (strong, nonatomic) NSMutableArray *cards; // of Card
@property (nonatomic) NSInteger numCards2match;
@property (readwrite, nonatomic) NSInteger lastMatchScore;

@end

@implementation CardMatchingGame

- (NSInteger)numDealtCards {
    return [self.cards count];
}

- (NSMutableArray *)cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (NSArray *)lastMatch {
    if (!_lastMatch) {
        _lastMatch = [[NSMutableArray alloc]init];
    }
    return _lastMatch;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck matching:(NSInteger)numCards2match
{
    self = [super init];
    if (self) {
        for (int i = 0; i<count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
        self.numCards2match = numCards2match;
    }
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return index < [self.cards count] ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int CHOSING_COST = 1;

- (void)choseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            NSArray *chosenUnmatchedCards = [self chosenUnmatchedCards];
            card.chosen = YES;
            if ([chosenUnmatchedCards count] == self.numCards2match-1) {
                self.lastMatch = [[NSArray alloc]initWithArray:[[chosenUnmatchedCards arrayByAddingObject:card] copy] copyItems:YES];
                int matchScore = [card match: chosenUnmatchedCards];
                if (matchScore) {
                    self.score += matchScore*MATCH_BONUS;
                    card.matched = YES;
                    for (Card *card in chosenUnmatchedCards) {
                        card.matched = YES;
                    }
                    self.lastMatchScore = matchScore;
                } else {
                    self.score -= MISMATCH_PENALTY;
                    for (Card *card in chosenUnmatchedCards) {
                        card.chosen = NO;
                    }
                    self.lastMatchScore = - MISMATCH_PENALTY;
                }
            }
            self.score -= CHOSING_COST;
        }
    }
    
}

- (void)removeMatchedCards {
    NSArray *unmatched = [self.cards filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(isMatched == NO)"]];
    self.cards = [NSMutableArray arrayWithArray:unmatched];
}

- (NSArray *)chosenUnmatchedCards {
    return [self.cards filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(isChosen == YES) && (isMatched == NO)"]];
}


@end
