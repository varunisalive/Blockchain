// monkecoin ICO

//version of solidity
pragma solidity ^0.7.4;

contract monkecoin_ico {
    
    //Introducing max number of monkecoins available for sale
    uint public max_monekcoins = 1000000;
    
    //Introducting the USD to monkecoin conversion rate
    uint public usd_to_monkecoin = 1000;
    
    //Introducing the total number of monkecoins that have been bought by the investor
    uint public total_monkecoins_bought = 0;
    
    //Mapping from investor address to its equity in monkecoins and USD
    mapping(address => uint) equity_monkecoins;
    mapping(address => uint) equity_usd;
    
    //Checking if an investor can buy monkecoins
    modifier can_buy_monkecoins(uint usd_invested){
        require (usd_invested * usd_to_monkecoin + total_monkecoins_bought <= max_monekcoins);
        
    }
    
    //Getting equity in monkecoins of an investor
    function equity_in_monkecoins(address investor) external constant returns(uint){
        return equity_monkecoins[investor];
    }
    
    //Getting equity in USD of an investor
    function equity_in_usd(address investor) external constant returns(uint){
        return equity_usd[investor];
    }
    
    //Buying monkecoins
    function buy_monkecoins(address investor, uint usd_invested) external can_buy_monkecoins(usd_invested){
        uint monkecoins_bought = usd_invested * usd_to_monkecoin;
        equity_monkecoins[investor] += monkecoins_bought;
        equity_usd[investor] = equity_monkecoins[investor] / 1000;
        total_monkecoins_bought += monkecoins_bought;
    }
    
    //Selling monkecoins
    function sell_monkecoins(address investor, uint monkecoins_sold) external {
        equity_monkecoins[investor] -= monkecoins_sold;
        equity_usd[investor] = equity_monkecoins / 1000;
        total_monkecoins_bought -= monkecoins_sold;
    }
}