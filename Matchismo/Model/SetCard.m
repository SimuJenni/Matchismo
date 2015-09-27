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
    return @[@1, @2, @3];
}

+ (NSArray *)validShapes {
    return @[@1, @2, @3];
}

+ (NSArray *)validShading {
    return @[@1, @2, @3];
}

+ (NSInteger)maxNumSymbols {
    return 3;
}

static const int MATCH_POINTS = 1;

- (int)match:(NSArray *)otherCards {
    int score = 0;
    NSArray *allCards = [otherCards arrayByAddingObject:self];
    NSArray *uniqueColors = [allCards valueForKeyPath:@"@distinctUnionOfObjects.color"];
    NSArray *uniqueNums = [allCards valueForKeyPath:@"@distinctUnionOfObjects.numSymbols"];
    NSArray *uniqueShapes = [allCards valueForKeyPath:@"@distinctUnionOfObjects.shape"];
    NSArray *uniqueShading = [allCards valueForKeyPath:@"@distinctUnionOfObjects.shading"];
    if ([uniqueColors count] == 1 || [uniqueNums count] == 1 ||
        [uniqueShapes count] == 1 || [uniqueShading count] == 1) {
        score += MATCH_POINTS;
    }
    if ([uniqueColors count] == 3 || [uniqueNums count] == 3 ||
        [uniqueShapes count] == 3 || [uniqueShading count] == 3) {
        score += MATCH_POINTS;
    }

    return score;
}

- (id)copyWithZone:(NSZone *)zone {
    SetCard *copy = [[SetCard allocWithZone:zone]init];
    [self copyFieldsTo:copy withZone:zone];
    return copy;
}

- (void)copyFieldsTo:(SetCard *)copy withZone:(NSZone *)zone{
    [super copyFieldsTo:copy withZone:zone];
    copy.color = self.color;
    copy.shape = self.color;
    copy.shading = self.shading;
    copy.numSymbols = self.numSymbols;
}


@end
