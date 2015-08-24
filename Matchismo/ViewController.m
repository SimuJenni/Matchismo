//
//  ViewController.m
//  Matchismo
//
//  Created by simon jenni on 22/08/2015.
//  Copyright (c) 2015 Acme. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface ViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameTypeSwitch;
@property (weak, nonatomic) IBOutlet UILabel *matchLabel;
@end

@implementation ViewController

- (CardMatchingGame *)game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]
                                                   matching:[self cards2Match]];
    }
    return _game;
}

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    NSUInteger chosenIndex = [self.cardButtons indexOfObject:sender];
    [self.game choseCardAtIndex:chosenIndex];
    [self updateUI];
    self.gameTypeSwitch.enabled = NO;
}

- (IBAction)dealNew:(UIButton *)sender {
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]
                                                   matching:[self cards2Match]];
    [self updateUI];
    self.gameTypeSwitch.enabled = YES;
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self imageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
        self.matchLabel.text = [self makeLabelString];
    }
}

- (NSString *)titleForCard:(Card *)card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)imageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (NSInteger)cards2Match {
    return self.gameTypeSwitch.selectedSegmentIndex + 2;
}

- (NSString *)makeLabelString {
    if (self.game.lastMatchScore > 0) {
        return [NSString stringWithFormat:@"Match: %@   MatchScore: %ld", [self.game.lastMatch componentsJoinedByString:@", "], (long)self.game.lastMatchScore];
    } else if (self.game.lastMatchScore < 0) {
        return [NSString stringWithFormat:@"Mismatch: %@   Penalty: %ld", [self.game.lastMatch componentsJoinedByString:@", "], (long)self.game.lastMatchScore];
    } else {
        return @"";
    }
}


@end
