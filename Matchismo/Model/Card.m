//
//  Card.m
//  Matchismo
//
//  Created by simon jenni on 22/08/2015.
//  Copyright (c) 2015 Acme. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card

- (int)match:(NSArray *)otherCards {
    int score = 0;
    
    for (Card *card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    
    return score;
}

- (id)copyWithZone:(NSZone *)zone {
    Card *copy = [[Card allocWithZone:zone]init];
    [self copyFieldsTo:copy withZone:zone];
    return copy;
}

- (void)copyFieldsTo:(Card *)copy withZone: (NSZone *)zone{
    copy.matched = self.matched;
    copy.chosen = self.chosen;
    copy.contents = [self.contents copyWithZone:zone];
}


@end
