//
//  SetGameViewController.m
//  Matchismo
//
//  Created by simon jenni on 27/08/2015.
//  Copyright (c) 2015 Acme. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetGameViewController ()

@end

@implementation SetGameViewController

- (Deck *)createDeck {
    return [[SetCardDeck alloc] init];
}

- (UIImage *)imageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"setcardback"];
}

- (NSAttributedString *)titleForCard:(SetCard *)card {
    NSString *text = @"";
    for (int i=0; i<card.numSymbols; i++) {
        text = [text stringByAppendingString:card.symbol];
    }
    UIColor *color = [self colorFromName:card.color];
    UIColor *fillcolor = [color colorWithAlphaComponent:card.alpha];
    NSDictionary *attributes = @{NSForegroundColorAttributeName: fillcolor,
                                 NSStrokeWidthAttributeName: @-5,
                                 NSStrokeColorAttributeName: color};
    NSMutableAttributedString *title = [[NSMutableAttributedString alloc]initWithString:text attributes:attributes];
    
    return title;
}


- (UIColor *)colorFromName:(NSString *)name {
    NSDictionary *colorDict = @{ @"green": [UIColor greenColor],
                                 @"red" : [UIColor redColor],
                                 @"purple": [UIColor purpleColor]};
    return colorDict[name];
}

@end
