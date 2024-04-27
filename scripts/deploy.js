const { ethers } = require("hardhat");

async function main() {
    const VotingContract = await ethers.getContractFactory("VottingContract");
    const vottingContract = await VotingContract.deploy();

    console.log("VotingContract deployed to:", vottingContract.target);
}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });