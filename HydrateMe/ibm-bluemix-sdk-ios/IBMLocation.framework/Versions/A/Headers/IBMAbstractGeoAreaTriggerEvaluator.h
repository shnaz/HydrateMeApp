//-------------------------------------------------------------------------------
// IBM Confidential OCO Source Materials
// XXXX-XXX Copyright IBM Corp. 2014
// The source code for this program is not published or otherwise
// divested of its trade secrets, irrespective of what has
// been deposited with the U.S. Copyright Office.
//-------------------------------------------------------------------------------
//
//  IBMAbstractGeoAreaTriggerEvaluator.h
//  IBMLocation

#import "IBMGeoTriggerEvaluator.h"
@class IBMAbstractGeoAreaTrigger;
@class IBMPosition;

/**
 * A trigger evaluator wrapper for {@link AbstractGeoAreaTrigger}
 */
@interface IBMAbstractGeoAreaTriggerEvaluator : IBMGeoTriggerEvaluator 

@property (readonly) BOOL shouldBeInside;

- (id) initWithTriggerDef:(IBMAbstractGeoAreaTrigger *)triggerDef shouldBeInside:(BOOL)shouldBeInside;
/**
	 * Updates location with regards to the area with the new location
	 * 
	 * @param position The new position
	 */
- (void) updatePosition : (IBMPosition*) position ;
/**
	 * @return <code>true</code> if after the last call to {@link GeoAreaTriggerEvaluator#updatePosition(IBMPosition)}
	 *         the user is inside the area, <code>false</code> if is outside area or in limbo.
	 */
- (BOOL) isInsideArea  ;
/**
	 * @return <code>true</code> if after the last call to {@link GeoAreaTriggerEvaluator#updatePosition(IBMPosition)}
	 *         the user is outside the area, <code>false</code> if is inside area or in limbo.
	 */
- (BOOL) isOutsideArea  ;
/**
	 * @return <code>true</code> iff after the last call to
	 *         {@link GeoAreaTriggerEvaluator#updatePosition(IBMPosition)} the user is neither outside nor inside the
	 *         area.
	 */
- (BOOL) isInLimbo  ;

@end

