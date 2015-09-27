//
//  PlayingCardView.h
//  Matchismo
//
//  Created by simon jenni on 13/09/2015.
//  Copyright (c) 2015 Acme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardView.h"

@interface PlayingCardView : CardView

@property (nonatomic) NSUInteger rank;
@property (nonatomic, strong) NSString *suit;
@property (nonatomic) BOOL faceUp;

@end
