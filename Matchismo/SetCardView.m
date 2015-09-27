//
//  SetCardView.m
//  Matchismo
//
//  Created by simon jenni on 13/09/2015.
//  Copyright (c) 2015 Acme. All rights reserved.
//

#import "SetCardView.h"

@interface SetCardView()
@property (nonatomic) CGFloat symbolHeight;
@property (nonatomic) CGFloat symbolWidth;

@end

@implementation SetCardView

#define DEFAULT_SYMBOL_ASPECTRATIO 0.5

- (void)setChosen:(BOOL)chosen {
    if (chosen!=self.chosen) {
        self.frame = [self getFrame];
    }
    _chosen = chosen;
    [self setNeedsDisplay];
}

- (CGRect)getFrame {
    CGRect chosenFrame;
    if (!self.chosen) {
        chosenFrame = CGRectMake(self.frame.origin.x+5, self.frame.origin.y+5, self.frame.size.width-10, self.frame.size.height-10);
    } else {
        chosenFrame = CGRectMake(self.frame.origin.x-5, self.frame.origin.y-5, self.frame.size.width+10, self.frame.size.height+10);
    }
    return chosenFrame;
}

- (CGFloat)symbolHeight {
    if (!_symbolHeight) {
        _symbolHeight = self.symbolWidth/DEFAULT_SYMBOL_ASPECTRATIO;
    }
    return _symbolHeight;
}

- (CGFloat)symbolWidth {
    if (!_symbolWidth) {
        _symbolWidth = self.bounds.size.width/3*0.7;
    }
    return _symbolWidth;
}


- (void)setShading:(NSUInteger)shading {
    _shading = shading;
    [self setNeedsDisplay];
}

- (void)setColor:(NSUInteger)color {
    _color = color;
    [self setNeedsDisplay];
}

- (void)setShape:(NSUInteger)shape {
    _shape = shape;
    [self setNeedsDisplay];
}

#define NUM_OF_FILL_LINES 30
#define DEFAULT_LINEWIDTH 0.1
#define FILL_ALPHA 0.4

- (CGFloat)scaleFactor {
    return self.bounds.size.width/3;
}

- (void)drawCardContent {
    
    switch (self.symbolCount) {
        case 1:
            [self drawSymbolAtPoint: CGPointMake(self.bounds.size.width/2-self.symbolWidth/2, self.bounds.size.height/2-self.symbolHeight/2)];
            break;
        case 2:
            [self drawSymbolAtPoint: CGPointMake(self.bounds.size.width/3-self.symbolWidth/2, self.bounds.size.height/2-self.symbolHeight/2)];
            [self drawSymbolAtPoint: CGPointMake(self.bounds.size.width*2/3-self.symbolWidth/2, self.bounds.size.height/2-self.symbolHeight/2)];
            break;
            
        case 3:
            [self drawSymbolAtPoint: CGPointMake(self.bounds.size.width*1/4-self.symbolWidth/2, self.bounds.size.height/2-self.symbolHeight/2)];
            [self drawSymbolAtPoint: CGPointMake(self.bounds.size.width*1/2-self.symbolWidth/2, self.bounds.size.height/2-self.symbolHeight/2)];
            [self drawSymbolAtPoint: CGPointMake(self.bounds.size.width*3/4-self.symbolWidth/2, self.bounds.size.height/2-self.symbolHeight/2)];
            break;
        default:
            break;
    }
    
}

- (void)drawSymbolAtPoint:(CGPoint)point {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, point.x, point.y);
    
    UIColor *strokeColor = [self colorForCardwithAlpha:1];
    
    [strokeColor setStroke];
    
    UIBezierPath *symbolPath = [self pathForShape];
    [symbolPath setLineWidth: DEFAULT_LINEWIDTH*[self scaleFactor]];
    
    [symbolPath addClip];
    [symbolPath stroke];
    
    [self shadeWithinShape:symbolPath];
    
    CGContextRestoreGState(context);
}

