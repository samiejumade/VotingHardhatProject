Voting Contract
This is a simple voting contract written in Solidity. It allows for the registration of voters and candidates, voting, and checking the status of the voting process.

Contract Structure
The contract contains two main structs: Voter and Candidate. Each has properties relevant to their roles in the voting process.

Functions
registerCandidate
This function allows a candidate to register for the election. It takes the candidate's name, party, age, and gender as parameters. The function checks if the candidate is not already registered, is not the election commissioner, is at least 18 years old, and if the registration is not full.

candidateVerification
This function checks if a candidate is already registered. It takes the candidate's address as a parameter and returns a boolean value.

candidateList
This function returns a list of all registered candidates.

voterRegister
This function allows a voter to register for the election. It takes the voter's name, age, and gender as parameters. The function checks if the voter is not already registered and is at least 18 years old.

voterVerification
This function checks if a voter is already registered. It takes the voter's address as a parameter and returns a boolean value.

voterList
This function returns a list of all registered voters.

vote
This function allows a registered voter to vote for a registered candidate. It takes the voter's ID and the candidate's ID as parameters. The function checks if the voter has not already voted, is registered, if the voting has started, and if the candidates have registered.

voteTime
This function sets the start and end time for the voting process. It can only be called by the election commissioner.

votingStatus
This function returns the current status of the voting process.

result
This function calculates and sets the winner of the election. It can only be called by the election commissioner.

emergency
This function stops the voting process. It can only be called by the election commissioner.

Modifiers
isVotingOver
This modifier checks if the voting process is over.

onlyCommissioner
This modifier checks if the function caller is the election commissioner.

Usage
To use this contract, deploy it on the Ethereum network. The address of the account that deploys the contract will be set as the election commissioner. The commissioner can then set the voting time, and users can register as voters or candidates. After the voting process starts, voters can vote for candidates. Once the voting process ends, the commissioner can calculate and set the winner.

# Voting Smart Contract

This is a smart contract for a decentralized voting system, written in Solidity.

## Structures

- `Voter`: Represents a voter, with a name, age, voter ID, gender, candidate ID they voted for, and their address.
- `Candidate`: Represents a candidate, with a name, party, age, gender, candidate ID, their address, and the number of votes they received.

## State Variables

- `voterDetails`: A mapping to store voter details by their unique identifiers.
- `candidateDetails`: A mapping to store candidate details by their unique identifiers.
- `nextVoterId`: The next available ID for a voter.
- `nextCandidateId`: The next available ID for a candidate.
- `startTime`: The start time of the voting period.
- `endTime`: The end time of the voting period.
- `stopVoting`: A boolean to stop the voting process.

## Functions

- `registerCandidate`: Function to register a new candidate.
- `candidateVerification`: Function to verify if a candidate is already registered.
- `candidateList`: Function to get the list of registered candidates.
- `voterRegister`: Function to register a new voter.
- `voterVerification`: Function to verify if a voter is already registered.
- `voterList`: Function to get the list of registered voters.
- `vote`: Function for a voter to vote for a candidate.
- `voteTime`: Function to set the start and end time of the voting period.
- `votingStatus`: Function to get the current status of the voting process.
- `result`: Function to calculate the result of the election.
- `emergency`: Function to stop the voting process in case of an emergency.

## License

This project is licensed under the MIT License.


```shell deploy contract on local network
npx hardhat clean 
npx hardhat compile
npx hardhat node
npx hardhat run scripts/deploy.js --network localhost
npx hardhat help
npx hardhat test
REPORT_GAS=true npx hardhat test
npx hardhat node
npx hardhat ignition deploy ./ignition/modules/Lock.js


```shell deploy contract on test sepolia network
npx hardhat clean 
npx hardhat compile
npx hardhat run scripts/deploy.js --network sepolia 
npx hardhat help
npx hardhat test
```