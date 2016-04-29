//
//  TableItem.h
//  AFDateHelperExtObjective-C
//
//  Created by Tassilo Lechner von Leheneck on 17/04/16.
//  Copyright © 2016 Tassilo Lechner von Leheneck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableItem : NSObject

@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *theDescription;

-(instancetype) initWithTitle: (NSString *) title theDescription: (NSString *) theDescription;

@end