- (void)shadeWithinShape:(UIBezierPath *)symbolPath {
    UIColor *fillColor = [self colorForCardwithAlpha:FILL_ALPHA];
    UIBezierPath *fillPath;
    switch (self.shading) {
        case 1:
            // Stripes
            fillPath = [UIBezierPath bezierPath];
            [fillPath moveToPoint:CGPointMake(0, 0)];
            for (int i = 0; i<NUM_OF_FILL_LINES; i++) {
                [fillPath addLineToPoint:CGPointMake(self.symbolWidth, fillPath.currentPoint.y)];
                [fillPath moveToPoint:CGPointMake(0, fillPath.currentPoint.y+self.symbolHeight/NUM_OF_FILL_LINES)];
            }
            [fillPath setLineWidth:0.3*DEFAULT_LINEWIDTH*[self scaleFactor]];
            
            [fillColor setStroke];
            [fillPath stroke];
            break;
        case 2:
            // Fill
            [fillColor setFill];
            [symbolPath fill];
            break;
        default:
            break;
    }
}

- (UIColor *)colorForCardwithAlpha:(CGFloat)alpha {
    UIColor *color;
    switch (self.color) {
        case 1:
            //blue
            color = [UIColor colorWithRed:0 green:0 blue:1 alpha:alpha];
            break;
        case 2:
            //green
            color = [UIColor colorWithRed:0 green:1 blue:0 alpha:alpha];
            break;
        case 3:
            //red
            color = [UIColor colorWithRed:1 green:0 blue:0 alpha:alpha];
            break;
        default:
            break;
    }
    return color;
}

- (UIBezierPath *)pathForShape {

    UIBezierPath *symbolPath;

    switch (self.shape) {
        case 1:
            // Wavey shape
            symbolPath = [UIBezierPath bezierPath];
            [symbolPath moveToPoint:CGPointMake(self.symbolWidth*0.1, 0)];
            [symbolPath addCurveToPoint:CGPointMake(self.symbolWidth*0.75, self.symbolHeight*0.5)
                          controlPoint1:CGPointMake(self.symbolWidth*0.95, self.symbolHeight*0.0)
                          controlPoint2:CGPointMake(self.symbolWidth*0.8, self.symbolHeight*0.4)];
            [symbolPath addCurveToPoint:CGPointMake(self.symbolWidth*0.9, self.symbolHeight*1.0)
                          controlPoint1:CGPointMake(self.symbolWidth*0.7, self.symbolHeight*0.6)
                          controlPoint2:CGPointMake(self.symbolWidth*0.55, self.symbolHeight*1.0)];
            [symbolPath addCurveToPoint:CGPointMake(self.symbolWidth*0.25, self.symbolHeight*0.5)
                          controlPoint1:CGPointMake(self.symbolWidth*0.05, self.symbolHeight*1.0)
                          controlPoint2:CGPointMake(self.symbolWidth*0.2, self.symbolHeight*0.6)];
            [symbolPath addCurveToPoint:CGPointMake(self.symbolWidth*0.1, self.symbolHeight*0.0)
                          controlPoint1:CGPointMake(self.symbolWidth*0.3, self.symbolHeight*0.4)
                          controlPoint2:CGPointMake(self.symbolWidth*0.45, self.symbolHeight*0.0)];
            [symbolPath closePath];
            break;
            
        case 2:
            // Diamant
            symbolPath = [UIBezierPath bezierPath];
            [symbolPath moveToPoint:CGPointMake(self.symbolWidth*0.5, 0)];
            [symbolPath addLineToPoint:CGPointMake(self.symbolWidth, self.symbolHeight*0.5)];
            [symbolPath addLineToPoint:CGPointMake(self.symbolWidth*0.5, self.symbolHeight)];
            [symbolPath addLineToPoint:CGPointMake(0, self.symbolHeight*0.5)];
            [symbolPath closePath];
            break;
        case 3:
            // Rounded rect thingie
            symbolPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.symbolWidth, self.symbolHeight) cornerRadius:self.symbolWidth/2];
            break;
            
        default:
            break;
    }

    return symbolPath;
}


@end
