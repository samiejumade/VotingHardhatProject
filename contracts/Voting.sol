// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;
contract VottingContract{
    address electionComission;
    address public winner;

    struct Voter{
        string name;
        uint age;
        uint voterId;
        string gender;
        uint voterCondidateId;
        address voterAddress;
    }

    struct Candidate{
        string name;
        string party;
        uint age;
        string gender;
        uint candidateId;
        address candidateAddress;
        uint votes;
    }

    uint nextVoterId = 1;
    uint nextCandidateId = 1;
    uint startTime;
    uint endTime;

    mapping(uint =>Voter) voterDetails;
    mapping(uint => Candidate) candidateDetails;
    bool stopVoting;

constructor(){
    electionComission=msg.sender;
}

modifier isVotinOver(){
    require (block.timestamp> endTime || stopVoting == true, "Voting is not over");
    _;
}

modifier onlyComisioner(){
    require(electionComission == msg.sender, "not from election commision");
    _;
}

function registerCandidate(
    string calldata _name,
    string calldata _party,
    uint _age,
    string calldata _gender
)external{
    require(msg.sender!=electionComission,"You are from Elction Commision");
    require(candidateVerification(msg.sender),"You are already registerd");
    require(_age>=18,"You are not eligible");
    require(nextCandidateId<3,"Registration is full");
    candidateDetails[nextCandidateId]=Candidate( _name, _party,_age,_gender, nextCandidateId, msg.sender, 0);
    nextCandidateId++;
    
}

function candidateVerification(address _person)internal view returns(bool) {
    for(uint i=1; i<nextCandidateId; i++){
        if (candidateDetails[i].candidateAddress==_person){
            return false;
        }
    }
    return true;
}

//NextCandidaye = 2
function candidateList()public view returns(Candidate[]memory){
    Candidate[] memory array=new Candidate[](nextCandidateId-1);
    for(uint i=1; i<nextCandidateId;i++){
        array[i-1]=candidateDetails[i];
    }
    return array;
}

function voterRegister(string calldata _name, uint _age, string calldata _gender)external{
    require(voterVerification(msg.sender),"Voter are already registerd");
    require(_age>=18,"You are not eligible");
    voterDetails[nextVoterId]=Voter( _name,_age,nextVoterId, _gender, 0, msg.sender);
    nextVoterId++;

}

function voterVerification(address _person)internal view returns(bool){
for(uint i=1; i<nextVoterId; i++){
        if (voterDetails[i].voterAddress==_person){
            return false;
        }
    }
    return true;
}

function voterList()public view  returns(Voter[] memory){

     Voter[] memory array=new Voter[](nextVoterId-1);
    for(uint i=1; i<nextVoterId;i++){
        array[i-1]=voterDetails[i];
    }
    return array;
}

function vote(uint _voterId, uint _candidateId)external {
    require(voterDetails[_voterId].voterCondidateId==0,"You have already done voting");
    require(voterDetails[_voterId].voterAddress==msg.sender,"You are not registerd");
    require(startTime!=0,"Voting has not startd");
    require(nextCandidateId==3,"Candidate have not registerd");
    voterDetails[_voterId].voterCondidateId=_candidateId;
    candidateDetails[_candidateId].votes++;
}

function voteTime(uint _startTime, uint _endTime) external onlyComisioner{
    startTime = _startTime + block.timestamp;
    endTime = startTime + _endTime;
}

function votingStatus() public view returns(string memory){
if(startTime == 0){
    return "voting has not been started";
}else if((endTime > block.timestamp)  && stopVoting == false){
    return "Voting is going on";
}
else{
    return "Voting has been ended";
}
}

function result()external  onlyComisioner{
uint max;
for(uint i=1; i<nextCandidateId;i++){
    if(candidateDetails[i].votes>max){
        max=candidateDetails[i].votes;
        winner=candidateDetails[i].candidateAddress;
    }
}
}

function emergency()public onlyComisioner{
    stopVoting=true;
}
}