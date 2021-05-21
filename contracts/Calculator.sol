// SPDX-License-Identifier: MIT

pragma solidity ^ 0.8.0;

import 'hardhat/console.sol';
import "@openzeppelin/contracts/utils/Address.sol";

contract Calculator {
  using Address for address payable;
  // storage
  uint256 private _profits;
  address private _owner;
  uint256 private _nbOperation;

  constructor() {
    _owner = msg.sender;
  }

  modifier havePaid() {
    require(msg.value == 1000000 gwei,"PayableCalculator: You have to pay 1 finney to do this function.");
    _;
  }

  modifier onlyOwner(){
    require(msg.sender == _owner, "PayableCalculator: You can't access this function.");
    _;
  }

  // function public
  function subNumbers(int256 number1, int256 number2)
  external
  payable
  havePaid
  returns(int256)
  {
    _calcTax(msg.value);
    _nbOperation++;
    return sub(number1, number2);
  }

  function addNumbers(int256 number1, int256 number2)
  external
  payable
  havePaid
  returns(int256)
  {
    _calcTax(msg.value);
    _nbOperation++;
    return add(number1, number2);
  }

  function mulNumbers(int256 number1, int256 number2)
  external
  payable
  havePaid
  returns(int256)
  {
    _calcTax(msg.value);
    _nbOperation++;
    return mul(number1, number2);
  }

  function divNumbers(int256 number1, int256 number2)
  external
  payable
  havePaid
  returns(int256)
  {
    require(number2 != 0, "PayableCalculator: Can't divide by 0");
    _calcTax(msg.value);
    _nbOperation++;
    return div(number1, number2);
  }

  function modNumbers(int256 number1, int256 number2)
  external
  payable
  havePaid
  returns(int256)
  {
    _calcTax(msg.value);
    _nbOperation++;
    return mod(number1, number2);
  }

  function withdraw() public onlyOwner {
    require(_profits != 0, "PayableCalculator: You can't withdraw 0");
    uint256 amountWithdrew = _profits;
    _profits = 0;
    payable(msg.sender).sendValue(amountWithdrew);
  }

  // function public view
  function nbOperation()public view returns(uint256){
    return _nbOperation;
  }

  function profits()public view returns(uint256){
    return _profits;
  }

  // function private
  function _calcTax(uint256 amount) private {
    _profits += amount;
  }

  // function pure
  function add(int256 number1, int256 number2) private pure returns(int256) {
    return number1 + number2;
  }

  function sub(int256 number1, int256 number2) private pure returns(int256) {
    return number1 - number2;
  }

  function mul(int256 number1, int256 number2) private pure returns(int256) {
    return number1 * number2;
  }

  function div(int256 number1, int256 number2) private pure returns(int256) {
    return number1 / number2;
  }

  function mod(int256 number1, int256 number2) private pure returns(int256) {
    return number1 % number2;
  }
}
