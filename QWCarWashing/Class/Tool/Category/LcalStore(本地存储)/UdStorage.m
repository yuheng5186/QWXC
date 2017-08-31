//
//  UdStorage.m
//  AlgorithmicTrading
//
//  Created by tenly11 on 17/8/4.
//  Copyright © 2017年 tenly11. All rights reserved.
//

#import "UdStorage.h"

@implementation UdStorage
+(void)storageObject:(id)object forKey:(NSString*)key{
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    [ud setObject:object forKey:key];
    [ud synchronize];//同步
}

+(id)getObjectforKey:(NSString*)key{
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    return [ud objectForKey:key];
}
+(void)removeAllObjectKeys{
    
    NSUserDefaults *defatluts = [NSUserDefaults standardUserDefaults];
    NSDictionary *dictionary = [defatluts dictionaryRepresentation];
    for(NSString *key in [dictionary allKeys]){
        [defatluts removeObjectForKey:key];
        [defatluts synchronize];
    }
    
}
@end
