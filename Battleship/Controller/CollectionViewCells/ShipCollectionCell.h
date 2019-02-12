//
//  ShipCollectionCell.h
//  Battleship
//
//  Created by doxper on 30/01/19.
//  Copyright © 2019 Battleship. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ship.h"

@interface ShipCollectionCell : UICollectionViewCell

-(void)fillCellData:(NSInteger)tag withShip:(Ship*)ship isSelected:(BOOL)isSelected;
-(void)fillCellData:(NSInteger)tag withShip:(Ship*)ship;

@end
