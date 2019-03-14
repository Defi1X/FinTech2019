pragma solidity ^0.4.0; 

contract Main {
    address public minter;
    function Main() {
        minter = msg.sender;
    }
    uint public QOC = 0;
    
    mapping (address => uint) public balances; 
    mapping (uint => mapping (uint => string)) public Characters;
    
    
    
    function send(address To, uint amount) {
        if(balances[msg.sender] < amount) return;
        balances[msg.sender]    -= amount;
        balances[To]            += amount;
    } 
    
    function gift(address To, uint amount){
       // msg.value 
        balances[To] += amount;
    }
    
    function BuyCharacter() payable{
        /*var payed = msg.value;
        if(payed < 30){
            minter.transfer(payed); // error here
        } */
        
        gen();
        
    }
    
    function gen(){
        var Name  = "Hero";
        var St    = GetRandNumStr();
        var Ag    = GetRandNumStr();
        var In    = GetRandNumStr();
        var Owner = minter;
        var i     = 0;
        
        for(i = 0; i < 5; i++){
            // stoped here
            // Push all 5 params to mapping 'Characters'
        }
    }
    
    function GetRandNumStr() returns (string){
        var rand = uint(sha3(now)) % 10;
        
        if(rand == 0) rand += 1;
        
        return uint2str(rand); 
    }
    
    // StackOverflow function
    function uint2str(uint i) internal returns (string){
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
        bstr[k--] = byte(48 + i % 10);
        i /= 10;
    }
    return string(bstr);
    }
}
