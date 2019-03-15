pragma solidity ^0.4.2; 

contract Main {
    address public minter;
    function Main() public {
        minter = msg.sender;
    }
    uint public QOC = 0;
    
    event print(string text, uint value);
    
    mapping (address => uint) public balances; 
    mapping (uint => mapping (uint => string)) public Characters;
    mapping (uint => address) public Owners;
    
    
    
    function send(address To, uint amount) private {
        if(balances[msg.sender] < amount) return;
        balances[msg.sender]    -= amount;
        balances[To]            += amount;
    }
    
    function gift(address To, uint amount) private{
       // msg.value 
        balances[To] += amount;
    }
    
    function BuyByID(uint number) payable public{
        require(msg.value >= 30);
        address lastOwner = Owners[number];
        lastOwner.transfer(msg.value);
        Owners[number] = msg.sender; 
    }
    
    function SellByID(uint number) payable public{
        require(msg.sender == Owners[number]);
        var seller = msg.sender;
        Owners[number] = minter;
        seller.transfer(30);
        
    }
    
    function BuyNewCharacter() payable public{
        require(msg.value >= 30);
        uint payed = msg.value;
       
        /*if(payed < 30){
            minter.transfer(payed); // warning here
        } */
        minter.transfer(payed);
        gen();
    }
    
    function gen() private{
        address Owner = msg.sender;
        var     Name  = "Hero";
        var     St    = GetRandNumStr();
        var     Ag    = GetRandNumStr();
        var     In    = GetRandNumStr();
        
        QOC += 1;
        
        
        Characters[QOC - 1][0] = Name;
        Characters[QOC - 1][1] = St;
        Characters[QOC - 1][2] = Ag;
        Characters[QOC - 1][3] = In;
        Owners[QOC - 1] = Owner;
        
        
        
        
    }
    
    function GetOwner(uint some) public returns (address) {
        return Owners[some];
    }
    
    function GetRandNumStr() private returns (string){
        var rand = uint(sha3(now)) % 10;
        if(rand == 0) rand += 1;
        return uint2str(rand); 
    }
    
    // StackOverflow function
    function uint2str(uint i) private returns (string){
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
    
    function AddtoString(address x) private returns (string)  {
        bytes memory b = new bytes(20);
        for (uint i = 0; i < 20; i++)
            b[i] = byte(uint8(uint(x) / (2**(8*(19 - i)))));
        return string(b);
    }
}
