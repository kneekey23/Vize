/*
 * Copyright © 2016 GENBAND. All Rights Reserved.
 *
 * GENBAND CONFIDENTIAL. All information, copyrights, trade secrets
 * and other intellectual property rights, contained herein are the property
 * of GENBAND. This document is strictly confidential and must not be
 * copied, accessed, disclosed or used in any manner, in whole or in part,
 * without GENBAND's express written authorization.
 *
*/

#import <Foundation/Foundation.h>
#import "KandyEventProtocol.h"

@interface KandyPendingVoiceMail : NSObject <KandyEventProtocol>

/**
 *  Initializing method for KandyPendingVoiceMail
 *
 *  @param unreadMessages the number of unread messages in voicemail
 *  @param totalMessages  the total number of messages in voicemail
 *  @param aUuid          the event UUID
 *  @param aTimestamp     the event timestamp
 *
 *  @return Initialized KandyPendingVoiceMail
 */
-(instancetype)initWithUnreadMessagesCount:(NSInteger)unreadMessages totalMessagesCount:(NSInteger)totalMessages uuid:(NSString*)aUuid timestamp:(NSDate*)aTimestamp;

/**
 *  The number of unread messages in the voicemail
 */
@property (readonly) NSInteger unreadMessagesCount;
/**
 *  The total number of messages in voicemail
 */
@property (readonly) NSInteger totalMessagesCount;

@end
