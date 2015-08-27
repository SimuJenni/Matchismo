//
//  SetCard.m
//  Matchismo
//
//  Created by simon jenni on 27/08/2015.
//  Copyright (c) 2015 Acme. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

+ (NSArray *)validColors {
    return @[@"red", @"green", @"purple"];
}

+ (NSArray *)validSymbols {
    return @[@"▲", @"◼︎", @"◉"];
}

+ (NSArray *)validAlphas {
    return @[@0.0, @0.3, @1.0];
}

+ (NSInteger)maxNumSymbols {
    return 3;
}

- (void) setSymbol:(NSString *)symbol {
    if ([[SetCard validSymbols] containsObject: symbol]) {
        _symbol = symbol;
    }
}

- (void) setColor:(NSString *)color {
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}

- (void) setAlpha:(double)alpha {
    if ([[SetCard validAlphas] containsObject:@(alpha) ]) {
        _alpha = alpha;
    }
}

static const int MATCH_POINTS = 1;

- (int)match:(NSArray *)otherCards {
    int score = 0;
    NSArray *allCards = [otherCards arrayByAddingObject:self];
    NSArray *uniqueColors = [allCards valueForKeyPath:@"@distinctUnionOfObjects.color"];
    NSArray *uniqueNums = [allCards valueForKeyPath:@"@distinctUnionOfObjects.numSymbols"];
    NSArray *uniqueSymbols = [allCards valueForKeyPath:@"@distinctUnionOfObjects.symbol"];
    NSArray *uniqueAlphas = [allCards valueForKeyPath:@"@distinctUnionOfObjects.alpha"];
    if ([uniqueColors count] == 1 || [uniqueNums count] == 1 ||
        [uniqueSymbols count] == 1 || [uniqueAlphas count] == 1) {
        score += MATCH_POINTS;
    }
    if ([uniqueColors count] == 3 || [uniqueNums count] == 3 ||
        [uniqueSymbols count] == 3 || [uniqueAlphas count] == 3) {
        score += MATCH_POINTS;
    }

    return score;
}

@end
