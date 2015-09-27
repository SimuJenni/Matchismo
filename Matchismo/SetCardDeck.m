//
//  SetCardDeck.m
//  Matchismo
//
//  Created by simon jenni on 27/08/2015.
//  Copyright (c) 2015 Acme. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init {
    self = [super init];
    
    if (self) {
        for (int color=1; color<4; color++) {
            for (int shape=1; shape<4; shape++) {
                for (int count=1; count<4; count++) {
                    for (int shading=0; shading<4; shading++) {
                        SetCard *card = [[SetCard alloc]init];
                        [card setColor:color];
                        [card setShape:shape];
                        [card setNumSymbols:count];
                        [card setShading:shading];
                        [self addCard:card];
                    }
                }
            }
        }
    }
    return self;    
}

@end
