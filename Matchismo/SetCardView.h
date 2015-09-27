//
//  SetCardView.h
//  Matchismo
//
//  Created by simon jenni on 13/09/2015.
//  Copyright (c) 2015 Acme. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardView.h"

@interface SetCardView : CardView

@property (nonatomic) NSUInteger shading;
@property (nonatomic) NSUInteger color;
@property (nonatomic) NSUInteger shape;
@property (nonatomic) NSUInteger symbolCount;
@property (nonatomic) BOOL chosen;

@end
