pragma solidity ^0.4.0; 

import 'zeppelin-solidity/contracts/token/ERC20/MintableToken.sol';

contract Main {
    address public minter; 
    
    function Main() {
        minter = msg.sender;
    }
    
    mapping (address => uint) public balances; 
    mapping (uint => mapping (uint => uint)) public Characters;
    
    
    function send(address To, uint amount) {
        //if(balances[msg.sender] < amount) return;
        balances[msg.sender]    -= amount;
        balances[To]            += amount;
    } 
    
    function gift(address To, uint amount) payable{
       // msg.value 
        balances[To] += amount;
    }
    
    function BuyCharacter(){
        
        
    }
    
    function gen(){
        var St = GetRandNum();
        var Ag = GetRandNum();
        var In = GetRandNum();
        
        
    }
    
    function GetRandNum() returns (uint){
        var rand = uint(sha3(now)) % 10;
        if(rand == 0) rand += 1;
        return rand; 
    }
}
