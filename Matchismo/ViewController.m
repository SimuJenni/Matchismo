//
//  ViewController.m
//  Matchismo
//
//  Created by simon jenni on 22/08/2015.
//  Copyright (c) 2015 Acme. All rights reserved.
//

#import "ViewController.h"
#import "Grid.h"
#import "CardView.h"
#import "CardViewBuilder.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameTypeSwitch;
@property (weak, nonatomic) IBOutlet UIView *cardGrid;
@property (strong, nonatomic) NSMutableArray *cards; // of CardViews
@property (strong, nonatomic) Grid *grid;
@property (nonatomic) BOOL cardsRemoved;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@property (nonatomic) CGPoint anchor;

@end

@implementation ViewController

#pragma mark - Setters and Getters

- (NSMutableArray *)cards {
    if (!_cards) {
        _cards = [NSMutableArray arrayWithCapacity:self.numInitialCards];
    }
    return _cards;
}

- (CardMatchingGame *)game {
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.numInitialCards
                                                  usingDeck:[self createDeck]
                                                   matching:[self cards2Match]];
    }
    return _game;
}

- (UIDynamicAnimator *)animator {
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.view];
    }
    return _animator;
}

- (Grid *)grid {
    if (!_grid) {
        _grid = [[Grid alloc]init];
        _grid.size = self.cardGrid.frame.size;
        _grid.cellAspectRatio = self.maxCardSize.height/self.maxCardSize.height;
        _grid.minimumNumberOfCells = self.numInitialCards;
        _grid.maxCellHeight = self.maxCardSize.height;
        _grid.maxCellWidth = self.maxCardSize.width;
    }
    return _grid;
}

#pragma mark - Handle Gestures

- (IBAction)pinch:(UIPinchGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        UICollisionBehavior *collision = [[UICollisionBehavior alloc]initWithItems:self.cards];
        [collision setCollisionMode:UICollisionBehaviorModeBoundaries];
        [self.animator addBehavior:collision];
        for (CardView *cv in self.cards) {
            self.anchor = [sender locationInView:self.view];
            UISnapBehavior *snap = [[UISnapBehavior alloc]initWithItem:cv snapToPoint:self.anchor];
            [self.animator addBehavior:snap];
            UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
            [cv addGestureRecognizer:pan];
            cv.center = self.anchor;
        }
    }
}

- (void)pan:(UIPanGestureRecognizer *)pan {
    if (pan.state == UIGestureRecognizerStateChanged) {
        self.anchor = [pan locationInView:self.view];
        for (CardView *cv in self.cards) {
            cv.center = self.anchor;
        }
    }
}

- (void)tapGesture:(UITapGestureRecognizer *)tapGestureRecognizer {
    NSInteger idx = tapGestureRecognizer.view.tag;
    [self.game choseCardAtIndex:idx];
    [self updateUI];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.cardsRemoved) {
        [self.game removeMatchedCards];
        self.grid.minimumNumberOfCells = [self.cards count];
        self.cardsRemoved = NO;
        [self.animator removeAllBehaviors];
        [self updateUI];
    }
}

#pragma mark - UI

- (void)updateUI {
    int idx = 0;
    for (int row=0; row<[self.grid rowCount]; row++) {
        for (int col=0; col<[self.grid columnCount]; col++) {
            CardView *cardView;
            CGRect frame = [self.grid frameOfCellAtRow:row inColumn:col];
            if ([self.cards count]>idx) {
                cardView = self.cards[idx];
                [self updateCardView:cardView forCardIndex:idx inFrame:frame];
            } else {
                cardView = [self createViewForCard:idx withFrame:frame];
            }
            idx++;
        }
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
}

- (void)updateCardView:(CardView *)cardView forCardIndex:(NSInteger)idx inFrame:(CGRect)frame {
    cardView.tag = idx;
    [UIView animateWithDuration:0.5 delay:0 options: UIViewAnimationOptionTransitionNone animations:^{cardView.frame = frame;} completion:^(BOOL finished){}];
}


- (void)addCardView:(CardView *)cardView atFrame:(CGRect)frame withDelay:(double)delay {
    cardView.frame = CGRectMake(self.view.bounds.size.width, self.view.bounds.size.height, frame.size.width,frame.size.height);
    [self.cards addObject:cardView];
    [self.cardGrid addSubview:cardView];
    [UIView animateWithDuration:0.5 delay:delay options: UIViewAnimationOptionTransitionNone animations:^{cardView.frame = frame;} completion:^(BOOL finished){}];
}

- (CardView *)createViewForCard:(NSInteger)idx withFrame:(CGRect)frame{
    CardView *cardView = [CardViewBuilder createViewForCard:[self.game cardAtIndex:idx] withFrame:frame];
    if (cardView) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
        [cardView addGestureRecognizer:tap];
        [self addCardView:cardView atFrame:frame withDelay:idx*0.1];
    }
    return cardView;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.grid.size = self.cardGrid.frame.size;
    [self updateUI];
}

#pragma mark - Handle Cards

// Abstract method
- (Deck *)createDeck {
    return nil;
}

- (void)removeCard:(CardView *)cv {
    [UIView animateWithDuration:0.5
                          delay: 0
                        options: UIViewAnimationOptionTransitionNone
                     animations:^{cv.frame = CGRectMake(-1000, -1000, cv.frame.size.width,cv.frame.size.height);}
                     completion:^(BOOL finished){[cv removeFromSuperview];
                         [self.cards removeObject:cv];}];
    self.cardsRemoved = YES;
}


- (IBAction)dealNew:(UIButton *)sender {
    for (CardView *cv in self.cards) {
        [self removeCard:cv];
    }
    self.cards = nil;
    self.game = nil;
    [self.animator removeAllBehaviors];
    [self updateUI];
    self.gameTypeSwitch.enabled = YES;
}

- (NSInteger)cards2Match {
    if (self.gameTypeSwitch) {
        return self.gameTypeSwitch.selectedSegmentIndex + 2;
    } else {
        return 3;
    }
}


@end
