//
//  CardViewBuilder.m
//  Matchismo
//
//  Created by simon jenni on 13/09/2015.
//  Copyright (c) 2015 Acme. All rights reserved.
//

#import "CardViewBuilder.h"
#import "PlayingCard.h"
#import "PlayingCardView.h"
#import "SetCard.h"
#import "SetCardView.h"


@implementation CardViewBuilder

+ (CardView *)createViewForCard:(Card *)card withFrame:(CGRect)frame{
    if ([card isKindOfClass:[PlayingCard class]]) {
        PlayingCard *playingCard = (PlayingCard *)card;
        PlayingCardView *cardView = [[PlayingCardView alloc]initWithFrame:frame];
        cardView.suit = playingCard.suit;
        cardView.rank = playingCard.rank;
        cardView.faceUp = NO;
        return cardView;
    }
    if ([card isKindOfClass:[SetCard class]]) {
        SetCard *setCard = (SetCard *)card;
        SetCardView *cardView = [[SetCardView alloc]initWithFrame:frame];
        cardView.color = setCard.color;
        cardView.shading = setCard.shading;
        cardView.symbolCount = setCard.numSymbols;
        cardView.shape = setCard.shape;
        return cardView;
    }
    return nil;
}

@end
