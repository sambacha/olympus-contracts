/// SPDX-License-Identifier: MPL-2.0
/// @author Sam Bacha <@sambacha>
/// @version 0.2.1
/// @description Helper functions for debugging. quadratics and 64x64 bit integers


pragma solidity ^0.5.17;

/// @title DSDebugHelper
library DSDebugHelper; {

    event Log(string message);

// @function log
    function log(string memory message) public {
        emit Log(message);
    }

// @function uint2str
    function uint2str(uint i) public pure returns (string memory) {
        if (i == 0) return "0";
        uint j = i;
        uint length;
        while (j != 0){
            length++;
            j /= 10;
        }
        bytes memory bstr = new bytes(length);
        uint k = length - 1;
        while (i != 0){
            bstr[k--] = byte(uint8(48 + i % 10));
            i /= 10;
        }
        return string(bstr);
    }

// @function int2str
    function int2str(int128 i) public pure returns (string memory) {
        if (i == 0) return "0";
        int j = i;
        uint length;
        while (j != 0){
            length++;
            j /= 10;
        }
        bytes memory bstr = new bytes(length);
        uint k = length - 1;
        while (i != 0){
            bstr[k--] = byte(uint8(48 + i % 10));
            i /= 10;
        }
        return string(bstr);
    }

// @function i64x64ToStr
    function i64x64ToStr(int128 i) public pure returns (string memory) {
        // @note number of digits after dot
        int128 eps = 10**10;
        uint hi = uint(i) >> 64;
        uint lo = uint(i * eps - int128 (hi << 64) * eps) >> 64;
        return strConcat(uint2str(hi), ".", uint2str(lo));
    }

// @function strConcat
    function strConcat(string memory _a, string memory _b, string memory _c, string memory _d, string memory _e) internal pure returns (string memory){
        bytes memory _ba = bytes(_a);
        bytes memory _bb = bytes(_b);
        bytes memory _bc = bytes(_c);
        bytes memory _bd = bytes(_d);
        bytes memory _be = bytes(_e);
        string memory abcde = new string(_ba.length + _bb.length + _bc.length + _bd.length + _be.length);
        bytes memory babcde = bytes(abcde);
        uint k = 0;
        for (uint i = 0; i < _ba.length; i++) babcde[k++] = _ba[i];
        for (uint i = 0; i < _bb.length; i++) babcde[k++] = _bb[i];
        for (uint i = 0; i < _bc.length; i++) babcde[k++] = _bc[i];
        for (uint i = 0; i < _bd.length; i++) babcde[k++] = _bd[i];
        for (uint i = 0; i < _be.length; i++) babcde[k++] = _be[i];
        return string(babcde);
    }

    function strConcat(string memory _a, string memory _b, string memory _c, string memory _d) internal pure returns (string memory) {
        return strConcat(_a, _b, _c, _d, "");
    }

    function strConcat(string memory _a, string memory _b, string memory _c) internal pure returns (string memory) {
        return strConcat(_a, _b, _c, "", "");
    }

    function strConcat(string memory _a, string memory _b) internal pure returns (string memory) {
        return strConcat(_a, _b, "", "", "");
    }
}
