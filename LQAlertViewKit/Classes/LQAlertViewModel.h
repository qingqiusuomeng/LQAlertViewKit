//
//  LQAlertViewModel.h
//  LQAlertViewKit
//
//  Created by purang on 2021/11/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LQAlertViewModel : NSObject
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *message;
@property (nonatomic,copy) NSString *leftTitle;
@property (nonatomic,copy) NSString *rightTitle;
@end

NS_ASSUME_NONNULL_END
