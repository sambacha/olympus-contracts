/// SPDX-License-Identifier: SSPL-1.0
pragma solidity >=0.5.8 <0.6.12
pragma experimental ABIEncoderV2;

/// @title TestableEVO
/// @dev NOT FOR MAINNET

import './ds-debug.sol';
import './evo.sol';


contract TestableEVO is EVO {
    /** @dev: TEST/DEBUG ONLY
     START BEGIN LOG  */
    event Log(string message);
    event LogUint(uint message);
    function log(string memory message) public {
        emit Log(message);
    }
    function logUint(uint message) public {
        emit LogUint(message);
    }

   /**!)(@dev:
    TEST/DEBUG ONLY
    END BEGIN LOG )(*/

    /** HALT END LOG */

    /**  @dev: TEST/DEBUG ONLY
    START BEGIN TRACK  */
    function trackTotalRates(uint256 _value, uint256 _timestamp) public returns (bool)  {
        uint256 currentDay = _timestamp / DAY_IN_SECONDS;
        return _trackTotalRates(_value, currentDay);
    }
    function trackHolderRates(uint256 _value, uint256 _timestamp) public returns (bool) {
        uint256 currentDay = _timestamp / DAY_IN_SECONDS;
        return _trackHolderRates(_value, currentDay);
    }
     /** HALT END LOG/TRACK */
}
