//
//  BoardCollectionCell.m
//  Battleship
//
//  Created by doxper on 26/01/19.
//  Copyright © 2019 Battleship. All rights reserved.
//

#import "BoardCollectionCell.h"

@interface BoardCollectionCell() {
    
}
@end

@implementation BoardCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.borderColor = [[UIColor blackColor] CGColor];
    self.layer.borderWidth = 1.0;
}

-(void)fillCellData:(NSInteger)tag withBlock:(Block *)block isGameOn:(BOOL)isGameOn {
    self.tag = tag;
    if (!isGameOn) {
        [self.hitMissImageView setHidden:YES];
        if (block.ship != nil) {
            self.backgroundColor = block.ship.color;
        }
        else {
            self.backgroundColor = [UIColor whiteColor];
        }
    }
    else {
        [self updateHitMissImageViewForBlock:block];
        BOOL isShipFound = [block.ship found];
        self.backgroundColor = isShipFound ? block.ship.color : [UIColor whiteColor];
    }
}

-(void)updateHitMissImageViewForBlock:(Block*)block {
    self.backgroundColor = [UIColor whiteColor];
    if (block.isClicked) {
        [self.hitMissImageView setHidden:NO];
        if (block.isHit) {
            self.hitMissImageView.image = [UIImage imageNamed:@"Burn"];
        }
        else {
            self.hitMissImageView.image = [UIImage imageNamed:@"Miss"];
        }
    }
    else {
        [self.hitMissImageView setHidden:YES];
    }
}

@end
