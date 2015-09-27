//
//  ViewController.h
//  Matchismo
//
//  Created by simon jenni on 22/08/2015.
//  Copyright (c) 2015 Acme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardView.h"
#import "CardMatchingGame.h"


@interface ViewController : UIViewController
@property (nonatomic) NSUInteger numInitialCards;
@property (nonatomic) CGSize maxCardSize;
@property (strong, nonatomic) CardMatchingGame *game;


- (void)updateCardView:(CardView *)cardView forCardIndex:(NSInteger)idx inFrame:(CGRect)frame;
- (void)removeCard:(CardView *)cv;
- (void)updateUI;


@end

