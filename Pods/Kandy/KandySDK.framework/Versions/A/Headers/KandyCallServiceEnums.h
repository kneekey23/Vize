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

#define KANDY_TEST_CALL_TYPE_NAME @"testCall"
#define KANDY_CONTACT_SERVICE_CALL_TYPE_NAME @"serviceCall"

/**
 *  The call server error domain
 */
static NSString * const KandyCallServiceErrorDomain = @"CallServiceErrorDomain";

/**
 *  The errors the developer can get while using the call service
 */
typedef NS_ENUM(NSInteger, EKandyCallServiceError) {
    /**
     *  None
     */
    EKandyCallServiceError_none = 0,
    /**
     *  Unable to reject call
     */
    EKandyCallServiceError_unableToReject,
    /**
     *  There is only speaker in the device
     */
    EKandyCallServiceError_onlySpeakerAvailableInDevice,
    /**
     *  Unknown audio route
     */
    EKandyCallServiceError_unknownAudioRoute,
    /**
     *  No access to device microphone
     */
    EKandyCallServiceError_noMicrophoneAccess,
    /**
     *  No access to device camera
     */
    EKandyCallServiceError_noCameraAccess,
    /**
     *  Missing parameters for call
     */
    EKandyCallServiceError_missingParameters,
    /**
     *  Operation not available on pending call
     */
    EKandyCallServiceError_notAvailableOnPendingCall,
    /**
     *  For development
     */
    EKandyCallServiceError_count,
};

/**
 *  The camera positions
 */
typedef NS_ENUM(NSInteger, EKandyCameraPosition){
    /**
     *  camera at the back of the device
     */
    EKandyCameraPosition_back,
    /**
     *  camera at the front of the device
     */
    EKandyCameraPosition_front,
};

/**
 *  The camera orientation support
 */
typedef NS_ENUM(NSInteger, EKandyCameraOrientationSupport){
    /**
     *  No support orientation for camera
     */
    EKandyCameraOrientationSupport_none,
    /**
     *  Camera orientation reflects device orientation
     */
    EKandyCameraOrientationSupport_device,
    /**
     *  Camera orientation reflects status bar orientation
     */
    EKandyCameraOrientationSupport_statusBar,
};

/**
 *  The call type
 */
typedef NS_ENUM(NSInteger, EKandyCallType) {
    EKandyCallType_unknown = 0, /* Unknown call type */
    EKandyCallType_voip, /* VoIP call (ip to ip) */
    EKandyCallType_out, /* Out call (ip to GSM) */
    EKandyCallType_in, /* In call (GSM to ip) */
    EKandyCallType_SIP, /* SIP call (ip to sip) */
    EKandyCallType_GSM, /* GSM call (device GSM call) */
    EKandyCallType_service /* Special service call */
};

/**
 *  The call state
 */
typedef NS_ENUM(NSInteger, EKandyCallState) {
    EKandyCallState_initialized = 0, /* Initialized state */
    EKandyCallState_dialing, /* Waiting for network to reach the callee */
    EKandyCallState_sessionProgress, /* Conveying information about the progress of the call. Used to inform about recieving early media while ringing */
	EKandyCallState_ringing, /* Callee is found and ringing or current device got incoming call and pending decision */
    EKandyCallState_answering, /* Waiting for call to be connected */
	EKandyCallState_talking, /* Call session is in talking mode */
	EKandyCallState_terminated, /* Call has ended */
	EKandyCallState_notificationWaiting, /* Waiting for incoming call, got a call by push, but the system still not connected */
    EKandyCallState_unknown = 10 /* Unknown state of the call*/
};


/**
 *  The route by which we get the incoming audio
 */
typedef NS_ENUM(NSInteger, EKandyCallAudioRoute) {
    EKandyCallAudioRoute_unknown = 0, /* Audio route is not known */
    EKandyCallAudioRoute_receiver, /* Audio is transfered by receiver */
    EKandyCallAudioRoute_speaker, /* Audio is transfered by speaker */
    EKandyCallAudioRoute_bluetooth, /* Audio is transfered by bluetooth. Available for change only if bluetooth device is connected. */
    EKandyCallAudioRoute_headphone /* Audio is transfered by headphone. This is readOnly value. The user cant change to this value by code. This will be returned if user connected headset to its device. */
};

/**
 *  The options supplying for new outgoing call
 */
typedef NS_ENUM(NSInteger, EKandyOutgingVoIPCallOptions) {
    EKandyOutgingVoIPCallOptions_startCallWithoutVideo = 0, /* Outgoing call will start without video */
    EKandyOutgingVoIPCallOptions_startCallWithVideo, /* Outgoing call will start with video */
    EKandyOutgingVoIPCallOptions_audioOnlyCall, /* Outgoing call will be initialized as audio only, and cannot be upgraded to video in the future*/
};

/**
 *  The options supplying for new PSTN call
 */
typedef NS_ENUM(NSInteger, EKandyOutgingPSTNCallOptions) {
    EKandyOutgingPSTNCallOptions_none = 0, /* Regular PSTN call */
    EKandyOutgingPSTNCallOptions_blockedCallerID, /* PSTN call with blocked caller ID */
};

/**
 *  When getting a incoming call, how we should respond
 */
typedef NS_ENUM(NSInteger, EKandyIncomingCallAnswerType)
{
    EKandyIncomingCallAnswerType_none = 0, /* Should not respond */
    EKandyIncomingCallAnswerType_autoAnswer, /* Auto answer the call */
    EKandyIncomingCallAnswerType_pendingUserAnswer, /* The call is pending user answer */
    EKandyIncomingCallAnswerType_reject, /* The call needs to be rejected */
    EKandyIncomingCallAnswerType_ignore, /* The call needs to be ignored */
};

/**
 *  The orientation of the video call image we get from the other side
 */
typedef NS_ENUM(NSInteger, EKandyVideoCallImageOrientation) {
    EKandyVideoCallImageOrientation_portrait = 0,
    EKandyVideoCallImageOrientation_landscapeRight = 1,
    EKandyVideoCallImageOrientation_portraitUpsideDown = 2,
    EKandyVideoCallImageOrientation_landscapeLeft = 3,
    EKandyVideoCallImageOrientation_unknown = 4,
};

///**
// Reduced call termination reason. This exists cause the UI needs to show different message / screen for each reason.
// The full call termination reasons are mapped to this enum
// */
//typedef NS_ENUM(NSUInteger, ECallTerminationReason)
//{
//    ECallTerminationReason_UnknownError = 0,
//    ECallTerminationReason_UserLostConnection, /* The other side lost its connection */
//    ECallTerminationReason_CalleeInvalid, /* The callee we are calling is invalid */
//    ECallTerminationReason_CallEstablishError, /* Was unable to establish the call */
//    ECallTerminationReason_UserOffline, /* The user we are calling is offline */
//    ECallTerminationReason_RemoteHangup, /* Other side ended the call - can occur if the remote side calls the hangup method */
//    ECallTerminationReason_SelfHangup, /* Self hangup the call - can occur if you call the hangup method */
//    ECallTerminationReason_CallRejected, /* Call was rejected - can only be recieved by the rejecting side */
//    ECallTerminationReason_CallDeclined, /* Call was rejected by other side */
//    ECallTerminationReason_UnansweredCall, /* The other side did not answer the call */
//    ECallTerminationReason_NoCredit, /* User is out of credit */
//    ECallTerminationReason_CallIgnored, /* Call was ignored - can only be recieved by the ignoring side */
//};