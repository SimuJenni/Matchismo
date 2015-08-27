//
//  SetCard.h
//  Matchismo
//
//  Created by simon jenni on 27/08/2015.
//  Copyright (c) 2015 Acme. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *symbol;
@property (nonatomic) double alpha;
@property (nonatomic) NSInteger numSymbols;

+ (NSArray *)validSymbols;
+ (NSArray *)validColors;
+ (NSArray *)validAlphas;
+ (NSInteger)maxNumSymbols;

@end
