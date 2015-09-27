//
//  SetCard.h
//  Matchismo
//
//  Created by simon jenni on 27/08/2015.
//  Copyright (c) 2015 Acme. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSUInteger color;
@property (nonatomic) NSUInteger shape;
@property (nonatomic) NSUInteger shading;
@property (nonatomic) NSUInteger numSymbols;

+ (NSArray *)validShapes;
+ (NSArray *)validColors;
+ (NSArray *)validShading;
+ (NSInteger)maxNumSymbols;

@end
