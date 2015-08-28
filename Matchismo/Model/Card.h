//
//  Card.h
//  Matchismo
//
//  Created by simon jenni on 22/08/2015.
//  Copyright (c) 2015 Acme. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject <NSCopying>

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

- (int)match:(NSArray *)otherCards;
- (void)copyFieldsTo:(Card *)copy withZone: (NSZone *)zone;


@end
