// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Polling{
    /// @dev a polling sysyem where there are admins are they select candidates to be voted for in an
    /// @dev organisation for the president ,each admins choose one candidates to be voted for and the members can choose who to vote for
    /// @dev and after the election the result of the new president is set

    address president;
    address[] public admins;
    address[] public members;
    address[] public candidates;


    mapping(address => bool) public isAdmin;



  //members =  ["0x5B38Da6a701c568545dCfcB03FcB875f56beddC4","0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2", "0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db", "0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB", "0x617F2E2fD72FD9D5503197092aC168c91465E7f2"]
  /// admins = ["0xdD870fA1b7C4700F2BD7f44238821C26f7392148", "0x583031D1113aD414F02576BD6afaBfb302140225"]
    constructor(address[] memory _admins, address[] memory  _members , address _president){
        admins = _admins;
        for(uint256 i = 0; i < _admins.length; i++) {
            isAdmin[_admins[i]] = true;
        }
        members = _members;
        president = _president;
    }

    mapping(address => bool) Adminselect; 
    uint ID ;

    mapping(uint => uint) presidentsCounts; 

    function AdminsSelectorCandidates(address _candidate)  external{
        require(isAdmin[msg.sender], "not admin");
        require(Adminselect[msg.sender] == false, "selected before");
        bool candidate ;
        for(uint i = 0; i < members.length; i++){
            if(_candidate == members[i]){
                candidate = true;
                break ;
            }      
        } 
        require(candidate == true, "not candidate");
        candidates.push(_candidate);
        Adminselect[msg.sender] = true;
        ID++;
    }

    function startElection(uint id) external{
        require(admins.length == candidates.length, "all admins should vote");
        bool member ;
        for(uint i = 0; i < members.length; i++){
            if(msg.sender == members[i]){
                member = true;
                break ;
            }      
        } 
        require(member == true, "not candidate");
        presidentsCounts[id] = presidentsCounts[id] + 1;
    }

    function announceResult() external view returns(uint winner){
        require(msg.sender == president, "only president can announce result");
        for(uint i = 0; i <= ID;  i++){
            if(winner > presidentsCounts[i]){
                winner = presidentsCounts[i];
            }
        }
    } 
} 
