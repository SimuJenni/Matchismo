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
        NSArray *alphas =[SetCard validAlphas];
        for (NSString *color in [SetCard validColors]) {
            for (NSString *symbol in [SetCard validSymbols]) {
                for (int i=1; i<=[SetCard maxNumSymbols]; i++) {
                    for (int j=0; j<[alphas count]; j++) {
                        SetCard *card = [[SetCard alloc]init];
                        [card setColor:color];
                        [card setSymbol:symbol];
                        [card setNumSymbols:i];
                        card.alpha = [alphas[j]doubleValue];
                        [self addCard:card];
                    }
                }
            }
        }
    }
    return self;    
}

@end
