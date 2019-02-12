//
//  CreateBoardViewController.m
//  Battleship
//
//  Created by doxper on 26/01/19.
//  Copyright © 2019 Battleship. All rights reserved.
//

#import "CreateBoardViewController.h"
#import "BoardCollectionCell.h"
#import "ShipCollectionCell.h"
#import "Ship.h"
#import "BoardController.h"
#import "GameViewController.h"

@interface CreateBoardViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    __weak IBOutlet UICollectionView *boardCollectionView;
    __weak IBOutlet UISegmentedControl *playerSegmentedControl;
    
    BoardController *boardController;
    
    Board *currentBoard;
    NSInteger selectedShipIndex;
}
@end

@implementation CreateBoardViewController

#pragma mark View Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeView];
    [self addNotifications];
    boardController = [[BoardController alloc] init];
    currentBoard = boardController.boards.firstObject;
    selectedShipIndex = 0;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self showAlertWithTitle:@"Instructions" andMessage:@"1) Select Player from the top to create board.\n2) Select ship from below list to move.\n3)Selected ship will be moved to tapped location.\n4)Tap on the selected ship to rotate."];
}

#pragma mark Action Methods
- (IBAction)playerValueChanged:(UISegmentedControl *)sender {
    currentBoard = [boardController.boards objectAtIndex:sender.selectedSegmentIndex]; //sender.selectedSegmentIndex == 0 ? boardController.playerOneBoard : boardController.playerTwoBoard;
    selectedShipIndex = 0;
    [boardCollectionView reloadData];
}

- (IBAction)playButtonClicked:(UIButton *)sender {
    [self navigateToGameViewController];
}

- (IBAction)closeButtonClicked:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark Private Methods
-(void)initializeView {
    [boardCollectionView registerNib:[UINib nibWithNibName:@"BoardCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"BoardCollectionCell"];
    [boardCollectionView registerNib:[UINib nibWithNibName:@"ShipCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"ShipCollectionCell"];
}

-(void)addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unableToMoveBlock) name:@"unableToMoveBlock" object:nil];
}

-(void)unableToMoveBlock {
    Ship *selectedShip = (Ship*)[currentBoard.ships objectAtIndex:selectedShipIndex];
    NSString *shipName = @"block";
    if (selectedShip) {
        shipName = [NSString stringWithFormat:@"\"%@\"", [selectedShip.name uppercaseString]];
    }
    NSString *message = [NSString stringWithFormat:@"Unable to move %@ at this position", shipName];
    [self showAlertWithTitle:nil andMessage:message];
}

-(void)showAlertWithTitle:(NSString*)title andMessage:(NSString*)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark Navigation Methods
-(void)navigateToGameViewController {
    GameViewController *gameViewController = (GameViewController*)[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"GameViewController"];
    gameViewController.boardController = boardController;
    [self.navigationController pushViewController:gameViewController animated:YES];
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
        [boardCollectionCell fillCellData:indexPath.item withBlock:block isGameOn:NO];
        return boardCollectionCell;
    }
    else {
        ShipCollectionCell *shipCollectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShipCollectionCell" forIndexPath:indexPath];
        Ship *ship = [currentBoard.ships objectAtIndex:indexPath.item];
        [shipCollectionCell fillCellData:indexPath.item withShip:ship isSelected:indexPath.item == selectedShipIndex];
        return shipCollectionCell;
    }
}

#pragma mark UICollectionViewDelegate Methods
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        Ship *selectedShip = [currentBoard.ships objectAtIndex:selectedShipIndex];
        if (selectedShip) {
            [currentBoard moveShip:selectedShip toBlockNumber:indexPath.item];
            [collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
        }
    }
    else {
        selectedShipIndex = indexPath.item;
        [collectionView reloadSections:[NSIndexSet indexSetWithIndex:1]];
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

#pragma mark Dealloc
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
