//
//  GameViewController.m
//  Battleship
//
//  Created by doxper on 30/01/19.
//  Copyright © 2019 Battleship. All rights reserved.
//

#import "GameViewController.h"
#import "Board.h"
#import "BoardCollectionCell.h"
#import "ShipCollectionCell.h"

@interface GameViewController () {
    
    __weak IBOutlet UILabel *playerTurnLabel;
    __weak IBOutlet UICollectionView *gameCollectionView;
    
    Board *currentBoard;
    NSInteger currentBoardIndex;
}

@end

@implementation GameViewController

#pragma mark View Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeView];
    [self updateCurrentBoardByBlock:nil];
}

#pragma mark Action Methods
- (IBAction)closeButtonClicked:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark Private Methods
-(void)initializeView {
    [gameCollectionView registerNib:[UINib nibWithNibName:@"BoardCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"BoardCollectionCell"];
    [gameCollectionView registerNib:[UINib nibWithNibName:@"ShipCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"ShipCollectionCell"];
}

-(void)updateCurrentBoardByBlock:(Block*)block {
    if (block) {
        if (block.isClicked && block.isHit) {
            if ([currentBoard allShipsFound]) {
                [self gameOver];
            }
        }
        else {
            currentBoardIndex = currentBoardIndex == 1 ? 0 : 1;
        }
    }
    else {
        currentBoardIndex = 1;
    }
    currentBoard = [self.boardController.boards objectAtIndex:currentBoardIndex];
    NSInteger turnIndex = currentBoardIndex == 1 ? 1 : 2;
    playerTurnLabel.text = [NSString stringWithFormat:@"Player %ld's Turn", (long)turnIndex];
}

-(void)gameOver {
    NSInteger playerIndex = currentBoardIndex == 1 ? 1 : 2;
    NSString *message = [NSString stringWithFormat:@"Found all the ships!\nPlayer %ld won!", playerIndex];
    UIAlertController *gameOverAlertController = [UIAlertController alertControllerWithTitle:@"Game over!" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [gameOverAlertController addAction:okAction];
    [self presentViewController:gameOverAlertController animated:YES completion:nil];
}

#pragma mark -
#pragma mark UICollectionViewDataSource Methods
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return section == 0 ? currentBoard.blocks.count : currentBoard.ships.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        BoardCollectionCell *boardCollectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BoardCollectionCell" forIndexPath:indexPath];
        Block *block = [currentBoard.blocks objectAtIndex:indexPath.item];
        [boardCollectionCell fillCellData:indexPath.item withBlock:block isGameOn:YES];
        return boardCollectionCell;
    }
    else {
        ShipCollectionCell *shipCollectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShipCollectionCell" forIndexPath:indexPath];
        Ship *ship = [currentBoard.ships objectAtIndex:indexPath.item];
        [shipCollectionCell fillCellData:indexPath.item withShip:ship];
        return shipCollectionCell;
    }
}

#pragma mark UICollectionViewDelegate Methods
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        Block *block = (Block*)[currentBoard.blocks objectAtIndex:indexPath.item];
        if (block && !block.isClicked) {
            [block clicked];
            collectionView.userInteractionEnabled = NO;
            [self updateCellForIndexPath:indexPath block:block];
        }
    }
}

-(void)updateCellForIndexPath:(NSIndexPath*)indexPath block:(Block*)block {
    BoardCollectionCell *boardCollectionCell = (BoardCollectionCell*)[gameCollectionView cellForItemAtIndexPath:indexPath];
    [boardCollectionCell updateHitMissImageViewForBlock:block];
    if (boardCollectionCell) {
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            boardCollectionCell.hitMissImageView.transform = CGAffineTransformMakeScale(3, 3);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                boardCollectionCell.hitMissImageView.transform = CGAffineTransformMakeScale(1, 1);
            } completion:^(BOOL finished) {
                [self updateCurrentBoardByBlock:block];
                [gameCollectionView reloadData];
                gameCollectionView.userInteractionEnabled = YES;
            }];
        }];
    }
}

#pragma mark UICollectionViewDelegateFlowLayout Methods
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CGFloat squareSize = [UIScreen mainScreen].bounds.size.width / 10.0;
        return CGSizeMake(squareSize, squareSize);
    }
    else {
        CGFloat width = [UIScreen mainScreen].bounds.size.width / 2.0;
        return CGSizeMake(width, 40.0);
    }
}

@end
