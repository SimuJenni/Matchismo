//
//  ViewController.m
//  Matchismo
//
//  Created by simon jenni on 22/08/2015.
//  Copyright (c) 2015 Acme. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) Deck *cardDeck;

@end

@implementation ViewController

- (Deck *)cardDeck {
    if (!_cardDeck) {
        _cardDeck = [[PlayingCardDeck alloc] init];
    }
    return _cardDeck;
}

- (void) setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"FlipCount changed to %d", self.flipCount);
}

- (IBAction)touchCardButton:(UIButton *)sender {
    
    if (sender.currentTitle.length) {
        [sender setBackgroundImage: [UIImage imageNamed:@"cardback"]
                          forState: UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
        self.flipCount++;
    } else {
        Card *card = [self.cardDeck drawRandomCard];
        if (card) {
            [sender setBackgroundImage: [UIImage imageNamed:@"cardfront"]
                          forState: UIControlStateNormal];
            [sender setTitle: card.contents forState:UIControlStateNormal];
            self.flipCount++;
        }
    }

}


@end
