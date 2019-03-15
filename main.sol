pragma solidity ^0.4.2; 

contract Main {
    address minter;
    function Main() public payable {
        minter = msg.sender;
    }
    uint public QOC = 0;
    uint private PRICE = 30;
    event print(string text, uint value);
    
    mapping (address => uint) public balances; 
    mapping (uint    => mapping (uint => string)) public Characters;
    mapping (uint    => address) public Owners;
    mapping (uint    => uint) public sellBoard;
    mapping (uint    => uint) public sellBoardPrices;


    
    function BuyByID(uint number) payable public{
        require(msg.value >= sellBoardPrices[number]);
        if(sellBoard[number] == 0) return;
        
        address lastOwner = Owners[number];
        lastOwner.transfer(msg.value);
        Owners[number] = msg.sender;
    }
    
    //## NOT WORKING
    function SellByID(uint number) public{
        require(msg.sender == Owners[number]);
        var seller = msg.sender;
        Owners[number] = minter;
        seller.transfer(PRICE);
        
    }

    
    function Fight(uint player1, uint player2) public returns (uint){
        var St1    = Characters[player1][1];
        var Ag1    = Characters[player1][2];
        var In1    = Characters[player1][3];
        var Power1 = (stringToUint(St1) + stringToUint(Ag1)) * stringToUint(In1);
        
        var St2    = Characters[player2][1];
        var Ag2    = Characters[player2][2];
        var In2    = Characters[player2][3];
        var Power2 = (stringToUint(St2) + stringToUint(Ag2)) * stringToUint(In2);
        
        if(Power1 >  Power2) return 1;
        if(Power1 <  Power1) return 2;
        if(Power1 == Power2) return 0;
    }
    
    function BuyNewCharacter() payable public{
        require(msg.value >= PRICE);
        uint payed = msg.value;
        
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
    
    function renameCharacter(uint id, string newName) public{
        require(msg.sender == Owners[id]);
        Characters[id][0] = newName;
    }
    
    function giftCharacter(uint id,address ToUser){
        require(msg.sender == Owners[id]);
        Owners[id] = ToUser;
    }
    
    function GetOwner(uint some) public returns (address) {
        return Owners[some];
    }
    
    function GetRandNumStr() private returns (string){
        var rand = uint(sha3(now)) % 10;
        if(rand == 0) rand += 1;
        return uint2str(rand); 
    }
    
    
    // ### Only Minter function!
    // By this function minter can change price of new character
    function ChangePrice(uint newPrice) public {
        require(msg.sender == minter);
        PRICE = newPrice;
    }
    
    // StackOverflow functions
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
    
    function stringToUint(string s) private constant returns (uint result) {
        bytes memory b = bytes(s);
        uint i;
        result = 0;
        for (i = 0; i < b.length; i++) {
            uint c = uint(b[i]);
            if (c >= 48 && c <= 57) {
                result = result * 10 + (c - 48);
            }
        }
    }
    
}
