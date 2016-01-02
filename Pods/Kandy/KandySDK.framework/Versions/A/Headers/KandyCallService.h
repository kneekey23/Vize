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
#import "KandyCallServiceNotificationDelegate.h"
#import "KandyOutgoingCallProtocol.h"
#import "KandyRecord.h"
#import "KandyCallServiceEnums.h"
#import "KandyCallServiceSettings.h"
/**
 * This interface handles listening to notifications
 */
@interface KandyCallService : NSObject

/**
 *  The available audio outputs (of type EKandyCallAudioRoute)
 */
@property (readonly) NSArray *availableAudioOutputs;

/**
 *  YES if currently in active call
 */
@property (readonly) BOOL isInCall;

/**
 *  YES if currently in active GSM call
 */
@property (readonly) BOOL isInGSMCall;

/**
 *  Get an array of calls currently in progress
 */
@property (readonly) NSArray* callsInProgress;

/**
 *  Start listening to notification on call service
 *
 *  @param notificationDelegate conforms to protocol KandyCallServiceNotificationDelegate
 */
-(void) registerNotifications:(id<KandyCallServiceNotificationDelegate>)notificationDelegate;

/**
 *  Stop listening to notification on call service
 *
 *  @param notificationDelegate conforms to protocol KandyCallServiceNotificationDelegate
 */
-(void) unregisterNotifications:(id<KandyCallServiceNotificationDelegate>)notificationDelegate;

/**
 *  Call service settings
 */
-(KandyCallServiceSettings*)settings;

/**
 *  Creates and returns an outgoing call object conforms to protocol KandyOutgoingCallProtocol
 *  Please call establishWithResponseBlock to initiate the call
 *  Note - You must set localVideoView and remoteVideoView in order to display video in VoIP call
 *
 *  @param caller       KandyRecord optional - contains the source details, nil for default caller
 *  @param callee       KandyRecord contaning the destination details
 *  @param outgoingCallOptions The options for initialized outgoing call
 *
 *  @return outgoing call object conforms to protocol KandyOutgoingCallProtocol
 */
-(id<KandyOutgoingCallProtocol>) createVoipCall:(KandyRecord*)caller callee:(KandyRecord*)callee options:(EKandyOutgingVoIPCallOptions)outgoingCallOption;


/**
 *  Creates and returns an outgoing PSTN call object conforms to protocol KandyOutgoingCallProtocol
 *  Please call establishWithResponseBlock to initiate the call
 *
 *  @param caller       NSString optional - contains the source details, nil for default caller
 *  @param internationalPhoneNumber international phone number string (e164 format)
 *  @param PSTNCallOption The options for initialized outgoing call
 *
 *  @return outgoing call object conforms to protocol KandyOutgoingCallProtocol
 */
-(id<KandyOutgoingCallProtocol>) createPSTNCall:(NSString*)caller destination:(NSString*)internationalPhoneNumber options:(EKandyOutgingPSTNCallOptions)PSTNCallOption;

/**
 *  Create SIPTrunk call
 *  Using makeSIPtrunkCall requires a SIP trunk to be configured for your domain in Kandy.
    Note that when a SIP trunk is configured, the makePSTNCall command will be disabled
 *
 *  @param caller       NSString optional - contains the source details, nil for default caller
 *  @param internationalPhoneNumber international phone number string (e164 format)
 *
 *  @return The outgoing call object, will return nil incase callee is invalid
 */
-(id<KandyOutgoingCallProtocol>) createSIPTrunkCall:(NSString*)caller destination:(NSString*)internationalPhoneNumber;

/**
 *  Associate DID
 *
 *  @param did              the DID
 *  @param responseCallback a callback that will be called upon completion. Will contain error incase of failure
 */
-(void)associateDID:(NSString*)did responseCallback:(void(^)(NSError* error))responseCallback;

/**
 *  Disassociate DID
 *
 *  @param did              the DID
 *  @param responseCallback a callback that will be called upon completion. Will contain error incase of failure
 */
-(void)disassociateDID:(NSString*)did responseCallback:(void(^)(NSError* error))responseCallback;
@end
