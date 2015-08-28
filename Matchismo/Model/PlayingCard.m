//
//  PlayingCard.m
//  Matchismo
//
//  Created by simon jenni on 22/08/2015.
//  Copyright (c) 2015 Acme. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit; // because we provide setter AND getter

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

+ (NSArray *)validSuits {
    return @[@"♠️", @"♣️", @"♥️", @"♦️"];
}

- (void) setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject: suit]) {
        _suit = suit;
    }
}

+ (NSArray *)rankStrings {
    return @[ @"?", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank {
    return [[self rankStrings] count]-1;
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

static const int SUIT_FACTOR = 1;
static const int RANK_FACTOR = 4;


- (int)match:(NSArray *)otherCards {
    int score = 0;
    NSArray *allCards = [otherCards arrayByAddingObject:self];
    NSUInteger numCards = [allCards count];
    NSArray *uniqueRanks = [allCards valueForKeyPath:@"@distinctUnionOfObjects.rank"];
    NSArray *uniqueSuit = [allCards valueForKeyPath:@"@distinctUnionOfObjects.suit"];
    score += (numCards-[uniqueRanks count])*RANK_FACTOR;
    score += (numCards-[uniqueSuit count])*SUIT_FACTOR;
    return score;
}

- (id)copyWithZone:(NSZone *)zone {
    PlayingCard *copy = [[PlayingCard allocWithZone:zone]init];
    [self copyFieldsTo:copy withZone:zone];
    return copy;
}


- (void)copyFieldsTo:(PlayingCard *)copy withZone:(NSZone *)zone{
    [super copyFieldsTo:copy withZone:zone];
    copy.rank = self.rank;
    copy.suit = [self.suit copyWithZone:zone];
}

@end
