// sky coin ico
pragma solidity ^0.5.1;
contract skycoin_ico{
    //introducing max number of coins
    uint public max_skycoins = 1000;
    uint public inr_to_skycoins = 100;

    // total coins bought
    uint public total_skycoins_bought = 0;

    mapping(address => uint) equity_skycoins;
    mapping(address => uint) equity_inr;

    //checking if an investor can buy skycoins

    modifier can_buy_skycoin(uint inr_invested){
        require (inr_invested * inr_to_skycoins + total_skycoins_bought <= max_skycoins);
        _;
    }

    //getting equity in skycoins
    function equity_in_skycoins(address investor) external view returns (uint){
        return equity_skycoins[investor];
    }

    // getting equity in inr
    function equity_in_inr(address investor) external view returns (uint){
        return equity_inr[investor];
    }

    // buy sky coins
    function buy_skycoins(address investor, uint inr_invested) external
    can_buy_skycoin(inr_invested)
    {
        uint skycoins_bought = inr_invested*inr_to_skycoins;
        equity_skycoins[investor] += skycoins_bought;
        equity_inr[investor] = equity_skycoins[investor] / 100;
        total_skycoins_bought += skycoins_bought;
    }

    //selling sky coins
    function sell_skycoins(address investor, uint skycoins_sold) external
    {
        equity_skycoins[investor] -= skycoins_sold;
        equity_inr[investor] = equity_skycoins[investor] / 100;
        total_skycoins_bought -= skycoins_sold;
    }

}