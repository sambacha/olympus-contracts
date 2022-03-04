/// SPDX-License-Identifier: MPL-2.0
/// @author Sam Bacha <@sambacha>

pragma solidity >=0.5.17 <0.7.0;

import './DSDebugHelper.sol';
// import './<% contract_name %>.sol';


contract TestableTurboETH is TurboETH {

    event Log(string message);
    event LogUint(uint message);
    function log(string memory message) public {
        emit Log(message);
    }
    function logUint(uint message) public {
        emit LogUint(message);
    }

    // @function trackTotalRates
    function trackTotalRates(uint256 _value, uint256 _timestamp) public returns (bool)  {
        uint256 currentDay = _timestamp / DAY_IN_SECONDS;
        return _trackTotalRates(_value, currentDay);
    }
    // @function trackHolderRates
    function trackHolderRates(uint256 _value, uint256 _timestamp) public returns (bool) {
        uint256 currentDay = _timestamp / DAY_IN_SECONDS;
        return _trackHolderRates(_value, currentDay);
    }

}
