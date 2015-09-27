//
//  CardView.m
//  Matchismo
//
//  Created by simon jenni on 13/09/2015.
//  Copyright (c) 2015 Acme. All rights reserved.
//

#import "CardView.h"

@implementation CardView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - initialization

- (void)setup {
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib {
    [self setup];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

#define RADIUS_FACTOR 40.0

- (CGFloat)cornerRadius {
    return  (self.bounds.size.height+self.bounds.size.width)/RADIUS_FACTOR;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius: [self cornerRadius]];
    
    // Draw Card outlines
    [roundedRect addClip];
    [[UIColor whiteColor]setFill];
    UIRectFill(self.bounds);
    [[UIColor blackColor]setStroke];
    [roundedRect stroke];
    
    [self drawCardContent];
}


- (void)drawCardContent {
    
}

@end
