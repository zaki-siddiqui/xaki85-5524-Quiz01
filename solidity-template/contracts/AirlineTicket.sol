// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.0 < 0.9.0;

 contract TicketBooking {

     address public owner;

     uint public bookingAmount;

     uint public economyPrice = 0.005 ether;
     uint public businessPrice = 0.007 ether;
     uint public firstclassPrice = 0.01 ether;
     
     event Received(address, uint);

     struct booking {
         string name;
         string destination;
         address passportId;  
         Classes bookingClasses;
         uint bookingPrice;
     }

    constructor(){
        owner = msg.sender;
    }

     modifier onlyOwner(){
        require(msg.sender == owner,"Only owner can call this function");
        _;
    }

    enum Classes {First_class, Business_class, Economy_class}
    Classes public bookingAirlineClasses;

    mapping (uint => booking) public userBookings;
    uint public userCount;

    mapping(address => uint) public allowedUsers;

    function addBooking(string memory _name, string memory _destination, address _passportId, Classes _type) public payable {
        
        booking storage userBooking = userBookings[userCount];
        uint _amount;

        userBooking.name = _name;
        userBooking.destination = _destination;
        userBooking.passportId = _passportId;
        userBooking.bookingClasses = _type;
        
        if(uint(_type) == 0)
        {
        userBooking.bookingPrice = economyPrice;
        _amount = economyPrice;
        }
        else if(uint(_type) == 1)
        {
        userBooking.bookingPrice = businessPrice;
        _amount = businessPrice;
        }
        else if(uint(_type) == 2)
        {
        userBooking.bookingPrice = firstclassPrice;
        _amount = firstclassPrice;
        } 

        bookingAmount += msg.value;
        userCount++;
        allowedUsers[msg.sender] = userCount;
        payable(msg.sender).transfer(_amount);
    }

    fallback() external {
        
    }

    receive() payable external {
        emit Received(msg.sender, msg.value);
    }

    function getBalance() external view returns(uint) {
        return address(this).balance;
    }

    function addAllowedUser(address _addr) public onlyOwner {
        allowedUsers[_addr] = userCount;
    }

    function removeALlowedUser(address _addr) public onlyOwner {
        delete allowedUsers[_addr];
    }

 }
