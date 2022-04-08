// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.0 < 0.9.0;

import "./AirlineTicket.sol";

 contract BookingFactory {

    address public owner;

    constructor() {
        owner = msg.sender;
    }

        modifier onlyOwner(){
        require(msg.sender == owner,"Only owner can call this function");
        _;
    }

        enum Classes {First_class, Business_class, Economy_class}
        Classes public classType;

     function createBooking(string memory _name, string memory _destination, address _passportId, TicketBooking.Classes _type) public payable {
        
        TicketBooking ticketBooking = new TicketBooking();
        
        ticketBooking.addBooking(_name, _destination, _passportId, _type);
    }

    receive() payable external {
        
    }



 }

