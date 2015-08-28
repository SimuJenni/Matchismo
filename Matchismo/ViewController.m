//
//  ViewController.m
//  Matchismo
//
//  Created by simon jenni on 22/08/2015.
//  Copyright (c) 2015 Acme. All rights reserved.
//

#import "ViewController.h"
#import "CardMatchingGame.h"
#import "HistoryViewController.h"

@interface ViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameTypeSwitch;
@property (weak, nonatomic) IBOutlet UILabel *matchLabel;
@property (strong, nonatomic) NSMutableAttributedString *history;
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

// Abstract method
- (Deck *)createDeck {
    return nil;
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
    self.history = nil;
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setAttributedTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self imageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
    NSAttributedString *lastMatch = [self makeLabelString];
    self.matchLabel.attributedText = lastMatch;
    if (self.history) {
        [self.history appendAttributedString:lastMatch];
    } else {
        self.history = [[NSMutableAttributedString alloc]initWithAttributedString:lastMatch];
    }
    [self.history appendAttributedString:[[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" Score: %ld", self.game.score]]];
    [self.history appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
}

- (NSAttributedString *)titleForCard:(Card *)card {
    NSAttributedString *title = [[NSAttributedString alloc]initWithString:card.isChosen ? card.contents :@""];
    return title;
}

- (UIImage *)imageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (NSInteger)cards2Match {
    if (self.gameTypeSwitch) {
        return self.gameTypeSwitch.selectedSegmentIndex + 2;
    } else {
        return 3;
    }
}

- (NSAttributedString *)makeLabelString {
    NSMutableAttributedString *label = [[NSMutableAttributedString alloc]init];
    NSAttributedString *joinElement = [[NSAttributedString alloc]initWithString:@" "];
    
    for (Card *card in self.game.lastMatch) {
        [label appendAttributedString:[self titleForCard:card]];
        [label appendAttributedString:joinElement];
    }
    
    if (self.game.lastMatchScore > 0) {
        [label insertAttributedString:[[NSAttributedString alloc]initWithString:@"Match: "] atIndex:0];
    } else if (self.game.lastMatchScore < 0) {
        [label insertAttributedString:[[NSAttributedString alloc]initWithString:@"Mismatch: "] atIndex:0];
    }
    [label appendAttributedString:[[NSAttributedString alloc]initWithString: [NSString stringWithFormat: @"MatchScore: %ld", (long)self.game.lastMatchScore]]];

    return label;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"HistorySegue"]) {
        if ([segue.destinationViewController isKindOfClass:[HistoryViewController class]]) {
            HistoryViewController *histVC = segue.destinationViewController;
            histVC.text = self.history;
        }
    }
}


@end
