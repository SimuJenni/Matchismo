//
//  CardViewBuilder.h
//  Matchismo
//
//  Created by simon jenni on 13/09/2015.
//  Copyright (c) 2015 Acme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CardView.h"

@interface CardViewBuilder : NSObject

+ (CardView *)createViewForCard:(Card *)card withFrame:(CGRect)frame;

@end
